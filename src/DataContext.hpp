#ifndef _DATA_CTX_HPP
#define _DATA_CTX_HPP

#include <vector>
#include "ProgIntel.h"

using namespace std;

class DataContext {
  public:
    // Constructor for using original data
    DataContext(TypeID tID, int nmemb, bool doAlloc) {
      this->tID = tID;
      this->nmemb = nmemb;
      this->doAlloc = doAlloc;
      
      if (doAlloc) {
        int tSize = getTypeSize(tID);
        
        this->data = (void *) malloc(tSize * nmemb);
      } 
    };

    void setData(void *data) {
      assert(data && "data cannot be NULL");

      if (doAlloc) {
        int tSize = getTypeSize(tID);
        
        memcpy(this->data, data, tSize * nmemb);
      } else {
        this->data = data;
      }
    }

    void *get() {
      return this->data;
    }

    static unsigned int getTypeSize(TypeID tID) {
      switch (tID) {
        case PIT_C:
        case PIT_UC:
          return 1;
        case PIT_S:
        case PIT_US:
          return 2;
        case PIT_I:
        case PIT_UI:
        case PIT_F:
          return 4;
          break;
        case PIT_L:
        case PIT_UL:
        case PIT_D:
          return 8;
        default:
          assert(0 && "Unknown data type");
          return -1;
      }
    }

    TypeID tID;
    int nmemb;
    void *data;
    bool doAlloc;

    // Combined load data
    vector<DataContext *> combinedLoad;
};

#endif
