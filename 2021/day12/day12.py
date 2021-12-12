import numpy as np
import re
import itertools

with open('2021/inputs/day12.txt') as f:
    lines = f.readlines()
    
    
def str_find(string, pattern):
  return len(re.findall(pattern, string))>0
  
  

lines = [x[0:(len(x)-1)] for x in lines]
x = np.zeros((len(lines), len(lines[0])))

i = 0
for line in lines:
  x[i,:] = [int(y) for y in line]
  i += 1

totflash = 0
for X in range(0, 400):
  flash = []
  for i in range(0, len(lines)):
    for j in range(0, len(lines[0])):
      x[i,j] = x[i,j] + 1
      if x[i,j] > 9:
         flash.append([i,j])
  flashed = []
  while (len(flash) > 0):
    flashed = flashed + flash
    newflash = []
    for e in flash:
      for n in [[e[0]-1,e[1]], [e[0]-1,e[1]-1], [e[0]-1,e[1] + 1], [e[0],e[1]-1], [e[0],e[1] + 1], [e[0]+1,e[1]], [e[0]+1,e[1]-1], [e[0]+1,e[1] + 1]]:
        if (n[0] >= 0 and n[0] < len(lines) and n[1] >= 0 and n[1] < len(lines[0])):
          x[n[0], n[1]] += 1
          if x[n[0], n[1]] > 9 and [n[0],n[1]] not in flashed and [n[0],n[1]] not in newflash:
            newflash.append([n[0], n[1]])
    flash = newflash
  if len(flashed) == len(lines) * len(lines[0]):
    print(len(flashed))
    break
  x[x>=10] = 0
      
print(X)
