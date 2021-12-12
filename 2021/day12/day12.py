import numpy as np
import re
import itertools

with open('2021/inputs/day12.txt') as f:
    lines = f.readlines()


    
def str_find(string, pattern):
  return len(re.findall(pattern, string))>0
  
  

lines = [x[0:(len(x)-1)] for x in lines]

names = [[re.split("-", x)[1], re.split("-", x)[0]] for x in lines]
names = [item for sublist in names for item in sublist]
names = set(names)
names = list(names)

pathdict ={x:None for x in names}

for l in lines:
  parts = re.split("-", l)
  if pathdict[parts[1]] is not None:
    pathdict[parts[1]].append(parts[0])
  else:
    pathdict[parts[1]] = [parts[0]]
  if pathdict[parts[0]] is not None:
    pathdict[parts[0]].append(parts[1])
  else:
    pathdict[parts[0]] = [parts[1]]
  
gateways = []

def pathfinder(location, visited):
  print(location)
  visited.append(location)
  if location == "start":
    print(visited)
    gateways.append([visited])
  else:
    locations = pathdict[location].copy()
    nloc = locations.copy()
    if len(nloc) > 0:
      for l in locations:
        if (l.lower() == l and l in visited) or l == "end":
          nloc.remove(l)
    if len(nloc) > 0:
      [pathfinder(l, visited.copy()) for l in nloc]    
    
pathfinder("end", [])  
len(gateways)

## part 2

  
gateways = []

def pathfinder(location, visited, flag = 0):
  visited.append(location)
  if location == "start":
    gateways.append([visited])
  else:
    locations = pathdict[location].copy()
    nloc = locations.copy()
    if len(nloc) > 0:
      for l in locations:
        if (l.lower() == l and (visited.count(l)>=2 or (flag==1 and visited.count(l)==1))) or l == "end":
          nloc.remove(l)
    if len(nloc) > 0:
      for l in nloc:
        if l.lower() == l and flag == 0 and visited.count(l)==1:
          pathfinder(l, visited.copy(), 1)
        else:
          pathfinder(l, visited.copy(), flag)
    
pathfinder("end", [])  
len(gateways)


