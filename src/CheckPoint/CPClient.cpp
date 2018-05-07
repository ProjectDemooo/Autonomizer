#include "CPClient.hpp"

//
// Public implementations
//
void CPClient::init()
{
  // Create file directory
  if (!ifstream(fileDir)) {
    if (mkdir(fileDir.c_str(), 0755) < 0) {
      printf("Cannot create directory %s\n", fileDir.c_str());
      assert(0);
    }
  }
}

int CPClient::start(string header)
{
  int cc = 0;

  // Open socket fd
  if ((clientFD = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
    printf("Open socket failed\n");
    assert(0);
  }
  
  bzero((char *) &serverAddr, sizeof(serverAddr));

  serverAddr.sin_family = AF_INET;
  serverAddr.sin_port = htons(CP_PORT);

  if (inet_pton(AF_INET, serverAddrStr.c_str(), &serverAddr.sin_addr) <= 0) {
    printf("Address %s not supported\n", serverAddrStr.c_str());
    assert(0);
  }

  if (connect(clientFD, (struct sockaddr *)&serverAddr, sizeof(serverAddr))) {
    printf("Connection failed\n");
    assert(0);
  }

  FD_ZERO(&readSockSet);
  FD_SET(clientFD, &readSockSet);
  
  // Initialize select timeout value to 1 second
  timeout.tv_sec = 1;
  timeout.tv_usec = 0;

  signal(SIGPIPE, SIG_IGN);
  if (header == "GET") {
    doGET();
  } else if (header == "SET") {
    doSET();
  } else if (header == "CKP") {
    cc = doCKP();
  } else if (header == "RES") {
    doRES();
  } else {
    printf("Unknown header = %s\n", header.c_str());
    assert(0);
  }

  shutdown(clientFD, SHUT_RDWR);
  close(clientFD);

  return cc;
}

//
// Private implementations
//
// Client receive files from server
void CPClient::doGET()
{
  CPIO sockIO(clientFD, "");

  sprintf((char *)buf, "GET");
  sockIO.cpWrite(buf, 3);

  while (true) {
    int status;

    status = select(FD_SETSIZE, &readSockSet, NULL, NULL, &timeout);

    if (status < 0) {             // Select failed
      printf("Select failed\n");
    } else if (status == 0) {     // Select timeout
      timeout.tv_sec = 1;
      timeout.tv_usec = 0;
      continue;
    }

    assert(FD_ISSET(clientFD, &readSockSet));

    // Start receiving files 
    // Header
    assert(sockIO.cpRead(buf, 3) == 3);
    
    string ts((char *)buf, 3);

    if (ts == "SET") {
      recvFile(sockIO);
    } else if (ts == "EOF") {
      // No more files, send END back and close connection
      sprintf((char *)buf, "END");
      sockIO.cpWrite(buf, 3);
      break;
    } else {
      printf("Unsupported Header:%s\n", ts.c_str());
      assert(0);
    }
  }
}

// Client send files to server
void CPClient::doSET()
{
  CPIO sockIO(clientFD, "");

  sendFile(sockIO);
  
  while (true) {
    int status;

    status = select(FD_SETSIZE, &readSockSet, NULL, NULL, &timeout);

    if (status < 0) {             // Select failed
      printf("Select failed\n");
    } else if (status == 0) {     // Select timeout
      timeout.tv_sec = 1;
      timeout.tv_usec = 0;
      continue;
    }

    assert(FD_ISSET(clientFD, &readSockSet));
    
    // Start receiving files 
    // Header
    assert(sockIO.cpRead(buf, 3) == 3);
    
    string ts((char *)buf, 3);

    printf("%s\n", ts.c_str());
   
    // Got END from server, close the connection
    if (ts == "END") {
      break;
    } else {
      printf("Unsupported Header:%s\n", ts.c_str());
      assert(0);
    }
  }
}

int CPClient::doCKP()
{
  int cc = 0;
  CPIO sockIO(clientFD, "");

  sprintf((char *)buf, "CKP");
  sockIO.cpWrite(buf, 3);
  
  while (true) {
    int status;

    status = select(FD_SETSIZE, &readSockSet, NULL, NULL, &timeout);

    if (status < 0) {             // Select failed
      printf("Select failed\n");
    } else if (status == 0) {     // Select timeout
      cc = 1;
      system("ping -c 2 192.168.122.1");
      break;
    }

    assert(FD_ISSET(clientFD, &readSockSet));
    
    // Start receiving files 
    // Header
    assert(sockIO.cpRead(buf, 3) == 3);

    string ts((char *)buf, 3);

    //printf("%s\n", ts.c_str());
   
    if (ts == "CKN") {
      break;
    } else if (ts == "CKY") {
      cc = 1;
      break;
    } else {
      printf("Unsupported Header:%s\n", ts.c_str());
      assert(0);
    }
  }

  return cc;
}

void CPClient::doRES()
{
  CPIO sockIO(clientFD, "");

  sprintf((char *)buf, "RES");
  sockIO.cpWrite(buf, 3);
}


// Send all local files
void CPClient::sendFile(CPIO &sockIO)
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
    
    printf("%s %s %d\n", localName.c_str(), fileName.c_str(), fileLen);

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
      int rwLen = min((unsigned int)sizeof(buf), fileLen);
      
      int readLen = fileIO.cpRead(buf, rwLen);
     
      assert(readLen == rwLen);

      int writeLen = sockIO.cpWrite(buf, readLen);

      assert(writeLen == rwLen);

      fileLen -= readLen;

      assert(fileLen >= 0);
    }

    close(fd);

    sent++;
  }

  // Send EOF after sending all files
  sprintf((char *)buf, "EOF");
  sockIO.cpWrite(buf, 3);
}

