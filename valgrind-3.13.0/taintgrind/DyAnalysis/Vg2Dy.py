# It is used to analyze the valgrind dynamic
# taint analysis result. The inputs will be the dynamic
# taint analysis log file and the source code directory.
import sys
import re
import os
import glob

# Check the source to get the tainted variable
def checkSrcVar(srcLocInfo, fileInfo, lineInfo):
    with open(srcLocInfo) as f:
        for idx, line in enumerate(f, 1):
            if idx < lineInfo:
                continue
            else:
                srcLine = line.strip()
                break

    # Heuristic check
    # Check if it matches any if statement and filter it out
    filterStr = re.search('if\s*\(.+\)', srcLine)
    if filterStr != None:
        filterStr = filterStr.group()
        srcLine = srcLine[len(filterStr):].strip()

    # Check for assignment symbol and extract the LHS
    if "++" in srcLine:
        LHS = srcLine[:srcLine.find("++")].strip()
    elif "--" in srcLine:
        LHS = srcLine[:srcLine.find("--")].strip()
    elif "+=" in srcLine:
        LHS = srcLine[:srcLine.find("+=")].strip()
    elif "-=" in srcLine:
        LHS = srcLine[:srcLine.find("-=")].strip()
    elif "*=" in srcLine:
        LHS = srcLine[:srcLine.find("*=")].strip()
    elif "\=" in srcLine:
        LHS = srcLine[:srcLine.find("/=")].strip()
    elif " = "in srcLine:
        LHS = srcLine[:srcLine.find(" = ")].strip()
    else:
        return None

    # Extract tainted variable
    variables = \
        re.findall(r'[_a-zA-Z]+[_a-zA-Z0-9]*|[_a-zA-Z]+[_a-zA-Z0-9]*\.[_a-zA-Z]+[_a-zA-Z0-9]', LHS)

    return variables[0]


def main():
    srcDir = sys.argv[1]
    log = sys.argv[2]
    srcDict = dict()
    resultDict = dict()

    srcFiles = glob.glob(srcDir + "*.c")
    for sf in srcFiles:
        d, f = os.path.split(sf)

        srcDict[f] = sf

    with open(log) as f:
        for line in f:
            if line.find("0x") != 0:
                continue

            info = line.split('|')
            locInfo = info[0]

            _, funcInfo, fileInfo = locInfo.split()
            # remove parentheses
            fileInfo, lineInfo = fileInfo[1:-1].split(':')

            fileInfo = fileInfo.strip()
            funcInfo = funcInfo.strip()
            lineInfo = int(lineInfo.strip())

            # Find the tainted variable
            varInfo = re.search('\{.+\}', line)
            if varInfo != None:
                varInfo = varInfo.group()
                if 'unknownobj' in varInfo:
                    varInfo = None
                else:
                    varInfo = varInfo[1:-1]

            if fileInfo not in srcDict:
                continue

            if varInfo == None:
                varInfo = checkSrcVar(srcDict[fileInfo], fileInfo, lineInfo)

                if varInfo == None:
                    continue


            #print fileInfo, funcInfo, lineInfo, varInfo

            try:
                resultDict[funcInfo].add(varInfo)
            except:
                resultDict[funcInfo] = set()
                resultDict[funcInfo].add(varInfo)

        for function, variables in resultDict.items():
            for var in variables:
                outputStr = '[' + function + ":" + var + "::" + ']'
                print outputStr

if __name__ == "__main__":
    main()
