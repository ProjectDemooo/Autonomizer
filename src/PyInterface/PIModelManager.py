#!/usr/bin/env python

import sys
import os
import imp
import ctypes

# None op
PI_NONE = 0
# Production run op
PI_PROD = 1
# Supervised learning production run op
PI_SPROD = 2
# Reinforcement learning production run op
PI_RPROD = 3
# Training op
PI_TRAIN = 4
# Testing op
PI_TEST = 5
# Reinforcement testing op
PI_RTEST = 6

loadedMod = None
loadedModDir = ""

# Generate model template for supervised learning
def genModelTemplate(*args):
  op =  args[0]
  interfaceDir = args[1]
  modelName = args[2]
  loadDataNum = args[3]
  storeDataNum = args[4]

  modelDir = '.piDir/%s/' %(modelName)

  if os.path.exists(modelDir + '%s.ONE.store' %(modelName)):
  # Single model

    # Model name is the first input name
    modelPath = modelDir + '%s.py' %(modelName)

    if os.path.isfile(modelPath):
      return

    f = open(modelPath, "w")

    f.write('import tensorflow as tf\n')
    f.write('import sys\n')
    f.write('sys.path.insert(0, \'%s\')\n\n' %(interfaceDir))
    f.write('import PINNHelper as nn\n\n')

    f.write('#Model dir\n')
    f.write('modelDir = \'%s\'\n\n' %(modelDir))
    f.write('#Model path\n')
    f.write('modelPath = \'%s\'\n\n' %(modelPath))

    f.write('#Data path\n')
    f.write('trainPath = \'.piDir/%s/trainDir/\'\n' %(modelName))
    f.write('validPath = \'.piDir/%s/validDir/\'\n' %(modelName))
    f.write('tfNN = None\n\n')

    f.write('def init(op):\n')

    f.write('  global modelDir\n')
    f.write('  global modelPath\n')
    f.write('  global trainPath\n')
    f.write('  global validPath\n\n')

    f.write('  tf.reset_default_graph()\n')
    f.write('  tfNN = nn.TFNNSuper(op, modelDir, modelPath, trainPath, validPath)\n')

    f.write('  # Begin NN model with 1 hidden layer which contains 10 neurons\n')

    f.write('  tfNN.setInNmemb(%d)\n' %(args[5 + loadDataNum]));
    f.write('  tfNN.setOutNmemb(%d)\n' %(storeDataNum));

    f.write(\
      '  l1 = nn.addLayer(tfNN.defIn, tfNN.inNmemb, 10, activation_function=tf.sigmoid)\n')
    f.write(\
      '  nnOut = nn.addLayer(l1, 10, tfNN.outNmemb, activation_function=tf.sigmoid)\n')

    f.write('  tfNN.setNNOut(nnOut)\n');

    f.write('  # End NN model\n')

    f.write('  return tfNN\n\n')

    f.write('def run(op')
    idx = 5
    for i in xrange(loadDataNum):
      f.write(', %s' %(args[idx + i]))

    idx += loadDataNum * 2

    for i in xrange(storeDataNum):
      f.write(', %s' %(args[idx + i]))

    f.write('):\n')

    f.write('  global tfNN\n\n')

    f.write('  if tfNN == None:\n')
    f.write('    tfNN = init(op)\n\n')

    f.write('  if op == \'train\':\n')
    f.write('    tfNN.train()\n')
    f.write('  else:\n')
    f.write('    result = tfNN.test([%s])\n\n' %args[5])
    f.write('    return result\n\n')

    f.write('if __name__ == "__main__":\n')

    f.write('  run(\'train\'')
    for i in xrange(loadDataNum):
      f.write(', None')

    for i in xrange(storeDataNum):
      f.write(', None')

    f.write(')\n')

    f.close()
  else:
  # Ensemble
    for i in xrange(5, 5 + loadDataNum):
      modelDir = '.piDir/%s/%s/' %(modelName, args[i])
      modelPath = modelDir + '%s.py' %(args[i])

      if not os.path.exists(modelDir):
        os.makedirs(modelDir)

      if os.path.isfile(modelPath):
        continue

      f = open(modelPath, "w")

      f.write('import tensorflow as tf\n')
      f.write('import sys\n')
      f.write('sys.path.insert(0, \'%s\')\n\n' %(interfaceDir))
      f.write('import PINNHelper as nn\n\n')

      f.write('#Model dir\n')
      f.write('modelDir = \'%s\'\n\n' %(modelDir))
      f.write('#Model path\n')
      f.write('modelPath = \'%s\'\n\n' %(modelPath))

      f.write('#Data path\n')
      f.write('trainPath = \'.piDir/%s/%s/trainDir/\'\n' %(modelName, args[i]))
      f.write('validPath = \'.piDir/%s/%s/validDir/\'\n\n' %(modelName, args[i]))

      f.write('def modelInit(operation):\n')

      f.write('  global modelDir\n')
      f.write('  global modelPath\n')
      f.write('  global trainPath\n')
      f.write('  global validPath\n\n')

      f.write('  tf.reset_default_graph()\n')
      f.write('  tfNN = nn.TFNNSuper(modelDir, modelPath, trainPath, validPath, testPath, operation)\n')

      f.write('  # Begin NN model with 1 hidden layer which contains 10 neurons\n')

      f.write(\
        '  l1 = nn.addLayer(tfNN.defIn, tfNN.inNmemb, 10, activation_function=tf.sigmoid)\n')
      f.write(\
        '  nnOut = nn.addLayer(l1, 10, tfNN.outNmemb, activation_function=tf.sigmoid)\n')

      f.write('  tfNN.setNNOut(nnOut)\n');

      f.write('  # End NN model\n')

      f.write('  return tfNN\n\n')

      f.write('if __name__ == "__main__":\n')

      f.write('  tfNN = modelInit(\'training\')\n')
      f.write('  tfNN.train()\n')

      f.close()

