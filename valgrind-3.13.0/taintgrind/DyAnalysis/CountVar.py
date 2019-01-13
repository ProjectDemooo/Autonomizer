import sys

path = sys.argv[1]
var = set()

with open(path) as f:
    for line in f:
        toks = line.split(':')
        if len(toks) < 4:
            continue

        var.add(toks[0] + ':' + toks[1])

    print len(var)
