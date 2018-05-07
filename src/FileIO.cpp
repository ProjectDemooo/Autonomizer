#include <sys/stat.h>
#include <sys/types.h>
#include <assert.h>
#include <dirent.h>

#include "FileIO.hpp"

// Initialization during production phase
// Create program intelligence main directory
void FileIO::prodInit()
{
  string s;

  s = piDir;

  if (!ifstream(s)) {
		if (mkdir(s.c_str(), 0755) < 0) {
			printf("Error<FileIO::prodInit>: Cannot create directory %s\n",
        s.c_str());
      assert(0);
		}
  }
}

// Create directories for ensemble model
void FileIO::prodCreateModelDir(string &modelName, vector<string> &loadNames)
{
  string modelDir = piDir + '/' + modelName + '/';

  if (!ifstream(modelDir)) {
    // Create model directory
    if (mkdir(modelDir.c_str(), 0755) < 0 && errno != EEXIST) {
      printf("Error<FileIO::prodCreateModelDir>: "
          "Cannot create directory %s, errno=%d\n", 
          modelDir.c_str(), errno);
      assert(0);
    }

    // Create sub directories for each load name
    for (int i=0; i<loadNames.size(); i++) {
      DataContext *pDC = piContext->loadMap[loadNames[i]]; 

      assert(pDC && "Data context should exist");

      string loadNameDir = modelDir + loadNames[i];

      if (mkdir(loadNameDir.c_str(), 0755) < 0 && errno != EEXIST) {
        printf("Error<FileIO::prodCreateModelDir>: "
            "Cannot create directory %s, errno=%d\n", 
            loadNameDir.c_str(), errno);
        assert(0);
      }
    }
   
    string stPath(modelDir + modelName + ".ENS.store");
    FILE *f = fopen(stPath.c_str(), "w");

    fclose(f);
  }
}

// Create directory for single model
void FileIO::prodCreateModelDir(string &modelName, string &loadName)
{
  string modelDir = piDir + '/' + modelName + '/';

  if (!ifstream(modelDir)) {
    // Create model directory
    if (mkdir(modelDir.c_str(), 0755) < 0 && errno != EEXIST) {
      printf("Error<FileIO::prodCreateModelDir>: "
          "Cannot create directory %s, errno=%d\n", 
          modelDir.c_str(), errno);
      assert(0);
    }

    string stPath(modelDir + modelName + ".ONE.store");
    FILE *f = fopen(stPath.c_str(), "w");

    fclose(f);
  }
}

// Write load data for ensemble model
void FileIO::prodWriteLoadData(string &modelName, vector<string> &loadNames,  
                                string &dataDir, int dataIdx)
{
  // Data type should be training or validation
  assert(dataDir == piTrainDir || dataDir == piValidDir);

  for (int i=0; i<loadNames.size(); i++) {
    string dir = 
      piDir + '/' + modelName + '/' + loadNames[i] + '/' + dataDir + '/';
    
    if (!ifstream(dir)) {
      if (mkdir(dir.c_str(), 0755) < 0 && errno != EEXIST) {
        printf("Error<FileIO::prodWriteDataToFile>: Cannot create directory %s\n",
            dir.c_str());
        assert(0);
      }
    }

    writeLoadData(piContext->loadMap[loadNames[i]], loadNames[i], 
                    dir + to_string(dataIdx));
  }
}

// Write load data for single model
void FileIO::prodWriteLoadData(string &modelName, string &loadName,  
                                string &dataDir, int dataIdx)
{
  // Data type should be training or validation
  assert(dataDir == piTrainDir || dataDir == piValidDir);

  string dir = piDir + '/' + modelName + '/' + dataDir + '/';
  
  if (!ifstream(dir)) {
    if (mkdir(dir.c_str(), 0755) < 0 && errno != EEXIST) {
      printf("Error<FileIO::prodWriteDataToFile>: Cannot create directory %s\n",
          dir.c_str());
      assert(0);
    }
  }

  writeLoadData(piContext->loadMap[loadName], loadName, 
                  dir + to_string(dataIdx));
}

