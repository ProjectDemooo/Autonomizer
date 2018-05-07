#ifndef _PRIT_H_
#define _PRIT_H_

#include <stdarg.h>
#include "PIInc.h"

#ifdef __cplusplus

extern "C" {
  // Data length, dest, src
  typedef void (* CBPtr)(int, void *, va_list);

  void piLoad(const char *name, TypeID tID, int nmemb, void *data, bool doAlloc);
  void piLoadCB(const char *name, TypeID tID, int nmemb, CBPtr cb, ...);
  void piStore(const char *name, TypeID tID, int nmemb, void *data);
  void piNN(const char *name, NNStg stg, int loadNum, int storeNum, ...);
  void *piGetData(const char *name, int *nmemb);
  void piEnd();
  void piCheckpoint();
  void piRestore();
  int piGetCheckpointed();
}

#endif

#endif
