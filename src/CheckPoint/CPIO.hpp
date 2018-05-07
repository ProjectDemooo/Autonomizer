#ifndef _CPIO_HPP_
#define _CPIO_HPP_

#include <string>
#include <assert.h>

#define CP_PORT 9999
// Only one connection at a time
#define CP_LISTEN_MAX 1
#define CP_BUF_SIZE 256

using namespace std;

class CPIO {
  public:

    CPIO(int fd, string file) {
      if (fd <= 2) {
        if (file.size())
          printf("Invalid file descriptor %d of file %s\n",
            fd, file.c_str());
        else
          printf("Invalid socket descriptor %d\n", fd);

        assert(0);
      }

      cpFD = fd;
    }

    int cpRead(unsigned char *readBuf, int readLen);
    int cpWrite(unsigned char *writeBuf, int writeLen);

  private:
    
    int cpFD = -1;
};

#endif
