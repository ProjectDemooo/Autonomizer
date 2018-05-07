import tensorflow as tf
import numpy as np
import sys
import os
import imp
import random
from collections import deque
import cPickle

def addLayer(inputs, in_size, out_size, activation_function=None):
# add one more layer and return the output of this layer
  # reinf
  weights = tf.Variable(tf.truncated_normal([in_size, out_size], stddev=0.01))
  # super
  #weights = tf.Variable(tf.random_normal([in_size, out_size]))
  biases = tf.Variable(tf.zeros([1, out_size]) + 0.01)
  wx_plus_b = tf.matmul(inputs, weights) + biases

  if activation_function is None:
    outputs = wx_plus_b
  else:
    outputs = activation_function(wx_plus_b)

  return outputs

class Dataset():
  dsIn = None
  dsOut = None
  dsSize = 0
  dsPath = None
  inNmemb = -1
  outNmemb = 0;

  def __init__(self, path):
    self.dsPath = path
    self.dsIn = []
    self.dsOut = []

    for root, dirs, files in os.walk(self.dsPath, topdown=True):
      for name in files:
        self.dsSize += 1

        fName = os.path.join(root, name)

        f = open(fName)

        dIn = []
        dOut = []
        for line in f:
          if 'NN-LOAD-DATA-NMEMB' in line:
            x = int(line.split(':')[1])

            for i in xrange(x):
              dIn.append(float(f.next()))

            self.inNmemb = x
            continue

          if 'NN-STORE-DATA-NMEMB' in line:
            x = int(line.split(':')[1])
            for i in xrange(x):
              dOut.append(float(f.next()))

            continue

        self.dsIn.append(dIn)
        self.dsOut.append(dOut)
        self.outNmemb = len(self.dsOut[0])

class TFNNSuper():
  costFunc = None
  trainFunc = None
  defIn = None
  defOut = None
  nnOut = None
  verbose = True
  modelDir = None
  modelPath = None
  inNmemb = -1
  outNmemb = -1
  step = 1
  trainData = None
  validData = None

  def __init__(self, op, mDir, mPath, trainPath, validPath):
    self.modelDir = mDir
    self.modelPath = mPath

    self.epoch = 100000
    self.trainStopThd = 0.05
    self.validStopThd = 0.05
    self.saveThdStep = 0.1

    # For training and ensemble_training
    if op == 'train':
      self.trainData = Dataset(trainPath)
      self.validData = Dataset(validPath)

    self.trainRestartThd = 1.5
    self.validRestartThd = 1.5
    self.trainSaveThd = 1.5
    self.validSaveThd = 1.5


  def setInNmemb(self, inNmemb):
    self.inNmemb = inNmemb
    self.defIn = \
      tf.placeholder(tf.float32, [None, self.inNmemb])

  def setOutNmemb(self, outNmemb):
    self.outNmemb = outNmemb
    self.defOut = \
      tf.placeholder(tf.float32, [None, self.outNmemb])

  def setNNOut(self, o):
    self.nnOut = o

    if self.costFunc == None:
      self.costFunc = tf.reduce_mean(tf.abs(self.defOut - self.nnOut))

    if self.trainFunc == None:
      self.trainFunc = \
        tf.train.AdamOptimizer(learning_rate=0.001, \
          beta1=0.9, beta2=0.999, epsilon=1e-08).minimize(self.costFunc)

  def setCostFunc(self, cost):
    self.costFunc = cost

  def setTrainFunc(self, train):
    self.trainFunc = train

  def getTrainData(self):
    return (self.trainData.inData, self.trainData.outData)

  def getValidData(self):
    return (self.validData.inData, self.validData.outData)

  # Set when to stop training
  def setStopThd(self, trainThd=None, validThd=None):
    if trainThd != None:
      self.trainStopThd = trainThd

    if validThd != None:
      self.validStopThd = validThd

  # Set when to restart the whole training
  def setRestartThd(self, trainThd=None, validThd=None):
    if trainThd != None:
      self.trainRestartThd = trainThd

    if validThd != None:
      self.validRestartThd = validThd

  def setSaveModelThd(self, trainSaveThd, validSaveThd, saveThdStep):
    self.trainSaveThd = trainSaveThd
    self.validSaveThd = validSaveThd
    self.saveThdStep = saveThdStep

  def setEpoch(self, epoch):
    self.epoch = epoch

  def train(self, callback=None):
    if callback != None:
      callback()
    else:
      tIn = self.trainData.dsIn
      tOut = self.trainData.dsOut

      if self.validData != None:
        vIn = self.validData.dsIn
        vOut = self.validData.dsOut

      with tf.Session() as sess:
        done = False
        init = tf.initialize_all_variables()

        while done == False:
          sess.run(init)
          print 'restart'
          for i in range(self.epoch):
            sess.run(self.trainFunc, feed_dict={self.defIn:tIn, self.defOut:tOut})

            if i % 100 == 0 and self.verbose == True:
              trainLoss = \
                sess.run(self.costFunc, feed_dict={self.defIn:tIn, self.defOut:tOut})

              if self.validData != None:
                validLoss = \
                  sess.run(self.costFunc, feed_dict={self.defIn:vIn, self.defOut:vOut})

              print i, 'trainLoss =', trainLoss, 'validLoss =', validLoss, \
                'validSaveThd =', self.validSaveThd

            if validLoss > self.validRestartThd or trainLoss > self.trainRestartThd or \
                i > 100000:
              break

            if (self.validData == None and trainLoss < self.trainSaveThd) or \
                (self.validData != None and validLoss < self.validSaveThd and \
                 trainLoss < self.trainSaveThd):

                # Create directory if it does not exist
                saveDir = self.modelDir
                savePath = saveDir + 'model_%f_%d.ckpt' \
                              %(self.validSaveThd, i)

                print 'save model %s with train thd = %f valid thd = %f' \
                  %(savePath, self.trainSaveThd, self.validSaveThd)

                saver = tf.train.Saver()
                saver.save(sess, savePath)
                self.validSaveThd -= self.saveThdStep

            if (trainLoss < self.trainStopThd and
                (self.validData == None or \
                (self.validData != None and validLoss < self.validStopThd))):
              done = True
              break

  def test(self, testData):

    model = tf.train.latest_checkpoint(self.modelDir)

    if model == None:
      return None

    with tf.Session() as sess:
      saver = tf.train.Saver()
      saver.restore(sess, model)

      parms = sess.run(self.nnOut, feed_dict={self.defIn:testData})

    return parms[0]

  def genEnsembleData(self):
    if 'training' in self.operation:
      tIn = self.trainData.dsIn
      tOut = self.trainData.dsOut

      if self.validData != None:
        vIn = self.validData.dsIn
        vOut = self.validData.dsOut
    elif 'testing' == self.operation:
      tIn = self.testData.dsIn
      tOut = self.testData.dsOut
    else:
      print 'TFNNConfig: unknown operation', self.operation
      sys.exit()

    model = tf.train.latest_checkpoint(self.modelDir)

    if model == None:
      print 'Cannot generate ensemble data because no model in', self.modelDir
      sys.exit()

    with tf.Session() as sess:
      saver = tf.train.Saver()
      saver.restore(sess, model)

      parms = sess.run(self.nnOut, feed_dict={self.defIn:tIn})
      l = parms.tolist()

      if self.validData != None:
        parms = sess.run(self.nnOut, feed_dict={self.defIn:vIn})
        l += parms.tolist()

    return l


