#ifndef _FILE_IO_HPP_
#define _FILE_IO_HPP_

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

#include "ProgIntel.hpp"

using namespace std;

class FileIO {
  public:
    FileIO() {};
    void prodInit();
    void prodCreateModelDir(string &modelName, vector<string> &loadNames);
    
    void prodCreateModelDir(string &modelName, string &loadName);
    
    void prodWriteLoadData(string &modelName, vector<string> &loadNames, 
                              string &dataDir, int dataIdx);
    
    void prodWriteLoadData(string &modelName, string &loadNames, 
                              string &dataDir, int dataIdx);
    
    void prodWriteStoreData(string &modelName, vector<string> &loadNames, 
                              string &dataDir, int dataIdx, string &storeName);
    
    void prodWriteStoreData(string &modelName, string &loadName, 
                              string &dataDir, int dataIdx, string &storeName);
    
    void prodWriteStoreInfo(string &modelName, 
                              string &storeName, int tID, int nmemb, NNStg stg);

    void runtimeInit();

    string piDir = ".piDir";
    string piTrainDir = "trainDir";
    string piValidDir = "validDir";
    string piModelDir = "modelDir";

  private:
    void writeLoadData(DataContext *pDC, string &dataName, string pathName);
    void writeStoreData(DataContext *pDC, string &dataName, string pathName);
    void readStoreInfo();
};

extern FileIO *fileIO;

#endif
