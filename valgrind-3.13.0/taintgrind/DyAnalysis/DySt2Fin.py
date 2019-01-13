# Combine the static analysis and dynamic analysis result
# as the final result
import sys
import re
import copy

class Dep:
    def __init__(self, depStr):
        depInfo = depStr.strip()[1:-1].split(":")
        self.funcName = depInfo[0]
        self.varName = depInfo[1]
        self.varType = depInfo[2]
        self.inst = depInfo[3]

    def getFullName(self):
        return self.funcName + ':' + self.varName

    def dump(self):
        print self.funcName + ':' + self.varName + ':' + self.varType + ':' + self.inst

class DepRoot:
    def __init__(self, varFunc, varName, isInput):
        self.varFunc = varFunc
        self.varName = varName
        self.isInput = isInput

        self.staticDep = dict()
        self.dynamicDep = dict()

    def addStaticDep(self, dep):
        if dep.getFullName() not in self.staticDep:
            self.staticDep[dep.getFullName()] = dep
        else:
            assert False

    def addDynamicDep(self, dep):
        if dep.getFullName() not in self.dynamicDep:
            self.dynamicDep[dep.getFullName()] = dep
        else:
            assert False

    def dump(self):
        print '[Dependency root]' + self.varFunc + ':' + self.varName + ':' + self.isInput
        print '[Dependents]'
        for key, item in self.staticDep.items():
            item.dump()

        #print '[Dynamic dependents]'
        #for key, item in self.dynamicDep.items():
        #    item.dump()

        print

    # Filter out static dependencies by inspecting dynamic dependency
    # Add the dynamic dependency into static if static analysis cannot
    # find useful information
    def filter(self):
        if len(self.staticDep) == 0:
            self.staticDep = copy.deepcopy(self.dynamicDep)
        else:
            for key, item in self.staticDep.items():
                if key not in self.dynamicDep:
                    del self.staticDep[key]

    def dumpUsefulInternalData(self):
        print '[Dependency root]' + self.varFunc + ':' +self.varName + ':' +self.isInput
        print '[Useful internal data]'
        for key, item in self.internalData.items():
            item.dump()

        print
    # Internal data that can be used to predict the value of dep root
    def addUsefulInternalData(self, internalData):
        self.internalData = internalData

def addDynamicDeps(depRoot):
    # search for varName.dy
    dyName = depRoot.varName + '.dy'

    try:
        with open(dyName) as f:
            for line in f:
                dep = Dep(line)
                depRoot.addDynamicDep(dep)
    except:
        pass

# For each non-input root (program parameter), we want to find
# internal data that can be used to predict its value. Thus, we
# need to get the internal data that is not dependent on it.
# It is done as the following:
# For each dependent variables of the target predicting parameter,
# we find whether it's also the dependent internal variable of
# the input variable. If yes, we prune it from the dependent list
# of input variables. The remaining of the list are internal data
# that can be used to predict the parameter.
def getUsefulInternalData(inputDepRoots, nonInputDepRoots):
    iDepDict = dict()

    for iDepRoot in inputDepRoots:
        for key, item in iDepRoot.staticDep.items():
            if key not in iDepDict:
                iDepDict[key] = item

    for niDepRoot in nonInputDepRoots:
        iDepDictCopy = copy.deepcopy(iDepDict)
        for key, item in niDepRoot.staticDep.items():
            if key in iDepDictCopy:
                del iDepDictCopy[key]

        niDepRoot.addUsefulInternalData(iDepDictCopy)

def main():
    static = sys.argv[1]

    inputDepRoot = []
    nonInputDepRoot = []
    with open(static) as f:
        # skip useless lines
        for line in f:
            if "Begin DepRoot" not in line:
                continue
            else:
                line = line.strip()[1:-1].split(':')
                depRoot = DepRoot(line[1], line[2], line[3])

                if line[3] == "INPUT":
                    inputDepRoot.append(depRoot)
                else:
                    nonInputDepRoot.append(depRoot)
                for line in f:
                    if "End DepRoot" in line:
                        #print depRoot.varFunc, depRoot.varName
                        #print depRoot.staticDep
                        addDynamicDeps(depRoot)
                        depRoot.filter()
                        break

                    dep = Dep(line)
                    depRoot.addStaticDep(dep)

    getUsefulInternalData(inputDepRoot, nonInputDepRoot)

    for niDepRoot in nonInputDepRoot:
        niDepRoot.dumpUsefulInternalData()
        niDepRoot.dump()

if __name__ == "__main__":
    main()
