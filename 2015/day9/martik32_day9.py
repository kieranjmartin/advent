import numpy as np
import re
import itertools

with open('2015/inputs/day9.txt') as f:
    lines = f.readlines()
    
cities = np.zeros((len(lines), len(lines)))


names = [[re.split(" ",x)[0], re.split(" ",x)[2]] for x in lines]
flat_list = [item for sublist in names for item in sublist]
myset = set(flat_list)
myset = list(myset)
names = {myset[i]:i for i in range(0, len(myset))}

for line in lines:
  x = names[re.split(" ", line)[0]]
  y = names[re.split(" ", line)[2]]
  cities[x, y] = int(re.split(" ", line)[4])
  cities[y, x] = int(re.split(" ", line)[4])
  
## brute force solution

dist = np.inf
for combination in itertools.product(range(0, len(names)), repeat = len(names)):
  if any(combination.count(element) > 1 for element in combination):
    continue
  curr = 0
  for i in range(0, len(combination)-1):
    curr += cities[combination[i], combination[i+1]]
  if dist > curr:
    dist = curr
  
# part 2


dist = 0
for combination in itertools.product(range(0, len(names)), repeat = len(names)):
  if any(combination.count(element) > 1 for element in combination):
    continue
  curr = 0
  for i in range(0, len(combination)-1):
    curr += cities[combination[i], combination[i+1]]
  if dist < curr:
    dist = curr
