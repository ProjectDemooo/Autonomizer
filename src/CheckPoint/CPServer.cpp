#include <dirent.h>
#include <fcntl.h>
#include <string.h>
#include <csignal>

#include "CPServer.hpp"

//
// Public implementation
//
// Initialization
void CPServer::init()
{
  int flag = 1;

  printf("Start checkpoint server, PID = %d ...\n", getpid());
  
  // Create file directory
  if (!ifstream(fileDir)) {
    if (mkdir(fileDir.c_str(), 0755) < 0) {
      printf("Cannot create directory %s\n", fileDir.c_str());
      assert(0);
    }
  }

  // Open socket fd
  if ((serverFD = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
    printf("Open socket failed\n");
    assert(0);
  }

  bzero((char *) &serverAddr, sizeof(serverAddr));
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_addr.s_addr = INADDR_ANY;
  serverAddr.sin_port = htons(CP_PORT);

  // Set socket option
  if (setsockopt(serverFD, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag)) < 0) {
    printf("Set socket option failed\n");
    assert(0);
  }

  // Address binding
  if (bind(serverFD, (struct sockaddr *)&serverAddr, sizeof(serverAddr)) < 0) {
    printf("Address binding failed\n");
    assert(0);
  }

  // Listen to the socket 
  if (listen(serverFD, CP_LISTEN_MAX) < 0)
  {
    perror("listen");
    exit(EXIT_FAILURE);
  }

  printf("Begin listening to incoming connection request\n");

  // Initialize the set of active sockets
  FD_ZERO(&activeSockSet);
  FD_SET(serverFD, &activeSockSet);
  FD_SET(0, &activeSockSet);

  // Initialize select timeout value to 1 second
  timeout.tv_sec = 1;
  timeout.tv_usec = 0;

  signal(SIGPIPE, SIG_IGN);
}
// Start the server 
void CPServer::start()
{
  while (true) {
    int status;

    /* Block until input arrives on one or more active sockets. */
    readSockSet = activeSockSet;

    status = select(FD_SETSIZE, &readSockSet, NULL, NULL, &timeout);

    if (status == 0) {
      timeout.tv_sec = 1;
      timeout.tv_usec = 0;
      continue;
    } else if (status < 0) {
      printf("Select failed, errno = %d\n", errno);
      assert(0);
    }

    for (int i=0; i<FD_SETSIZE; i++) {
      if (!FD_ISSET(i, &readSockSet))
        continue;

      if (i == serverFD) {  // Incoming connection 
        int clientFD;
        struct sockaddr_in clientAddr;
        unsigned int clientAddrLen = sizeof(clientAddr);

        clientFD = accept(serverFD, (struct sockaddr *)&clientAddr, &clientAddrLen);

        if (clientFD < 0) {
          printf("Accept new connection failed\n");
          assert(0);
        }
        printf("SELECT:connect from host=%s, port=%u, sockfd=%d\n",
            inet_ntoa(clientAddr.sin_addr),
            ntohs(clientAddr.sin_port),
            clientFD);

        FD_SET(clientFD, &activeSockSet);

        // Set client socket timeout to 1 second
        struct timeval cto;
        cto.tv_sec = 1;
        cto.tv_usec = 1;

        if (setsockopt(clientFD, SOL_SOCKET, SO_RCVTIMEO, &cto, sizeof(cto)) < 0) {
          printf("Set socket option failed\n");
          assert(0);
        }
        
        if (setsockopt(clientFD, SOL_SOCKET, SO_SNDTIMEO, &cto, sizeof(cto)) < 0) {
          printf("Set socket option failed\n");
          assert(0);
        }

        continue;
      } else if (i == 0) {  // stdin
        string userIn;

        cin >> userIn;

        if (userIn == "checkpoint") {
          printf("Got checkpoint request from user\n");
          ckptReq = true;
        }
      } else {              // Incoming data
        serveClient(i);
        shutdown(i, SHUT_RDWR);
        close(i);
        FD_CLR(i, &activeSockSet);
      }
    }
  }
}

//
// Private implementation
//
// serveClient
int CPServer::serveClient(int clientFD)
{
  CPIO sockIO(clientFD, "");
  
  while (true) {
    // Header
    assert(sockIO.cpRead(buf, 3) == 3);

    string ts((char *)buf, 3);

    if (ts == "GET") {
      sendFile(sockIO);
    } else if (ts == "SET") {
      recvFile(sockIO);
    } else if (ts == "CKP") {
      handleCKP(sockIO);
      break;
    } else if (ts == "RES") {
      handleRES(sockIO);
      break;
    } else if (ts == "EOF") {
      // No more files, send END back and close connection
      sprintf((char *)buf, "END");
      sockIO.cpWrite(buf, 3);
      break;
    } else if (ts == "END") {
      break;
    } else {
      printf("Unsupported Header:%s\n", ts.c_str());
      assert(0);
    }
  }

  return 0;
}