# Generate model template for reinforcement learning
def genRModelTemplate(*args):
  op =  args[0]
  interfaceDir = args[1]
  modelName = args[2]
  loadDataNum = args[3]
  storeDataNum = args[4]

  modelDir = '.piDir/%s/' %(modelName)

  # Model name is the first input name
  modelPath = modelDir + '%s.py' %(modelName)

  if os.path.isfile(modelPath):
    return

  f = open(modelPath, "w")

  f.write('import tensorflow as tf\n')
  f.write('import sys\n')
  f.write('sys.path.insert(0, \'%s\')\n\n' %(interfaceDir))
  f.write('import PINNHelper as nn\n\n')

  f.write('#Model dir\n')
  f.write('modelDir = \'%s\'\n\n' %(modelDir))
  f.write('#Model path\n')
  f.write('modelPath = \'%s\'\n\n' %(modelPath))

  f.write('tf.reset_default_graph()\n')

  f.write('tfNN = None\n\n')
  f.write('inNmemb = %d\n' %(args[5 + loadDataNum]))
  f.write('outNmemb = %d\n' %(storeDataNum))

  f.write('def init():\n')

  f.write('  global modelDir\n')

  f.write('  # Begin NN model architecture\n')

  f.write('  tfNN = nn.TFNNReinf(modelDir)\n')
  f.write('  tfNN.setInNmemb(%d)\n' %(args[5 + loadDataNum]));
  f.write('  tfNN.setOutNmemb(%d)\n' %(storeDataNum));

  f.write(\
    '  l1 = nn.addLayer(tfNN.defIn, tfNN.inNmemb, 10, activation_function=tf.sigmoid)\n')
  f.write(\
    '  nnOut = nn.addLayer(l1, 10, tfNN.outNmemb, activation_function=tf.sigmoid)\n')

  f.write('  tfNN.setNNOut(nnOut)\n');
  f.write('  # End NN model architecture\n')

  f.write('  tfNN.init()\n\n');

  f.write('  return tfNN\n\n')

  f.write('def train(')

  idx = 5
  for i in xrange(loadDataNum):
    if i > 0:
      f.write(', ')

    f.write('%s' %(args[idx + i]))

  idx += loadDataNum * 2

  for i in xrange(storeDataNum):
    f.write(', %s' %(args[idx + i]))

  f.write('):\n')
  f.write('  global tfNN\n')
  f.write('  return result\n\n')

  f.write('def test(')

  idx = 5
  for i in xrange(loadDataNum):
    if i > 0:
      f.write(', ')

    f.write('%s' %(args[idx + i]))

  idx += loadDataNum * 2

  for i in xrange(storeDataNum):
    f.write(', %s' %(args[idx + i]))

  f.write('):\n')
  f.write('  global tfNN\n')
  f.write('  return result\n\n')

  f.write('def run(op')

  idx = 5
  for i in xrange(loadDataNum):
    f.write(', %s' %(args[idx + i]))

  idx += loadDataNum * 2

  for i in xrange(storeDataNum):
    f.write(', %s' %(args[idx + i]))

  f.write('):\n')
  f.write('  global tfNN\n')

  f.write('  if tfNN == None:\n')
  f.write('    tfNN = init()\n\n')

  f.write('  if op == \'train\':\n')
  f.write('    result = train(')

  idx = 5
  for i in xrange(loadDataNum):
    if i > 0:
      f.write(', ')
    f.write('%s' %(args[idx + i]))

  idx += loadDataNum * 2

  for i in xrange(storeDataNum):
    f.write(', %s' %(args[idx + i]))

  f.write(')\n')

  f.write('  else:\n')
  f.write('    result = test(')

  idx = 5
  for i in xrange(loadDataNum):
    if i > 0:
      f.write(', ')
    f.write('%s' %(args[idx + i]))

  idx += loadDataNum * 2

  for i in xrange(storeDataNum):
    f.write(', %s' %(args[idx + i]))

  f.write(')\n')
  f.write('  return result\n\n')

  f.close()

