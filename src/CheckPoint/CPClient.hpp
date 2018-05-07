#ifndef _CPCLIENT_HPP_
#define _CPCLIENT_HPP_

#include <dirent.h>
#include <fcntl.h>
#include <string.h>
#include <algorithm>

#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <assert.h>
#include <strings.h>
#include <signal.h>
#include <unistd.h>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <iostream>
#include <fstream>

#include "CPIO.hpp"

using namespace std;

class CPClient {
  public:
    CPClient(string addrStr) { 
      fileDir = string(".ckptClient");
      serverAddrStr = addrStr;
    }

    CPClient(string addrStr, string dir) {
      fileDir = dir;
      serverAddrStr = addrStr;
    }

    void init();
    int start(string header);

  private:
    void doGET();
    void doSET();
    int doCKP();
    void doRES();
    void sendFile(CPIO &sockIO);
    void recvFile(CPIO &sockIO);

    // Select timeout
    struct timeval timeout;
    fd_set readSockSet;
    int clientFD;
    string serverAddrStr;
    struct sockaddr_in serverAddr;
    unsigned char buf[CP_BUF_SIZE];
    string fileDir;
};

#endif
