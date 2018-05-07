#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <iostream>
#include <stdarg.h>
#include <sys/wait.h>

#include "ProgIntel.hpp"
#include "ProgIntel.h"
#include "FileIO.hpp"
#include "PyInterface/PyInterface.hpp"
#include "CheckPoint/CPClient.hpp"

PIContext *piContext = NULL;
FileIO *fileIO = NULL;
PyContext *pyContext = NULL;
CPClient *cpClient = NULL;

extern int main(int argc, const char *argv[]);

// Public implementations
void __attribute__ ((constructor)) piInit(int argc, char *argv[])
{
	printf("PROGRAM INTEL BEGIN:%d\n", getpid());
  
  piContext = new PIContext();
  fileIO = new FileIO();
  pyContext = new PyContext();

  piContext->init(argc, argv);
}

void __attribute__ ((destructor)) piFini()
{
  piContext->fini();
	printf("PROGRAM INTEL END:%d\n", getpid());
}

PIContext::PIContext()
  : status(PI_NONE),
  mainArgs(0),
  trainArgs(0), validArgs(0),
  trainFile(NULL), validFile(NULL), cfgFile(NULL),
  modelNum(0),
  checkpointed(0)
{
  statusInfo = {
    "PI_NONE",
    "PI_PROD",
    "PI_SPROD",
    "PI_RPROD",
    "PI_TRAIN",
    "PI_VALID",
    "PI_TEST",
    "PI_RTEST",
  }; 
}

void PIContext::init(int argc, char **argv)
{
  parseArgv(argc, argv); 

  if (status != PI_TRAIN &&
      status != PI_TEST &&
      status != PI_SPROD &&
      status != PI_RPROD)
    return;

  pyContext->init();

  if (status == PI_SPROD) {
    printf("Production run for supervised learning\n");
    sprodInit(argc, argv);
    printf("PROGRAM INTEL END:%d\n", getpid());
    exit(0);
  } else if (status == PI_RPROD) {
    printf("Production run for reinforcement learning\n");
    rprodInit(argc, argv);
  } else if (status == PI_TRAIN) {
    fileIO->runtimeInit();
    runtimeInit();
    cpClient = new CPClient("192.168.122.1");
    cpClient->init();
  } else if (status == PI_TEST) {
    fileIO->runtimeInit();
    runtimeInit();
  }
}

void PIContext::fini()
{
}

// Load input data
// doAlloc: 
// true - allocate new memory, false - use original data 
void PIContext::load(string &name, TypeID tID, int nmemb, void *data, 
                      bool doAlloc)
{
  if (status != PI_SPROD &&
      status != PI_RPROD &&
      status != PI_TRAIN &&
      status != PI_TEST)
    return;

  DataContext *pDC;
  if (loadMap.find(name) == loadMap.end()) {
    pDC  = new DataContext(tID, nmemb, doAlloc);
    loadMap[name] = pDC;
  } else
    pDC = loadMap[name];

  pDC->setData(data);
}

// Load input data with callback
void PIContext::loadCB(string &name, TypeID tID, int nmemb, CBPtr cb, va_list vl)
{
  if (status != PI_SPROD &&
      status != PI_RPROD &&
      status != PI_TRAIN &&
      status != PI_TEST)
    return;
  
  DataContext *pDC;

  if (loadMap.find(name) == loadMap.end()) {
    pDC = new DataContext(tID, nmemb, true);
    loadMap[name] = pDC;
  } else
    pDC = loadMap[name];

  cb(nmemb, pDC->data, vl);
}

