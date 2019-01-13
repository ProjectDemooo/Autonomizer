taintVarName=$1
taintVarNameLen=${#taintVarName}

if [ $taintVarNameLen -eq 0 ]
then
  echo "Please enter the tainted variable name"
  exit 1
fi

# Step 1:
# Run taintgrind to get dynamic taint analysis result
# taint input variable: image
# output: taint message

../../build/bin/valgrind --tool=taintgrind ../canny/a.out ../canny/lenagrey.pgm 2 0.6 0.8 1 2> $1.vg

# Step 2:
# Analyze the taintgrind result
# Input: source directory, tainted result log file
# output: tainted variables
python Vg2Dy.py ../canny/ $1.vg > $1.dy

