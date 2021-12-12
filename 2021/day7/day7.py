import re
import numpy as np
with open('2021/inputs/day7.txt') as f:
    lines = f.readlines()
    
crabs = [re.split(",", line) for line in lines] 
crabs = [int(x) for x in crabs[0]]


minval = min(crabs)
maxval = max(crabs)

distance = np.Inf
savepoint = 0

## part 1
for point in range(minval, maxval+1):
  dist = sum([abs(x-point)  for x in crabs])
  if dist < distance:
    distance = dist
    savepoint = point
    

## part2

for point in range(minval, maxval+1):
  dist = sum([abs(x-point) * (abs(x-point)+1)/2 for x in crabs])
  if dist < distance:
    distance = dist
    savepoint = point
    
    