void PIContext::store(string &name, TypeID tID, int nmemb, void *data)
{
  if (status != PI_SPROD &&
      status != PI_RPROD &&
      status != PI_TRAIN &&
      status != PI_TEST)
    return;
 
  switch (status) {
    case PI_SPROD:
    {
      assert(storeModelMap.find(name) != storeModelMap.end() && 
          "Store data should exist in storeModelMap before "
          "reaching current position");

      auto p = storeModelMap[name];
      string modelName = p.first.first;
      NNStg stg = p.first.second;
      vector<string> &loadNames = p.second;
      
      DataContext *pDC;
      if (storeMap.find(name) == storeMap.end()) {
        pDC = new DataContext(tID, nmemb, true);
        storeMap[name] = pDC;
      } else
        pDC = storeMap[name];

      pDC->setData(data);

      if (itTrainArgs != trainArgs.end()) {
        if (stg == PIS_ONE)
          fileIO->prodWriteStoreData(modelName, 
            loadNames[0], 
            fileIO->piTrainDir, 
            itTrainArgs - trainArgs.begin(), name);
        else
          fileIO->prodWriteStoreData(modelName, 
            loadNames, 
            fileIO->piTrainDir, 
            itTrainArgs - trainArgs.begin(), name);
      } else if (itValidArgs != validArgs.end()) {
        if (stg == PIS_ONE)
          fileIO->prodWriteStoreData(modelName, 
            loadNames[0], 
            fileIO->piValidDir, 
            itValidArgs - validArgs.begin(), name);
        else
          fileIO->prodWriteStoreData(modelName, 
            loadNames, 
            fileIO->piValidDir, 
            itValidArgs - validArgs.begin(), name);
      }

      // Only let the first child process do it
      if (itTrainArgs == trainArgs.begin())
        fileIO->prodWriteStoreInfo(modelName, name, tID, nmemb, stg);

      break;
    }
    case PI_RPROD:
    {
      auto p = storeModelMap[name];
      string modelName = p.first.first;

      fileIO->prodWriteStoreInfo(modelName, name, tID, nmemb, PIS_ONE);
      break;
    }
    case PI_TRAIN:
      storeData(name, data);
      break;
    case PI_TEST:
      storeData(name, data);
      break;
    default:
      return;
  }
}

void PIContext::nn(string &modelName, NNStg stg, int loadNum, int storeNum, ...)
{
  if (status != PI_SPROD &&
      status != PI_RPROD &&
      status != PI_TRAIN &&
      status != PI_TEST)
    return;

	va_list vl;
  vector<string> loadNames;
  vector<string> storeNames;

	va_start(vl, storeNum);

  // Get all loaded data name
  for (int i=0; i<loadNum; i++) {
    string s = string(va_arg(vl, char *));

    loadNames.push_back(s);
  }

  // Get all stored data name
  for (int i=0; i<loadNum; i++) {
    string s = string(va_arg(vl, char *));
    
    storeNames.push_back(s);
  }

  va_end(vl);

  nnInternal(modelName, stg, loadNames, storeNames);
}

void PIContext::nn(string &modelName, NNStg stg, int loadNum, int storeNum, 
                    va_list vl)
{
  if (status != PI_SPROD &&
      status != PI_RPROD &&
      status != PI_TRAIN &&
      status != PI_TEST)
    return;

  vector<string> loadNames;
  vector<string> storeNames;
 
  // Get all loaded data name
  for (int i=0; i<loadNum; i++) {
    string s = string(va_arg(vl, char *));
    
    loadNames.push_back(s);
  }

  // Get all stored data name
  for (int i=0; i<storeNum; i++) {
    string s = string(va_arg(vl, char *));
    
    storeNames.push_back(s);
  }
  
  nnInternal(modelName, stg, loadNames, storeNames);
}

void PIContext::end()
{
  if (status == PI_SPROD || status == PI_RPROD) {
    exit(0);
  } 
}

// Only support training checkpoint and restore
void PIContext::checkpoint()
{
  if (status != PI_TRAIN)
    return;

  // Ask server whether user wants to checkpoint
  if (!checkpointed) {
    int cc = cpClient->start("CKP");

    if (cc == 0)
      return;

    // Continue from checked point
    checkpointed = 1;

    // Recevie previous data from server
    cpClient->start("GET");
  }
}

// Only support training checkpoint and restore
void PIContext::restore()
{
  if (status != PI_TRAIN)
    return;

  if (!checkpointed)
    return;

  // Send newest data to server
  cpClient->start("SET");

  // Restore ...
  cpClient->start("RES");
}

int PIContext::getCheckpointed()
{
  return checkpointed;
}


//
// Private implementations
//
void PIContext::parseArgv(int argc, char **argv)
{
  for (int i=0; i<argc; i++) {
    string s(argv[i]);

    if (s.find("--pi", 0) != string::npos) {
      if (s == "--pi-sprod") {
        status = PI_SPROD;
      } else if (s == "--pi-rprod") {
        status = PI_RPROD;
      } else if (s == "--pi-train") {
        status = PI_TRAIN;
      } else if (s == "--pi-test") {
        status = PI_TEST;
      } else if (s == "--pi-fcfg") {
        cfgFile = fopen(argv[++i], "r");
      } else if (s == "--pi-ftrain") {
        trainFile = fopen(argv[++i], "r");
      } else if (s == "--pi-fvalid") {
        validFile = fopen(argv[++i], "r");
      }
    }
  }
}

