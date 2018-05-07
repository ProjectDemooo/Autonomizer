#include <stdio.h>
#include <assert.h>
#include <errno.h>
#include <unistd.h>

#include "CPIO.hpp"

extern int errno;

//
// Public implementations
//
int CPIO::cpRead(unsigned char *readBuf, int readLen)
{
  unsigned char *ptr = readBuf;

  while (readLen) {
    int readCnt = read(cpFD, (void *)ptr, readLen);
    
    readLen -= readCnt;
    ptr += readCnt;

    if (readCnt < readLen) {
      if (errno == EAGAIN || readCnt >= 0)
        continue;
      else {
        printf("Read error with fd=%d, errno=%d\n", cpFD, errno);
        assert(0);
      }
    }
  }

  return (int)(ptr - readBuf);
}
    
int CPIO::cpWrite(unsigned char *writeBuf, int writeLen)
{
  unsigned char *ptr = writeBuf;

  while (writeLen) {
    int writeCnt = write(cpFD, (void *)ptr, writeLen);
    
    writeLen -= writeCnt;
    ptr += writeCnt;

    if (writeCnt < writeLen) {
      if (errno == EAGAIN || writeCnt >= 0)
        continue;
      else {
        printf("Write error with fd=%d, errno=%d\n", cpFD, errno);
        assert(0);
      }
    }
  }

  return (int)(ptr - writeBuf);
}
