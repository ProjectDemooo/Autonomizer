#ifndef _CPSERVER_HPP_
#define _CPSERVER_HPP_

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
#include <libvirt/libvirt.h>

#include "CPIO.hpp"

using namespace std;

class CPServer {
  public:
    CPServer() { 
      fileDir = string(".ckptServer"); 
    }

    CPServer(string dir) {
      fileDir = dir;
    }

    void init();
    void start();

  private:
    int serveClient(int clientFD);
    void sendFile(CPIO &sockIO);
    void recvFile(CPIO &sockIO);
    void handleCKP(CPIO &sockIO);
    void handleRES(CPIO &sockIO);

    bool checkSnapshot();

    // Select timeout
    struct timeval timeout;
    fd_set activeSockSet, readSockSet;
    int serverFD;
    struct sockaddr_in serverAddr;
    unsigned char buf[CP_BUF_SIZE];
    string fileDir;
    string domainName = "ubuntu16";
    string snapName = "snap";
    // Checkpoint request from user
    bool ckptReq = false;

    // Whether current system is checkpointed or not
    bool ckpted = false;
};

#endif