# Ensemble class
class TFNNSupEns():
  subModelNum = 0
  modelDir = None
  modelName = None

  def __init__(self, modelDir, modelName, subModelNum):
    self.modelDir = modelDir
    self.modelName = modelName
    self.subModelNum = subModelNum

  # Train ensemble
  def train(self):
    if self.subModelNum == 1:
        print 'TFNNEnsemble: single model should not use ensemble'
        sys.exit()

    parm = []
    gt = []
    for i in range(self.subModelNum):
      modelPath = '%s/%d/%s_%d.py' %(self.modelDir, i, self.modelName, i)

      if not os.path.isfile(modelPath):
        print 'Model:', modelPath, 'does not exist'
        sys.exit()

      mod = imp.load_source(modelPath, modelPath)
      tfnn = mod.modelInit('ensemble_training')

      parm.append(tfnn.genEnsembleData())

      # get ground truth
      if i == self.subModelNum - 1:
        gt = tfnn.trainData.dsOut

        if tfnn.validData != None:
            gt += tfnn.validData.dsOut

    parmIn = []

    for i in range(len(parm[0])):
      x = []
      for j in range(len(parm)):
        x.append(parm[j][i][0])

      parmIn.append(x)

    #print parmIn
    #print gt

    # reset graph for training the weighted ensemble layer
    tf.reset_default_graph()

    xIn = tf.placeholder(tf.float32, [None, self.subModelNum])
    yOut = tf.placeholder(tf.float32, [None, 1])
    keep_prob = tf.placeholder(tf.float32)

    # TODO: fix it and move to user's nn
    if self.modelName == 'sigma':
      lin = addLayer(xIn, self.subModelNum, 50, activation_function=tf.sigmoid)
      ldrop = tf.nn.dropout(lin, keep_prob)
      lout = addLayer(ldrop, 50, 1)
    else:
      lin = addLayer(xIn, self.subModelNum, 10, activation_function=tf.nn.relu)
      ldrop = tf.nn.dropout(lin, keep_prob)
      lout = addLayer(ldrop, 10, 1)

    costFunc = tf.reduce_mean(tf.abs(lout - yOut))
    trainFunc = tf.train.AdamOptimizer(learning_rate=0.001, \
        beta1=0.9, beta2=0.999, epsilon=1e-08).minimize(costFunc)

    with tf.Session() as sess:
      done = False
      init = tf.initialize_all_variables()

      while done == False:
        sess.run(init)
        print 'restart'
        for i in range(1000000):
          sess.run(trainFunc, feed_dict={xIn:parmIn, yOut:gt, keep_prob:0.25})

          loss = sess.run(costFunc, feed_dict={xIn:parmIn, yOut:gt, keep_prob: 1.0})
          if i % 100 == 0:
            print loss

          if loss < 3.00:
            saveDir = self.modelDir
            savePath = saveDir + 'model_ens_%f.ckpt' %(loss)
            saver = tf.train.Saver()
            saver.save(sess, savePath)
            done = True
            break

  # Test ensemble
  def test(self):
    if self.subModelNum == 1:
        print 'TFNNEnsemble: single model should not use ensemble'
        sys.exit()

    parm = []
    for i in range(self.subModelNum):
      modelPath = '%s/%d/%s_%d.py' %(self.modelDir, i, self.modelName, i)

      if not os.path.isfile(modelPath):
        print 'Model:', modelPath, 'does not exist'
        sys.exit()

      mod = imp.load_source(modelPath, modelPath)
      tfnn = mod.modelInit('testing')

      parm.append(tfnn.genEnsembleData())

    parmIn = []
    for i in range(len(parm)):
      parmIn.append(parm[i][0][0])

    print parmIn
    #print np.array(parmIn).reshape()
    # reset graph for using the weighted ensemble layer
    tf.reset_default_graph()

    xIn = tf.placeholder(tf.float32, [None, self.subModelNum])
    yOut = tf.placeholder(tf.float32, [None, 1])
    keep_prob = tf.placeholder(tf.float32)

    # TODO: fix it and move to user's nn
    if self.modelName == 'sigma':
      lin = addLayer(xIn, self.subModelNum, 50, activation_function=tf.sigmoid)
      ldrop = tf.nn.dropout(lin, keep_prob)
      lout = addLayer(ldrop, 50, 1)
    else:
      lin = addLayer(xIn, self.subModelNum, 10, activation_function=tf.nn.relu)
      ldrop = tf.nn.dropout(lin, keep_prob)
      lout = addLayer(ldrop, 10, 1)

    model = tf.train.latest_checkpoint(self.modelDir)

    if model == None:
      print 'Cannot generate ensemble data because no model in', self.modelDir
      sys.exit()

    with tf.Session() as sess:
      saver = tf.train.Saver()
      saver.restore(sess, model)

      parms = sess.run(lout, feed_dict={xIn:[parmIn], keep_prob: 1.0})

    return parms

