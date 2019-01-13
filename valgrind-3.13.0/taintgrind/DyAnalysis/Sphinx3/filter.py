import sys

var = set()

for idx, i in enumerate(sys.argv):
    if idx == 0:
        continue
    if idx == 1:
        with open(sys.argv[idx]) as f:
            for line in f:
                var.add(line)
    else:
        tmp = set()
        with open(sys.argv[idx]) as f:
            for line in f:
                tmp.add(line)

        var -= tmp

for v in var:
    print v.strip()[1:-1]
