#include <Python.h>
#include <numpy/arrayobject.h>
#include "PyCaller.h"


// Global python related information
static PyInfo gPyInfo = {0};

void pySetPredictedResult(PyObject *pValue, DPNNModelInfo *pOut)
{
  int i;
  char *pStr;
  PyObject *pTmp1, *pTmp2;

  for (i=0; i<pOut->num; i++) {
    pTmp1 = PyList_GetItem(pValue, i);
    pTmp2 = PyObject_Repr(pTmp1);
    pStr = PyString_AsString(pTmp2);

    switch (pOut->typeID[i]) {
      case dpC:
      {
        char *ptr = (char *) pOut->data[i];
        *ptr = atoi(pStr);
        break;
      }
      case dpS:
      {
        short *ptr = (short *) pOut->data[i];
        *ptr = atoi(pStr);
        break;
      }
      case dpI:
      {
        int *ptr = (int *) pOut->data[i];
        *ptr = atoi(pStr);
        break;
      }
      case dpL:
      {
        long long int *ptr = (long long int *) pOut->data[i];
        *ptr = atoll(pStr);
        break;
      }
      case dpUC:
      {
        unsigned char *ptr = (unsigned char *) pOut->data[i];
        *ptr = atoi(pStr);

        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case dpUS:
      {
        unsigned short *ptr = (unsigned short *) pOut->data[i];
        *ptr = atoi(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case dpUI:
      {
        unsigned int *ptr = (unsigned int *) pOut->data[i];
        *ptr = atoi(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case dpUL:
      {
        unsigned long long int *ptr = 
          (unsigned long long int *) pOut->data[i];
        *ptr = atoll(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case dpF:
      {
        float *ptr = (float *) pOut->data[i];
        *ptr = strtof(pStr, NULL);
        break;
      }
      case dpD:
      {
        double *ptr = (double *) pOut->data[i];
        *ptr = strtod(pStr, NULL);
        break;
      }
    }
  }
}

static PyObject *pySetInputParm(DPNNModelInfo *pIn, int idx) 
{
  PyObject *pValue = NULL;
  npy_intp nmemb = -1;

  switch (pIn->typeID[idx]) {
    case dpI:
    {
      int *ptr = (int *) pIn->data[idx];
      if (pIn->nmemb[idx] > 1) {
        nmemb = pIn->nmemb[idx];
        pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_INT, ptr);
      } else {
        pValue = (PyObject *) PyInt_FromLong(*ptr);
      }
      break;
    }
    case dpUI:
    {
      unsigned int *ptr = (unsigned int *) pIn->data[idx];
      if (pIn->nmemb[idx] > 1) {
        nmemb = pIn->nmemb[idx];
        pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_UINT, ptr);
      } else {
        pValue = (PyObject *) PyInt_FromLong(*ptr);
      }
      break;
    }
    case dpF:
    {
      float *ptr = (float *) pIn->data[idx];
      if (pIn->nmemb[idx] > 1) {
        nmemb = pIn->nmemb[idx];
        pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_FLOAT, ptr);
      } else {
        pValue = (PyObject *) PyFloat_FromDouble(*ptr);
      }
      break;

    }
    default:
      assert(0 && "Unknown parameter type");
  }

  assert(pValue && "Failed to set input parameter");
  return pValue;
}

void pyInit()
{
  Py_Initialize();

  gPyInfo.sys = PyImport_ImportModule("sys");
  gPyInfo.path = PyObject_GetAttrString(gPyInfo.sys, "path");
  
  PyList_Append(gPyInfo.path, PyString_FromString(DP_MOD_PATH));

  // Target python module name 
  gPyInfo.pModuleName = PyString_FromString("DpModelManager");
  
  if (!gPyInfo.pModuleName) {
    fprintf(stderr, "Failed to get module name: DpModelManager\n");
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Targe python module
  // gPyInfo.pModule = PyImport_Import(gPyInfo.pModuleName);
  gPyInfo.pModule = PyImport_ImportModule("DpModelManager");
 
  if (!gPyInfo.pModule) {
    fprintf(stderr, 
      "Failed to load python module DpModelManager from path: %s\n", 
      DP_MOD_PATH);
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Targe python function to execute
  gPyInfo.pModuleFunc = PyObject_GetAttrString(gPyInfo.pModule, "run");

  if (!gPyInfo.pModuleFunc ||
      !PyCallable_Check(gPyInfo.pModuleFunc)) 
  {
    fprintf(stderr, "Cannot execute module function: DpModelManager.run\n");
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Import numpy array
  import_array();
}


// Supervised learning
void pyCaller(char *modelName, DPNNModelInfo *pIn, DPNNModelInfo *pOut)
{
  PyObject *pArgs, *pValue;

  // Python module should be initialized before using
  assert(gPyInfo.pModule);

  // Python module function should be callable
  assert(gPyInfo.pModuleFunc && PyCallable_Check(gPyInfo.pModuleFunc));

  pArgs = PyTuple_New(4);

  pValue = (PyObject *) PyInt_FromLong(gDPNNContext.status);
  assert(pValue);
  PyTuple_SetItem(pArgs, 0, pValue);

  pValue = (PyObject *) PyString_FromString(DP_MOD_PATH);
  assert(pValue);
  PyTuple_SetItem(pArgs, 1, pValue);

  pValue = (PyObject *) PyString_FromString(modelName);
  assert(pValue);
  PyTuple_SetItem(pArgs, 2, pValue);

  pValue = (PyObject *) PyInt_FromLong(pIn->num);
  assert(pValue);
  PyTuple_SetItem(pArgs, 3, pValue);

  pValue = PyObject_CallObject(gPyInfo.pModuleFunc, pArgs);
  Py_DECREF(pArgs);

  if (pValue != NULL) {
    if (gDPNNContext.status == DP_NN_TRAIN) {
      Py_DECREF(pValue);
      //printf("Result of call: %ld\n", PyInt_AsLong(pValue));
    } else if (gDPNNContext.status == DP_NN_TEST) {
      // Get the predicted parameters from the trained model
      if (PyList_Check(pValue) == 1) {
        assert(PyList_Size(pValue) == pOut->num);
        pySetPredictedResult(pValue, pOut);
        Py_DECREF(pValue);
      } else {
        // Failed to predict the parameters with a model, return directly
        return;
      }
    } else {
      assert(0 && "Status should be DP_NN_TRAIN or DP_NN_TEST");
    }
  } else {
    Py_DECREF(gPyInfo.pModuleFunc);
    Py_DECREF(gPyInfo.pModule);
    PyErr_Print();
    assert(0 && "Call to python function DpModelManager.run failed");
  }
}

// Reinforcement learning 
void pyRCaller(char *modelName, DPNNModelInfo *pIn, DPNNModelInfo *pOut)
{
  PyObject *pArgs, *pValue;
  int argIdx = 0;
  int i;

  // Python module should be initialized before using
  assert(gPyInfo.pModule);

  // Python module function should be callable
  assert(gPyInfo.pModuleFunc && PyCallable_Check(gPyInfo.pModuleFunc));

  // 3 parms: status, module path, and model name
  // 1 parm: number of input parameters
  // N parms: input parameters
  // 1 parm: number of output parameters
  pArgs = PyTuple_New(3 + 1 + pIn->num + 1);

  pValue = (PyObject *) PyInt_FromLong(gDPNNContext.status);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(DP_MOD_PATH);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(modelName);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  // Input number
  pValue = (PyObject *) PyInt_FromLong(pIn->num);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  // Pass the input arguments
  for (i=0; i<pIn->num; i++) {
    pValue = pySetInputParm(pIn, i); 
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }

  // Output number
  pValue = (PyObject *) PyInt_FromLong(pOut->num);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = PyObject_CallObject(gPyInfo.pModuleFunc, pArgs);
  Py_DECREF(pArgs);

  if (pValue != NULL) {
    if (gDPNNContext.status == DP_NN_RTRAIN ||
        gDPNNContext.status == DP_NN_RTEST) 
    {
      // Get the predicted parameters from the model
      if (PyList_Check(pValue) == 1) {
        assert(PyList_Size(pValue) == pOut->num);
        pySetPredictedResult(pValue, pOut);
        Py_DECREF(pValue);
      } else {
        // Failed to predict the parameters with a model, return directly
        assert(0 && "Cannot get predicted value");
      }
    } else {
      assert(0 && "Status should be DP_NN_RTRAIN or DP_NN_RTEST");
    }
  } else {
    Py_DECREF(gPyInfo.pModuleFunc);
    Py_DECREF(gPyInfo.pModule);
    PyErr_Print();
    assert(0 && "Call to python function DpModelManager.run failed");
  }
}
