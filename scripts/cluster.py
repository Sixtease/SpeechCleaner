import numpy as np
import scipy.cluster
import sys

matrixfn = sys.argv[1]

a = np.loadtxt(matrixfn, delimiter = "\t")

l = scipy.cluster.hierarchy.linkage(a, method = 'complete')

np.savetxt(sys.stdout, l, delimiter="\t")