// Send all local files
void CPServer::sendFile(CPIO &sockIO)
{
  DIR *pDir = opendir(fileDir.c_str());
  struct dirent *pEnt;
  int sent = 0;

  assert(pDir);

  // Open directory
  while ((pEnt = readdir(pDir)) != NULL) {
    string fileName(pEnt->d_name);

    if (fileName == ".." || fileName == ".")
      continue;

    string localName = fileDir + '/' + fileName;

    int fd = open(localName.c_str(), O_RDONLY);
    CPIO fileIO(fd, localName);
    unsigned int fileLen;
    struct stat st;

    fstat(fd, &st);

    fileLen = st.st_size;

    printf("%d %s %s %d\n", fd, localName.c_str(), fileName.c_str(), fileLen);
    
    sprintf((char *)buf, "SET");
    sockIO.cpWrite(buf, 3);

    buf[0] = (unsigned char) fileName.size();
    *((unsigned int *)&buf[1]) = fileLen;

    sockIO.cpWrite(buf, 5);

    // Send file name
    sprintf((char *)buf, "%s", fileName.c_str());
    sockIO.cpWrite(buf, fileName.size());

    // Send file
    while (fileLen) {
      int readLen = fileIO.cpRead(buf, min((unsigned int)sizeof(buf), fileLen));
      int writeLen = sockIO.cpWrite(buf, readLen);

      assert(readLen == writeLen);

      fileLen -= readLen;

      assert(fileLen >= 0);
    }

    close(fd);

    sent++;
  }

  closedir(pDir);

  sprintf((char *)buf, "EOF");
  sockIO.cpWrite(buf, 3);
}

// Receive one file
void CPServer::recvFile(CPIO &sockIO)
{
  unsigned int fileNameLen, fileLen;

  // File name length
  assert(sockIO.cpRead(buf, 1) == 1);
  fileNameLen = (int) buf[0];

  // File length
  assert(sockIO.cpRead(buf, 4) == 4); 
  fileLen = *((unsigned int *)buf);

  sockIO.cpRead(buf, fileNameLen);

  string fileName = fileDir + '/' +string((char *)buf, fileNameLen);
  int fd = open(fileName.c_str(), O_CREAT | O_WRONLY | O_TRUNC, 0644);
  
  printf("%d %d %s\n", fileNameLen, fileLen, fileName.c_str());

  CPIO fileIO(fd, fileName);

  // Receive file
  while (fileLen) {
    int readLen = sockIO.cpRead(buf, min((unsigned int)sizeof(buf), fileLen));
    int writeLen = fileIO.cpWrite(buf, readLen);

    assert(readLen == writeLen);

    fileLen -= readLen;
  }

  close(fd);
}

void CPServer::handleCKP(CPIO &sockIO)
{
  if (!ckptReq) {
    sprintf((char *)buf, "CKN");
    sockIO.cpWrite(buf, 3);
    return;
  }
  
  // Found exisiting snapshot for current domain, delete it
  if (checkSnapshot()) {
    sprintf((char *) buf, "virsh snapshot-delete %s %s",
      domainName.c_str(), snapName.c_str());

    system((const char *)buf);
  }

  // Create snapshot
  sprintf(
    (char *) buf, "virsh snapshot-create-as --domain %s --name %s",
      domainName.c_str(), snapName.c_str());
  
  system((const char *)buf);

  ckptReq = false;
  ckpted = true;

  sprintf((char *)buf, "CKY");
  sockIO.cpWrite(buf, 3);
}

void CPServer::handleRES(CPIO &sockIO)
{
  if (!ckpted)
    return;

  sprintf(
    (char *) buf, "virsh snapshot-revert --domain %s --snapshotname %s",
      domainName.c_str(), snapName.c_str());
  
  system((const char *)buf);
}

bool CPServer::checkSnapshot()
{
  virConnectPtr pCon;
  int domainNum;
  int actDomains[8];
  bool hasSnap = false;
  bool hasDomain = false;

  pCon = virConnectOpen(NULL); 
  
  assert(pCon); 
  
  domainNum = virConnectNumOfDomains(pCon);
  domainNum = virConnectListDomains(pCon, actDomains, domainNum);
  assert(domainNum < 8);

  for (int i=0; i<domainNum; i++) {
    virDomainPtr pDom = virDomainLookupByID(pCon, actDomains[i]);

    string dName(virDomainGetName(pDom)); 

    if (!(dName == domainName)) 
      continue;

    hasDomain = true;

    int snapNum = virDomainSnapshotNum(pDom, 0xFF);
    char *snapNames[8];

    assert(snapNum < 8);

    virDomainSnapshotListNames(pDom, snapNames, snapNum, 0xFF);
    
    for (int j=0; j<snapNum; j++) {
      string sName(snapNames[j]);

      if (!(sName == "snap"))
        continue;

      hasSnap = true;
    }
  }
  
  virConnectClose(pCon);

  // Make sure domain exist
  assert(hasDomain);

  return hasSnap;
}

int main()
{
  CPServer *cpServer = new CPServer();

  cpServer->init();
  cpServer->start();

  return 0;
}