// Parse NN config file
void PIContext::parseCfg()
{
  char buf[256];

  while (fgets(buf, sizeof(buf), cfgFile)) {
    char *ptr = strtok(buf, " \n");

    if (strcmp(ptr, "MAIN-CMD:") == 0) { 
      while ((ptr = strtok(NULL, " \n")))
        mainArgs.push_back(string(ptr));

    } else if (strcmp(ptr, "MODEL-NUM:") == 0) {
      modelNum = atoi(ptr);
    } else {
      printf("Error: Unknown cfg cmd:%s\n", ptr);
      assert(0);
    }
  }
}

// Parse NN input parm file
void PIContext::parseInput()
{
  char buf[256];

  assert(trainFile);

  // Read in training inputs arguments
  while (fgets(buf, sizeof(buf), trainFile)) {
    char *ptr = strtok(buf, " \n");
    vector<string> vs(0);

    while (ptr) {
      vs.push_back(string(ptr));

      ptr = strtok(NULL, " \n");
    }
    
    trainArgs.push_back(vs);
  }

  assert(trainArgs.size() && 
    "Training file is necessary for supervised learning");

  itTrainArgs = trainArgs.begin();

  if (!validFile) {
    itValidArgs = validArgs.end();
    return;
  }

  // Read in validation inputs arguments
  while (fgets(buf, sizeof(buf), validFile)) {
    char *ptr = strtok(buf, " \n");
    vector<string> vs(0);

    while (ptr) {
      vs.push_back(string(ptr));

      ptr = strtok(NULL, " \n");
    }

    validArgs.push_back(vs);
  }
  
  itValidArgs = validArgs.begin();
}

// Initialization for supervised learning production
void PIContext::sprodInit(int argc, char **argv)
{
  parseInput();

  fclose(trainFile);

  if (validFile)
    fclose(validFile);

  dumpContext(argc, argv);

  fileIO->prodInit();

  // Fork child process to execute main function and generate training data
	while (itTrainArgs != trainArgs.end()) {
		
    // Fork child according to threshold, break out the loop per 10 forks
		for (int i=0; itTrainArgs != trainArgs.end() && i<10; i++, itTrainArgs++) {
			if (fork() == 0) {
        vector<const char *> mainArgv;
        vector<string> args = *itTrainArgs;

        for (int i=0; i<args.size(); i++) {
          mainArgv.push_back(args[i].c_str());
        }

        // Execute main function of target program
        main(mainArgv.size(), &mainArgv[0]);
        exit(0);
			}
		}

		printf("Training data #todo=%ld #done=%ld\n", 
      trainArgs.end() - itTrainArgs, itTrainArgs - trainArgs.begin());
		fflush(stdout);
		// Parent waits for all child processes to exit
		while (true) {
			int status;
			pid_t donePID = wait(&status);

			if (donePID > 0) {
				// Child exit normally
				assert(WIFEXITED(status));

				// Child exit status:
				switch(WEXITSTATUS(status)) {
					case 0: // 0: Nnormal exit
						break;
					default:
						printf("Fatal failed: Child %d exit abnormally, status=%d\n",
							donePID, WEXITSTATUS(status));
						assert(0);
				}
			} else if (donePID == -1 && errno == ECHILD) {
				//No more child, exit loop
				break;
			} else {
				assert(0);
			}
		}
	} 

  // Fork child process to execute main function and generate validation data
	while (itValidArgs != validArgs.end()) {
		
    // Fork child according to threshold, break out the loop per 10 forks
		for (int i=0; itValidArgs != validArgs.end() && i<10; i++, itValidArgs++) {
			if (fork() == 0) {
        vector<const char *> mainArgv;
        vector<string> args = *itValidArgs;

        for (int i=0; i<args.size(); i++) {
          mainArgv.push_back(args[i].c_str());
        }

        // Execute main function of target program
        main(mainArgv.size(), &mainArgv[0]);
        exit(0);
			}
		}

		printf("Validation data #todo=%ld #done=%ld\n", 
      validArgs.end() - itValidArgs, itValidArgs - validArgs.begin());
		fflush(stdout);
		// Parent waits for all child processes to exit
		while (true) {
			int status;
			pid_t donePID = wait(&status);

			if (donePID > 0) {
				// Child exit normally
				assert(WIFEXITED(status));

				// Child exit status:
				switch(WEXITSTATUS(status)) {
					case 0: // 0: Nnormal exit
						break;
					default:
						printf("Fatal failed: Child %d exit abnormally, status=%d\n",
							donePID, WEXITSTATUS(status));
						assert(0);
				}
			} else if (donePID == -1 && errno == ECHILD) {
				//No more child, exit loop
				break;
			} else {
				assert(0);
			}
		}
	} 
}

