import re
import numpy as np
with open('2021/inputs/day9.txt') as f:
    lines = f.readlines()
    
lines = [line[0:(len(line)-1)] for line in lines]
    
x = np.zeros((len(lines), len(lines[0])))

i = 0
for line in lines:
  x[i,:] = [int(x) for x in line]
  i = i +1

lowpoint = []
for i in range(0, len(lines)):
  for j in range(0, len(lines[0])):
    neighbours =[[i-1, j], [i+1, j], [i, j-1], [i, j + 1]]
    for n in neighbours:
      if (n[0]<0 or n[0] >= len(lines) or n[1]<0 or n[1] >= len(lines[0])):
        neighbours.remove(n)
    if all([x[i,j]<x[y[0],y[1]] for y in neighbours]):
      lowpoint.append(x[i,j])

sum([x+1 for x in lowpoint])      


## part 2

# need coordinates of lowpoints

lowpoint = []
for i in range(0, len(lines)):
  for j in range(0, len(lines[0])):
    neighbours =[[i-1, j], [i+1, j], [i, j-1], [i, j + 1]]
    for n in neighbours:
      if (n[0]<0 or n[0] >= len(lines) or n[1]<0 or n[1] >= len(lines[0])):
        neighbours.remove(n)
    if all([x[i,j]<x[y[0],y[1]] for y in neighbours]):
      lowpoint.append([i,j])
      
      
def basinfinder(location_cur, locations, prev):
  
  i = location_cur[0]
  j = location_cur[1]
  neighbours =[[i-1, j], [i+1, j], [i, j-1], [i, j + 1]]
  newneighbours = neighbours.copy()
  for n in neighbours:
    if (n[0]<0 or n[0] >= len(lines) or n[1]<0 or n[1] >= len(lines[0])):
        newneighbours.remove(n)
  neighbours = newneighbours
  if len(prev)>0:
    for p in prev:
      if p in neighbours:
        neighbours.remove(p)
  prev.append([i,j])
  for n in neighbours:
      if (n[0]<0 or n[0] >= len(lines) or n[1]<0 or n[1] >= len(lines[0])):
        neighbours.remove(n)
  
  nloc =  []     
  for n in neighbours:
    if x[n[0], n[1]]!=9:
      nloc.append(basinfinder(n, locations, prev))
  for entries in nloc:
    locations = locations + entries
  locations = locations + [location_cur] 
  return locations



basins = [basinfinder(low, [], []) for low in lowpoint]
lengths = []
for base in basins:
  uniquebase =  [x for i, x in enumerate(base) if i == base.index(x)]
  lengths.append(len(uniquebase))

lengths    

top3 = [0,0,0]
for l in lengths:
  if l> top3[0]:
    top3[1] = top3[0]
    top3[0] = l
  elif l > top3[1]:
    top3[2] = top3[1]
    top3[1] = l
  elif l > top3[2]:
    top3[2] = l
    

    
import math


def follow(row, col, s):
    for y, x in [(-1, 0), (1, 0), (0, 1), (0, -1)]:
        if (row + y, col + x) not in s:
            if row + y >= 0 and row + y < len(data):
                if col + x < len(data[0]) and col + x >= 0:
                    if data[row + y][col + x] != "9":
                        s.add((row + y, col + x))
                        follow(row + y, col + x, s)
    return s


data = open("2021/inputs/day9.txt").read().strip().split("\n")
lows = []
basins = []
for row in range(len(data)):
    for col in range(len(data[0])):
        cur = int(data[row][col])
        n = int(data[row - 1][col]) if row > 0 else 9999
        s = int(data[row + 1][col]) if row < len(data) - 1 else 9999
        e = int(data[row][col + 1]) if col < len(data[0]) - 1 else 9999
        w = int(data[row][col - 1]) if col > 0 else 9999
        if cur < min([n, s, e, w]):
            lows.append(cur)
            basins.append(len(follow(row, col, {(row, col)})))
print(f"Part 1: {sum([x + 1 for x in lows])}")
print(f"Part 2: {(sorted(list(basins), reverse=True)[:3])}")  
  
  
  
  
  
  
  
  
