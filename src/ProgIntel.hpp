#ifndef _PRIT_HPP_
#define _PRIT_HPP_

#include <stdio.h>
#include <assert.h>
#include <vector>
#include <string>
#include <map>
#include <string.h>

#include "DataContext.hpp"
#include "ProgIntel.h"

using namespace std;

// NN Declaration
#define PI_NONE         0
// In production status
#define PI_PROD         1 
// In supervised learning production status
#define PI_SPROD        2 
// In reinforcement learning production status
#define PI_RPROD        3 
// In training status
#define PI_TRAIN        4
// In testing status
#define PI_TEST         5 
// In execution status for reinforcement learning model
#define PI_RTEST        6

class PIContext {
  public:
    PIContext();
    // Neural Network Status
    unsigned char status;
    // Neural Network Status verbose info
    vector<string> statusInfo;
    // Arguments for main function
    vector<string> mainArgs;

    // Arguments for training input data
    vector<vector<string>> trainArgs;
    // iterator of trainArgs
    vector<vector<string>>::iterator itTrainArgs;

    // Arguments for validation input data
    vector<vector<string>> validArgs;
    // iterator of validArgs
    vector<vector<string>>::iterator itValidArgs;

    // Config file
    FILE *trainFile, *validFile, *cfgFile;
    // Number of models to train
    int modelNum;

    // Loaded-data map
    map<string, DataContext *> loadMap;

    // Stored-data map
    map<string, DataContext *> storeMap;

    // Stored-data <-> pair<model, vector<loaded-data name>> 
    // To handle the problem that stored data comes after 
    // nn library call
    map<string, pair<pair<string, NNStg>, vector<string>>> storeModelMap;

    void init(int argc, char **argv);
    void fini();
    void load(string &name, TypeID tID, int nmemb, void *data, bool doAlloc);
    void loadCB(string &name, TypeID tID, int nmemb, CBPtr cb, va_list vl);
    void store(string &name, TypeID tID, int nmemb, void *data);
    void nn(string &modelName, NNStg stg, int loadNum, int storeNum, ...);
    void nn(string &modelName, NNStg stg, int loadNum, int storeNum, va_list vl);
    void end();
    void checkpoint();
    void restore();
    int getCheckpointed();
  private:
    void parseArgv(int argc, char **argv);
    void parseCfg();
    void parseInput();
    void sprodInit(int argc, char **argv);
    void rprodInit(int argc, char **argv);
    void runtimeInit();

    void nnInternal(string &modelName, NNStg stg, 
      vector<string> &loadNames, vector<string> &storeNames);
    void combineLoad(vector<string> &loadNames);
    void dumpContext(int argc, char *argv[]);
    void storeData(string &storeName, void *data);
    unsigned int getTypeSize(TypeID tID);
    int checkpointed;
};

extern PIContext *piContext;

#endif