// Initialization for reinforcement learning production
void PIContext::rprodInit(int argc, char **argv)
{
  fileIO->prodInit();
}

void PIContext::runtimeInit()
{
  // Step 1. allocate memory for store data
  if (storeMap.size()) {
    for (auto it=storeMap.begin(); it!=storeMap.end(); it++) {
      DataContext *pDC = it->second;
      unsigned int tSize = DataContext::getTypeSize(pDC->tID);

      assert(pDC->nmemb > 0 && "Data length should be greater than 0");

      pDC->data = malloc(tSize * pDC->nmemb);
    }
  }
}

void PIContext::nnInternal(string &modelName, NNStg stg, 
                            vector<string> &loadNames, vector<string> &storeNames)
{
  assert(loadNames.size() && "Neural network needs load data");
  assert(storeNames.size() && "Neural network needs store data");

  // Combine load data specified by user
  combineLoad(loadNames);
  
  switch (status) {
    case PI_SPROD:
    {
      // Create model directory
      if (stg == PIS_ONE)
        fileIO->prodCreateModelDir(modelName, modelName);
      else
        fileIO->prodCreateModelDir(modelName, loadNames);

      // Write load data to file
      if (itTrainArgs != trainArgs.end()) {
        if (stg == PIS_ONE)
          fileIO->prodWriteLoadData(modelName, 
            loadNames[0], 
            fileIO->piTrainDir, itTrainArgs - trainArgs.begin());
        else
          fileIO->prodWriteLoadData(modelName, 
            loadNames, 
            fileIO->piTrainDir, itTrainArgs - trainArgs.begin());
      } else if (itValidArgs != validArgs.end()) {
        if (stg == PIS_ONE)
          fileIO->prodWriteLoadData(modelName, 
            loadNames[0], 
            fileIO->piValidDir, 
            itValidArgs - validArgs.begin());
        else
          fileIO->prodWriteLoadData(modelName, 
            loadNames, 
            fileIO->piValidDir, 
            itValidArgs - validArgs.begin());
      }

      // Recored stored data information for later usage
      for (int i=0; i<storeNames.size(); i++) {
        storeModelMap[storeNames[i]] = {{modelName, stg}, loadNames};
      }

      // Only let first child process call python interface
      if (itTrainArgs == trainArgs.begin())
        pyContext->prod(modelName, loadNames, storeNames);

      break;
    }
    case PI_RPROD:
      // Create model directory
      fileIO->prodCreateModelDir(modelName, modelName);
      // Recored stored data information for later usage
      for (int i=0; i<storeNames.size(); i++) {
        storeModelMap[storeNames[i]] = {{modelName, stg}, loadNames};
      }
      // Only let first child process call python interface
      pyContext->prod(modelName, loadNames, storeNames);
      break;
    case PI_TRAIN:
      // Only for reinforcement learning
      pyContext->test(modelName, loadNames, storeNames);
      break;
    case PI_TEST:
    {
      if (stg == PIS_ONE) {
        pyContext->test(modelName, loadNames, storeNames);
      } else {

      }
      break;
    }
    default:
      return;
  }
}