// Write store data for ensemble model
void FileIO::prodWriteStoreData(string &modelName, vector<string> &loadNames,  
                                string &dataDir, int dataIdx, string &storeName)
{
  // Data type should be training or validation
  assert(dataDir == piTrainDir || dataDir == piValidDir);
  
  // Open each input sub model file
  for (int i=0; i<loadNames.size(); i++) {
    string dir = 
      piDir + '/' + modelName + '/' + loadNames[i] + '/' + dataDir + '/';

    if (!ifstream(dir)) {
      printf("Error: Cannot open file for writing target store data: %s\n", 
          dir.c_str());
      assert(0);
    }

    writeStoreData(piContext->storeMap[storeName], storeName, 
                    dir + to_string(dataIdx));
  }
}

// Write store data for dingle model
void FileIO::prodWriteStoreData(string &modelName, string &loadName,  
                                string &dataDir, int dataIdx, string &storeName)
{
  // Data type should be training or validation
  assert(dataDir == piTrainDir || dataDir == piValidDir);
  
  // Open each input sub model file
  string dir = piDir + '/' + modelName + '/' + dataDir + '/';

  if (!ifstream(dir)) {
    printf("Error: Cannot open file for writing target store data: %s\n", 
        dir.c_str());
    assert(0);
  }

  writeStoreData(piContext->storeMap[storeName], storeName, 
                  dir + to_string(dataIdx));
}

// Initialization during training or testing phase 
void FileIO::runtimeInit()
{
  readStoreInfo();
}

