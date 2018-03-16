#!/usr/bin/env python

from random import randint, random

N = 1000
MIN = 3
MAX = 10
FEATURES = 100
DENSITY = 0.1

def random_feature_vector(k):
    return [int(random() < DENSITY)for i in range(k)]

for listid in range(N):
    size = randint(MIN, MAX)
    for rank in range(size):
        features = random_feature_vector(FEATURES)
        feature_vector = ','.join([str(x) for x in features])
        print "{0},{1},{2}".format(listid, feature_vector, rank+1)