// Check the combination of loaded data and combine them before
// passing to neural network
void PIContext::combineLoad(vector<string> &loadNames)
{
  // Loop over loaded data
  for (int i=0; i<loadNames.size(); i++) {

    if (loadNames[i].find("_") == string::npos) 
      continue;

    // Found target data to combine 
    DataContext *pCDC = NULL;

    // Add the combined data into loadMap if not found
    if (loadMap.find(loadNames[i]) == loadMap.end()) {
      char buf[256], *ptr;
      int nmemb = 0;
      vector<DataContext *> loadDataVec;

      strcpy(buf, loadNames[i].c_str());

      ptr = strtok(buf, "_");

      while (ptr) {
        string s = string(ptr);

        assert(loadMap.find(s) != loadMap.end() &&
            "Data should be loaded before combined");

        nmemb += loadMap[s]->nmemb;

        loadDataVec.push_back(loadMap[s]);

        ptr = strtok(NULL, "_");
      }

      // Combined data will be double type
      pCDC  = new DataContext(PIT_D, nmemb, true);
      loadMap[loadNames[i]] = pCDC;

      pCDC->combinedLoad = loadDataVec;
    } else {
      pCDC = loadMap[loadNames[i]];
    }

    assert(pCDC->combinedLoad.size() > 1 && 
        "Failed to combine multiple load data");

    // Start combining data
    double *pTrg = (double *) pCDC->data;
    for (int j=0; 
         j<pCDC->combinedLoad.size(); 
         pTrg += pCDC->combinedLoad[j]->nmemb, j++) 
    {
      DataContext *pLDC = pCDC->combinedLoad[j];

      switch (pLDC->tID) {
        case PIT_C: 
        {
          char *pBuf = (char *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_S:
        {
          short *pBuf = (short *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_I:
        {
          int *pBuf = (int *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_UC:
        {
          unsigned char *pBuf = (unsigned char *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_US:
        {
          unsigned short *pBuf = (unsigned short *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_UI:
        {
          unsigned int *pBuf = (unsigned int *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_F:
        {
          float *pBuf = (float *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        case PIT_D:
        {
          double *pBuf = (double *) pLDC->data;

          for (int k=0; k<pLDC->nmemb; k++) {
            pTrg[k] = (double) pBuf[k]; 
          }
          break;
        }
        default:
          assert(0 && "Cannot combine this data type");
      }
    }
  }
}

void PIContext::dumpContext(int argc, char *argv[])
{
  printf("Exec argv:");
  for (int i=0; i<argc; i++) {
    printf(" %s", argv[i]);
  }
  printf("\n");

  printf("NN Info\n");

  printf("STATUS=%s\n", statusInfo[status].c_str()); 

  printf("Model number=%d\n", modelNum);
  
  // Dump all training inputs
  printf("Training input number=%lu\n", trainArgs.size());
  for (int i=0; i<trainArgs.size(); i++) {
    for (int j=0; j<trainArgs[i].size(); j++) {
      printf("%s ",  trainArgs[i][j].c_str());
    }

    printf("\n");
  }
  
  // Dump all validation inputs
  printf("Validation input number=%lu\n", validArgs.size());
  for (int i=0; i<validArgs.size(); i++) {
    for (int j=0; j<validArgs[i].size(); j++) {
      printf("%s ",  validArgs[i][j].c_str());
    }

    printf("\n");
  }
}

// Store the data back to program
void PIContext::storeData(string &storeName, void *data)
{
  assert(data && "Cannot store data back to NULL pointer");

  if (storeMap.find(storeName) == storeMap.end()) {
    printf("Cannot find information of store %s\n", storeName.c_str());
    assert(0);
  }

  DataContext *pDC = storeMap[storeName];
  unsigned int tSize = DataContext::getTypeSize(pDC->tID);

  memcpy(data, pDC->data, tSize * pDC->nmemb);
}

//
// C interface
//
void piLoad(const char *name, TypeID tID, int nmemb, void *data, bool doAlloc)
{
  string loadName = string(name);

  piContext->load(loadName, tID, nmemb, data, doAlloc);
}

void piLoadCB(const char *name, TypeID tID, int nmemb, CBPtr cb, ...)
{
  string loadName = string(name);
  va_list vl;

  va_start(vl, cb);

  piContext->loadCB(loadName, tID, nmemb, cb, vl);

  va_end(vl);
}

void piStore(const char *name, TypeID tID, int nmemb, void *data)
{
  string storeName = string(name);

  piContext->store(storeName, tID, nmemb, data);
}

void piNN(const char *name, NNStg stg, int loadNum, int storeNum, ...)
{
  string modelName = string(name);
  va_list vl;

  va_start(vl, storeNum);
 
  piContext->nn(modelName, stg, loadNum, storeNum, vl);

  va_end(vl);
}

void *piGetData(const char *name, int *nmemb)
{
  DataContext *pDC = NULL;
  string dataName(name);

  if (piContext->loadMap.find(dataName) != piContext->loadMap.end()) {
    pDC = piContext->loadMap[dataName]; 
  } else if (piContext->storeMap.find(dataName) != piContext->storeMap.end()) {
    pDC = piContext->storeMap[dataName]; 
  } else {
    printf("Cannot get data with name = %s", name);
    assert(0);
  }

  *nmemb = pDC->nmemb;

  return pDC->data;
}

void piEnd()
{
  piContext->end();
}

void piCheckpoint()
{
  piContext->checkpoint();
}

void piRestore()
{
  piContext->restore();
}
  
int piGetCheckpointed()
{
  return piContext->getCheckpointed();
}