class TFNNReinfConf():
  loop = 0
  prevState = []
  prevAct = []
  prevQ = None
  terminal = False
  epsilon = 0
  replayMem = None
  dieCnt = 0

  def __init__(self):
    self.replayMem = deque()
    pass

class TFNNReinf():
  GAMMA = 0.99 # decay rate of past observations
  OBSERVE = 3000. # timesteps to observe before training
  EXPLORE = 2000000. # frames over which to anneal epsilon
  FEPS = 0.00001 # final value of epsilon
  IEPS = 0.6 # starting value of epsilon
  REPLAYSIZE = 10000 # number of previous transitions to remember
  BATCHSIZE = 32 # size of minibatch
  SAVEITERATION = 10000 # Number of iterations before saving model

  costFunc = None
  trainFunc = None
  defIn = None
  defOut = None
  nnOut = None
  targetQ = None
  sess = None
  model = None
  reinfConf = None
  modelDir = None
  randCallback = None

  def __init__(self, modelDir):
    self.modelDir = modelDir

    self.reinfConf = TFNNReinfConf()

  def init(self):
    self.sess = tf.Session()

    try:
      f = open(self.modelDir + '.data', "rb")
      self.reinfConf = cPickle.load(f)
      f.close()
      self.loadModel()
    except:
      init = tf.initialize_all_variables()
      self.sess.run(init)

      self.reinfConf.epsilon = self.IEPS

  # Use four frames by default
  def setInNmemb(self, inNmemb):
    self.inNmemb = inNmemb * 4
    self.defIn = \
      tf.placeholder(tf.float32, [None, self.inNmemb])

  def setOutNmemb(self, outNmemb):
    self.outNmemb = outNmemb
    self.defOut = \
      tf.placeholder(tf.float32, [None, self.outNmemb])

  def setNNOut(self, o):
    self.nnOut = o

    if self.costFunc == None:
      self.targetQ = tf.placeholder(tf.float32, [None])

      estimateQ = tf.reduce_sum(tf.multiply(self.nnOut, self.defOut), \
                                    reduction_indices=1)
      self.cost = tf.reduce_mean(tf.square(self.targetQ - estimateQ))

    if self.trainFunc == None:
      self.trainFunc = tf.train.AdamOptimizer(1e-4).minimize(self.cost)

  def dump(self, state = None, reward = None, term = None):
    st = ""
    if self.reinfConf.loop <= self.OBSERVE:
      st = "observe"
    elif self.reinfConf.loop > self.OBSERVE and self.reinfConf.loop <= self.OBSERVE + self.EXPLORE:
      st = "explore"
    else:
      st = "train"

    print "TIMESTEP", self.reinfConf.loop, "/ STATE", st, "/ EPSILON %.5f" %(self.reinfConf.epsilon), \
        "/ ACTION", self.reinfConf.prevAct, "/ Q", self.reinfConf.prevQ, "/ Die", self.reinfConf.dieCnt

    if state:
      print "/ STATE", state,
    if reward:
      print "/ REWARD", reward,
    if term:
      print "/ TERM", term,

    if state or reward or term:
      print

  def saveModel(self, iteration = SAVEITERATION, now = False):
    if now == False and \
        (self.reinfConf.loop <= 0 or self.reinfConf.loop % iteration != 0):
      return

    saveDir = self.modelDir
    savePath = saveDir + 'model.ckpt'
    saver = tf.train.Saver()
    saver.save(self.sess, savePath)

  def loadModel(self):
    self.model = tf.train.latest_checkpoint(self.modelDir)
    saver = tf.train.Saver()
    saver.restore(self.sess, self.model)

  def setRand(self, callback):
    self.randCallback = callback

  def train(self, state, reward, term):
    curAct = np.zeros(self.outNmemb)

    QVal = None
    if len(self.reinfConf.prevState) == 0 :
      curState = np.stack([state, state, state, state], axis=0)
      curAct[0]= 1
    else:
      if self.reinfConf.terminal == True:
        self.reinfConf.dieCnt += 1
        curState = np.stack([state, state, state, state], axis=0)
      else:
        curState = np.append([state], self.reinfConf.prevState[:3], axis=0)
        QVal = self.sess.run(self.nnOut, feed_dict = {self.defIn : [curState.flatten()]})[0]

        # choose an action
        if random.random() <= self.reinfConf.epsilon:
          # random action
          if self.randCallback == None:
            curAct[random.randint(0, self.outNmemb - 1)] = 1
          else:
            self.randCallback(curAct)

        else:
          curAct[np.argmax(QVal)] = 1

        if self.reinfConf.epsilon > self.FEPS and self.reinfConf.loop > self.OBSERVE:
          self.reinfConf.epsilon -= (self.IEPS - self.FEPS) / self.EXPLORE * 10.0

        self.reinfConf.replayMem.append((self.reinfConf.prevState, self.reinfConf.prevAct, reward, curState, term))

        if len(self.reinfConf.replayMem) > self.REPLAYSIZE:
          self.reinfConf.replayMem.popleft()

        if self.reinfConf.loop > self.OBSERVE:
          minibatch = random.sample(self.reinfConf.replayMem, self.BATCHSIZE)

          pState = [i[0].flatten() for i in minibatch]
          pA = [i[1] for i in minibatch]
          r = [i[2] for i in minibatch]
          cState = [i[3].flatten() for i in minibatch]

          cQ = self.sess.run(self.nnOut, feed_dict = {self.defIn : cState})

          updateQ = []

          for i in xrange(len(minibatch)):
            t = minibatch[i][4]

            if t:
              updateQ.append(r[i])
            else:
              updateQ.append(r[i] + self.GAMMA * np.max(cQ[i]))

          self.sess.run(self.trainFunc, \
                feed_dict = {self.targetQ : updateQ, self.defOut : pA, self.defIn : pState})

    self.reinfConf.prevAct = curAct
    self.reinfConf.prevState = curState
    self.reinfConf.terminal = term
    self.reinfConf.prevQ = QVal

    self.reinfConf.loop += 1

    if term:
      f = open(self.modelDir + '.data', "wb")
      cPickle.dump(self.reinfConf, f)
      f.close()
      self.saveModel(now = True)

    return self.reinfConf.prevAct

  def test(self, state):
    act = np.zeros(self.outNmemb)

    if self.model == None:
      self.loadModel()

      if self.model == None:
        return act

    if len(self.reinfConf.prevState) == 0 :
      curState = np.stack([state, state, state, state], axis=0)
    else:
      curState = np.append([state], self.reinfConf.prevState[:3], axis=0)

    QVal = self.sess.run(self.nnOut, feed_dict = {self.defIn : [curState.flatten()]})[0]

    act[np.argmax(QVal)] = 1

    self.reinfConf.prevState = curState

    return act

