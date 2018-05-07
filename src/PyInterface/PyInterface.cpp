#include <Python.h>
#include <numpy/arrayobject.h>
#include "PyInterface.hpp"
#include "../ProgIntel.hpp"

void PyContext::init()
{
  Py_Initialize();

  sys = PyImport_ImportModule("sys");
  path = PyObject_GetAttrString(sys, "path");
  
  PyList_Append(path, PyString_FromString(PY_MOD_PATH));

  // Target python module name 
  pModuleName = PyString_FromString("PIModelManager");
  
  if (!pModuleName) {
    fprintf(stderr, "Failed to get module name: PIModelManager\n");
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Targe python module
  // gPyInfo.pModule = PyImport_Import(gPyInfo.pModuleName);
  pModule = PyImport_ImportModule("PIModelManager");
 
  if (!pModule) {
    fprintf(stderr, 
      "Failed to load python module PIModelManager from path: %s\n", 
      PY_MOD_PATH);
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Targe python function to execute
  pModuleFunc = PyObject_GetAttrString(pModule, "run");

  if (!pModuleFunc ||
      !PyCallable_Check(pModuleFunc)) 
  {
    fprintf(stderr, "Cannot execute module function: PIModelManager.run\n");
    
    if (PyErr_Occurred())
      PyErr_Print();
    
    assert(0);
  }

  // Import numpy array
  import_array();
}

void PyContext::prod(string &modelName, 
                      vector<string> &loadNames, vector<string> &storeNames)
{
  PyObject *pArgs, *pValue;
  int argIdx = 0;

  assert(piContext->status == PI_SPROD || piContext->status == PI_RPROD);

  // Python module should be initialized before using
  assert(pModule);

  // Python module function should be callable
  assert(pModuleFunc && PyCallable_Check(pModuleFunc));

  // 5 parms: status, module path, model name, # load data, and # stroe data
  pArgs = PyTuple_New(5 + loadNames.size() * 2 + storeNames.size());
  
  pValue = (PyObject *) PyInt_FromLong(piContext->status);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(PY_MOD_PATH);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(modelName.c_str());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyInt_FromLong(loadNames.size());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);
  
  pValue = (PyObject *) PyInt_FromLong(storeNames.size());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  // N parms: load data names
  for (int i=0; i<loadNames.size(); i++) {
    pValue = (PyObject *) PyString_FromString(loadNames[i].c_str());
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }

  // N parms: load data nmembs 
  for (int i=0; i<loadNames.size(); i++) {
    pValue = (PyObject *) PyInt_FromLong(piContext->loadMap[loadNames[i]]->nmemb);
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }
  
  // N parms: store data names
  for (int i=0; i<storeNames.size(); i++) {
    pValue = (PyObject *) PyString_FromString(storeNames[i].c_str());
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }
  
  pValue = PyObject_CallObject(pModuleFunc, pArgs);
  Py_DECREF(pArgs);

  if (pValue != NULL) {
    Py_DECREF(pValue);
  } else {
    Py_DECREF(pModuleFunc);
    Py_DECREF(pModule);
    PyErr_Print();
    printf("Failed to execute python function PIModelManager.run for model %s\n",
      modelName.c_str());
  }
}

void PyContext::test(string &modelName, 
                      vector<string> &loadNames, vector<string> &storeNames)
{
  PyObject *pArgs, *pValue;
  int argIdx = 0;

  assert(piContext->status == PI_TEST || piContext->status == PI_TRAIN);

  // Python module should be initialized before using
  assert(pModule);

  // Python module function should be callable
  assert(pModuleFunc && PyCallable_Check(pModuleFunc));

  // 5 parms: status, module path, model name, # load data, and # stroe data
  pArgs = PyTuple_New(5 + loadNames.size() * 2 + storeNames.size() * 2);
  
  pValue = (PyObject *) PyInt_FromLong(piContext->status);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(PY_MOD_PATH);
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyString_FromString(modelName.c_str());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  pValue = (PyObject *) PyInt_FromLong(loadNames.size());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);
  
  pValue = (PyObject *) PyInt_FromLong(storeNames.size());
  assert(pValue);
  PyTuple_SetItem(pArgs, argIdx++, pValue);

  // N parms: load data name
  for (int i=0; i<loadNames.size(); i++) {
    pValue = (PyObject *) PyString_FromString(loadNames[i].c_str());
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }
  
  // N parms: load data 
  for (int i=0; i<loadNames.size(); i++) {
    DataContext *pDC = piContext->loadMap[loadNames[i]];
    pValue = setNNInput(pDC); 
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }
  
  // N parms: store data name
  for (int i=0; i<storeNames.size(); i++) {
    pValue = (PyObject *) PyString_FromString(storeNames[i].c_str());
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }
 
  // N parms: store data 
  for (int i=0; i<storeNames.size(); i++) {
    DataContext *pDC = piContext->storeMap[storeNames[i]];
    pValue = setNNInput(pDC); 
    assert(pValue);
    PyTuple_SetItem(pArgs, argIdx++, pValue);
  }

  pValue = PyObject_CallObject(pModuleFunc, pArgs);
  Py_DECREF(pArgs);

  if (pValue) {
#if 0
    if (PyList_Check(pValue) == 1) {
      assert(PyList_Size(pValue) == storeNames.size() && 
        "Store data number mistmatch with neural network returned results");
      //getNNOutput(pValue, storeNames);
      Py_DECREF(pValue);
    } else {
      // Failed to predict the parameters with a model, return directly
      printf("Failed to get predicted data\n");
      return;
    }
#endif
    Py_DECREF(pValue);
  } else {
    Py_DECREF(pModuleFunc);
    Py_DECREF(pModule);
    PyErr_Print();
    printf("Failed to execute python function PIModelManager.run for model %s\n",
      modelName.c_str());
    assert(0);
  }
}