//
// Private implementations
//
void FileIO::writeLoadData(DataContext *pDC, string &dataName, string pathName)
{
  FILE *f = NULL;
 
  if (!(f = fopen(pathName.c_str(), "w"))) {
    printf("Error: Cannot open file for writing load info: %s\n", 
        pathName.c_str());
    assert(0);
  }

  assert(pDC && "DataContext should exist");
  assert(pDC->data && "DataContext should contain data to write");

  // Write load data info
  fprintf(f, "NN-LOAD-DATA-NAME:%s\n", dataName.c_str());
  fprintf(f, "NN-LOAD-DATA-NMEMB:%d\n", pDC->nmemb);
  
  switch (pDC->tID) {
    case PIT_C: 
    {
      char *pBuf = (char *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_S:
    {
      short *pBuf = (short *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_I:
    {
      int *pBuf = (int *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_L:
    {
      long *pBuf = (long *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%ld\n", pBuf[j]);
      }
      break;
    }
    case PIT_UC:
    {
      unsigned char *pBuf = (unsigned char *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_US:
    {
      unsigned short *pBuf = (unsigned short *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_UI:
    {
      unsigned int *pBuf = (unsigned int *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_UL:
    {
      unsigned long *pBuf = (unsigned long *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%lu\n", pBuf[j]);
      }
      break;
    }
    case PIT_F:
    {
      float *pBuf = (float *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%f\n", pBuf[j]);
      }
      break;
    }
    case PIT_D:
    {
      double *pBuf = (double *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%lf\n", pBuf[j]);
      }
      break;
    }
    default:
      assert(0 && "Unknown load data type");
  }

  fclose(f);
}

void FileIO::writeStoreData(DataContext *pDC, string &dataName, string pathName)
{
  FILE *f = NULL;

  // Append to the end of load data
  if (!(f = fopen(pathName.c_str(), "a"))) {
    printf("Error: Cannot open file for writing store info: %s\n", 
        pathName.c_str());
    assert(0);
  }

  assert(pDC && "DataContext should exist");
  // Write store data info to each sub model file
  fprintf(f, "NN-STORE-DATA-NAME:%s\n", dataName.c_str());
  fprintf(f, "NN-STORE-DATA-NMEMB:%d\n", pDC->nmemb);

  switch (pDC->tID) {
    case PIT_C: 
    {
      char *pBuf = (char *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_S:
    {
      short *pBuf = (short *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_I:
    {
      int *pBuf = (int *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%d\n", pBuf[j]);
      }
      break;
    }
    case PIT_L:
    {
      long *pBuf = (long *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%ld\n", pBuf[j]);
      }
      break;
    }
    case PIT_UC:
    {
      unsigned char *pBuf =(unsigned char *) pDC->data;

      fprintf(f, "%u\n", pBuf[0]);
      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_US:
    {
      unsigned short *pBuf = (unsigned short *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_UI:
    {
      unsigned int *pBuf = (unsigned int *) pDC->data;

      fprintf(f, "%u\n", pBuf[0]);
      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%u\n", pBuf[j]);
      }
      break;
    }
    case PIT_UL:
    {
      unsigned long *pBuf = (unsigned long *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%lu\n", pBuf[j]);
      }
      break;
    }
    case PIT_F:
    {
      float *pBuf = (float *) pDC->data;

      fprintf(f, "%f\n", pBuf[0]);
      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%f\n", pBuf[j]);
      }
      break;
    }
    case PIT_D:
    {
      double *pBuf = (double *) pDC->data;

      for (int j=0; j<pDC->nmemb; j++) {
        fprintf(f, "%lf\n", pBuf[j]);
      }
      break;
    }
    default:
      assert(0 && "Unknown store data type");
  }
  fclose(f);
}

// Write NN output info of each model for later runtime usage
void FileIO::prodWriteStoreInfo(string &modelName, string &storeName, 
                                  int tID, int nmemb, NNStg stg)
{
  string dir = piDir + '/' + modelName + '/';
  FILE *f = NULL;
  string stPath;
  
  if (stg == PIS_ONE) 
    stPath = dir + modelName + ".ONE.store";
  else
    stPath = dir + modelName + ".ENS.store";

  assert(ifstream(dir));

  if (!ifstream(stPath)) {
    f = fopen(stPath.c_str(), "w");
  } else {
    f = fopen(stPath.c_str(), "a");
  }

  // Write store data info 
  fprintf(f, "NN-STORE-DATA-NAME:%s\n", storeName.c_str());
  fprintf(f, "NN-STORE-DATA-TYPE:%d\n", tID);
  fprintf(f, "NN-STORE-DATA-NMEMB:%d\n", nmemb);

  fclose(f);
}

// Read NN output info and record it in the store map
void FileIO::readStoreInfo()
{
  DIR *pDir = opendir(piDir.c_str());
  struct dirent *pEnt;

  assert(pDir && 
    "Program intelligence main directory should exist, do production first");

  // Go through all models under main directory 
  while ((pEnt = readdir(pDir)) != NULL) {
    string modelDirName(pEnt->d_name);

    // Read store info into the store map
    if (modelDirName != "." && modelDirName != ".." && pEnt->d_type == DT_DIR) {
      string stPathONE = 
        piDir + '/' + modelDirName + '/' + modelDirName + ".ONE.store";
      string stPathENS = 
        piDir + '/' + modelDirName + '/' + modelDirName + ".ENS.store";
      string stPath;

      if (ifstream(stPathONE)) {
        stPath = stPathONE;
      } else if (ifstream(stPathENS)) {
        stPath = stPathENS;
      } else {
        printf("Cannot find store data information of model %s or %s\n", 
          stPathONE.c_str(), stPathENS.c_str());
        assert(0); 
      }

      FILE *f = fopen(stPath.c_str(), "r");
      char buf[256];
      DataContext *pDC = NULL;
      string stName = "";

      while (fgets(buf, sizeof(buf), f)) {
        string s(buf);

        if (s.find("NAME:") != string::npos) {
          stName = s.substr(s.find(":") + 1);

          // erase newline char
          stName.pop_back();

          // Record store context
          if (piContext->storeMap.find(stName) == piContext->storeMap.end()) {
            pDC = new DataContext(PIT_NONE, -1, false);
            piContext->storeMap[stName] = pDC;
          } else
            pDC = piContext->storeMap[stName];
          
        } else if (s.find("TYPE:") != string::npos) {
          TypeID tID = (TypeID) stoi(s.substr(s.find(":") + 1));

          assert(pDC);

          // Set type ID
          if (pDC->tID == PIT_NONE)
            pDC->tID = tID;
          else if (pDC->tID != tID) {
            printf("Type ID mismatch with existing store %s, %d != %d\n",
              stName.c_str(), pDC->tID, tID);
            assert(0);
          }
        } else if (s.find("NMEMB:") != string::npos) {
          int nmemb = stoi(s.substr(s.find(":") + 1));

          assert(pDC);

          // Set nmemb
          if (pDC->nmemb == -1)
            pDC->nmemb = nmemb;
          else if (pDC->nmemb != nmemb) {
            printf("nmemb mismatch with existing store %s, %d != %d\n",
              stName.c_str(), pDC->nmemb, nmemb);
            assert(0);
          }
          
          pDC = NULL;
          stName = "";

        } else {
          assert(0 && "Unknown store information");
        }
      }
    }
  }
}