// Receive one file
void CPClient::recvFile(CPIO &sockIO)
{
  unsigned int fileNameLen, fileLen;

  // File name length
  assert(sockIO.cpRead(buf, 1) == 1);
  fileNameLen = (int) buf[0];

  // File length
  assert(sockIO.cpRead(buf, 4) == 4); 
  //fileLen = ntohl(*((unsigned int *)buf));
  fileLen = *((unsigned int *)buf);

  assert(sockIO.cpRead(buf, fileNameLen) == fileNameLen);

  string fileName = fileDir + '/' + string((char *)buf, fileNameLen);
  int fd = open(fileName.c_str(), O_CREAT | O_WRONLY | O_TRUNC, 0644);

  printf("%d %d %s\n", fileNameLen, fileLen, fileName.c_str());
  
  CPIO fileIO(fd, fileName);

  // Receive file
  while (fileLen) {
    int rwLen = min((unsigned int)sizeof(buf), fileLen);
    int readLen = sockIO.cpRead(buf, rwLen);
    
    assert(readLen == rwLen);

    int writeLen = fileIO.cpWrite(buf, readLen);

    assert(writeLen == rwLen);

    fileLen -= readLen;
  }

  close(fd);
}

// Test only
#if 0 
CPClient *cClient = NULL;
bool checkpointed = false;

void checkpoint()
{
  // Ask server whether user wants to checkpoint
  if (!checkpointed) {
    int cc = cClient->start("CKP");

    if (cc == 0)
      return;

    // Continue from checked point

    checkpointed = true;

    printf("continue\n");

    // TODO:Recevie previous data from server
  }
}

void restore()
{
  printf("restore, checkpointed=%d\n", checkpointed);
  if (!checkpointed)
    return;

  // TODO:Send newest data to server

  // Restore ...
  cClient->start("RES");
}

int main()
{
  cClient = new CPClient("192.168.122.1");

  cClient->init();

  int cnt = 0;

  while (true) {
    checkpoint();

    cnt++;
    sleep(1);
    printf("cnt=%d\n", cnt);

    if (cnt % 10 == 0 && cnt)
      restore();
  }
}

#endif