//
// Private implementations
//
PyObject *PyContext::setNNInput(DataContext *pDC)
{
  PyObject *pValue = NULL;
  npy_intp nmemb = pDC->nmemb;

  assert(pDC && "DataContext should exist");

  switch (pDC->tID) {
    case PIT_C:
    {
      char *ptr = (char *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_INT8, ptr);
      break;
    }
    case PIT_UC:
    {
      unsigned char *ptr = (unsigned char *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_UINT8, ptr);
      break;
    }
    case PIT_I:
    {
      int *ptr = (int *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_INT, ptr);
      break;
    }
    case PIT_UI:
    {
      unsigned int *ptr = (unsigned int *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_UINT, ptr);
      break;
    }
    case PIT_F:
    {
      float *ptr = (float *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_FLOAT, ptr);
      break;

    }
    case PIT_D:
    {
      double *ptr = (double *) pDC->data;
      pValue = (PyObject *) PyArray_SimpleNewFromData(1, &nmemb, NPY_DOUBLE, ptr);
      break;

    }
    default:
      assert(0 && "Unknown parameter type");
  }

  assert(pValue && "Failed to set input parameter");
  return pValue;
}
    
void PyContext::getNNOutput(PyObject *pValue, vector<string> &storeNames)
{
  for (int i=0; i<storeNames.size(); i++) {
    PyObject *pTmp1 = PyList_GetItem(pValue, i); 
    PyObject *pTmp2 = PyObject_Repr(pTmp1);
    char *pStr = PyString_AsString(pTmp2);
  
    DataContext *pDC = piContext->storeMap[storeNames[i]]; 

    assert(pDC && "DataContext should exist in the map");
    assert(pDC->data && "Memory space should be allocated for store data");

    switch (pDC->tID) {
      case PIT_C:
      {
        char *ptr = (char *) pDC->data;
        *ptr = atoi(pStr);
        break;
      }
      case PIT_S:
      {
        short *ptr = (short *) pDC->data;
        *ptr = atoi(pStr);
        break;
      }
      case PIT_I:
      {
        int *ptr = (int *) pDC->data;
        *ptr = atoi(pStr);
        break;
      }
      case PIT_L:
      {
        long long int *ptr = (long long int *) pDC->data;
        *ptr = atoll(pStr);
        break;
      }
      case PIT_UC:
      {
        unsigned char *ptr = (unsigned char *) pDC->data;
        *ptr = atoi(pStr);

        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case PIT_US:
      {
        unsigned short *ptr = (unsigned short *) pDC->data;
        *ptr = atoi(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case PIT_UI:
      {
        unsigned int *ptr = (unsigned int *) pDC->data;
        *ptr = atoi(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case PIT_UL:
      {
        unsigned long long int *ptr = 
          (unsigned long long int *) pDC->data;
        *ptr = atoll(pStr);
        
        if (*ptr < 0)
          *ptr = 0;
        break;
      }
      case PIT_F:
      {
        float *ptr = (float *) pDC->data;
        *ptr = strtof(pStr, NULL);
        break;
      }
      case PIT_D:
      {
        double *ptr = (double *) pDC->data;
        *ptr = strtod(pStr, NULL);
        break;
      }
      default:
        assert(0 && "Unknown data type");
    }
  }
}