def runModel(*args):
  global loadedMod
  global loadedModDir

  op = args[0]
  interfaceDir = args[1]
  modelName = args[2]
  loadDataNum = args[3]
  storeDataNum = args[4]

  modelDir = '.piDir/%s/' %(modelName)

  if loadedMod == None or loadedModDir != modelDir:
    if os.path.exists(modelDir + '%s.py' %(modelName)):
    # Single model
      modelPath = modelDir + '%s.py' %(modelName)
      loadedMod = imp.load_source(modelPath, modelPath)
      loadedModDir = modelDir
    else:
    # Ensemble
      pass

  loadArgs = args[5 + loadDataNum: 5 + loadDataNum * 2]
  storeArgs = args[5 + loadDataNum * 2 + storeDataNum:]

  inArgs = loadArgs + storeArgs

  if op == PI_TRAIN:
    loadedMod.run('train', *inArgs)
  elif op == PI_TEST:
    loadedMod.run('test', *inArgs)
  else:
    print 'PIModelManager.py: un-supported operation', op
    sys.exit(0)


def run(*args):
  sys.argv = ['']

  op = args[0]

  if op == PI_SPROD:
    genModelTemplate(*args)
  elif op == PI_RPROD:
    genRModelTemplate(*args)
  elif op == PI_TRAIN:
    runModel(*args)
  elif op == PI_TEST:
    runModel(*args)
  else:
    print 'PIModelManager.py: un-supported operation', op
    sys.exit(0)


  '''
  if op == 1:   # DP_NN_TRAIN
    genModelFile(*args)
  elif op == 3: # DP_NN_TEST
    pyList = runModel(*args)

    if pyList is None:
      return None
    else:
      return pyList[0].tolist()
  elif op == 4: # DP_NN_RTRAIN
    # Model file does not exist yet, so generate it and return nothing
    if genRModelFile(*args):
      return None
    # Model file exists, so start training
    else:
      pyList = runRModel(*args)
      #print pyList
      return pyList
      return pyList[0].tolist()
  elif op == 5: # DP_NN_RTEST
      pyList = runRModel(*args)
      return pyList
  else:
    print 'PIModelManager.py: Unknown operation', op
    sys.exit(0)
  '''
  return 0
