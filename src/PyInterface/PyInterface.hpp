#ifndef _PY_INTERFACE_H_
#define _PY_INTERFACE_H_

#include <string>
#include <vector>
#include <Python.h>
#include <iostream>

#include "../PIInc.h"
#include "../DataContext.hpp"

using namespace std;

class PyContext {
  public:
    void init();
    void prod(string &modelName, 
                vector<string> &loadNames, vector<string> &storeNames);

    void test(string &modelName, 
                vector<string> &loadNames, vector<string> &storeNames);
    PyObject *pModule;
    PyObject *pModuleName;
    PyObject *pModuleFunc;
    PyObject *sys;
    PyObject *path;

  private:
    PyObject *setNNInput(DataContext *pDC);
    void getNNOutput(PyObject *pValue, vector<string> &storeNames);

};

//void pyCaller(char *modelName, DPNNModelInfo *pIn, DPNNModelInfo *pOut);
//void pyRCaller(char *modelName, DPNNModelInfo *pIn, DPNNModelInfo *pOut);

extern PyContext *pyContext;

#endif
