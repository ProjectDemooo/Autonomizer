#ifndef _PI_INC_H_
#define _PI_INC_H_

typedef enum {
  PIT_NONE = 0,
  PIT_C = 1,
  PIT_S,
  PIT_I,
  PIT_L,
  PIT_UC,
  PIT_US,
  PIT_UI,
  PIT_UL,
  PIT_F,
  PIT_D,
  PIT_St,
  PIT_P,
} TypeID;

// Neural network stretagy
// PIS_ONE: All loaded data are used to train one model
//          By default, the first loaded data in nn call is
//          regarded as default neural network
//
// PIS_ENS: Each loaded data has its own model and combined for ensemble
typedef enum {
  PIS_ONE = 1,    
  PIS_ENS,       
} NNStg;
#endif
