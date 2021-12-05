import re
import numpy as np
with open('2021/inputs/day5.txt') as f:
    lines = f.readlines()
    
    
splitline = [re.split("->", line) for line in lines]   

coord = [[re.split(",", x) for x in line] for line in splitline]

xmin = np.Inf
ymin = np.Inf

xmax = -np.Inf
ymax = -np.Inf


for location in coord:
  xmi = min(int(location[0][0]), int(location[1][0]))
  ymi = min(int(location[0][1]), int(location[1][1]))
  xma = max(int(location[0][0]), int(location[1][0]))
  yma = max(int(location[0][1]), int(location[1][1]))
  if xmi < xmin:
    xmin = xmi
  if ymi < ymin:
    ymin = ymi
  if xma > xmax:
    xmax = xma
  if yma > ymax:
    ymax = yma
    
locgrid = np.zeros((xmax-xmin, ymax-ymin))

for loc in coord:
  x1 = int(loc[0][0]) - xmin
  x2 = int(loc[1][0]) - xmin
  y1 = int(loc[0][1]) - ymin
  y2 = int(loc[1][1]) - ymin
  if(x2<x1):
    a = x1
    x1  = x2
    x2 = a
  if(y2<y1):
    a = y1
    y1 = y2
    y2 = a
  
  if((x1 == x2) | (y1 == y2)):
    locgrid[x1:(x2+1), y1:(y2+1)] += 1
    print("found one")
    
total = 0
for i in np.nditer(locgrid):
  if i>1:
    total += 1

    
locgrid = np.zeros((xmax-xmin, ymax-ymin))

for loc in coord:
  x1 = int(loc[0][0]) - xmin
  x2 = int(loc[1][0]) - xmin
  y1 = int(loc[0][1]) - ymin
  y2 = int(loc[1][1]) - ymin

  
  if((x1 == x2) | (y1 == y2)):
    if(x2<x1):
      a = x1
      x1  = x2
      x2 = a
    if(y2<y1):
      a = y1
      y1 = y2
      y2 = a
    locgrid[x1:(x2+1), y1:(y2+1)] += 1
    print("found one")
  else:
    for i in range(0, (1 + abs(x2-x1))):
      xz = 1
      yz = 1
      if x1 > x2:
        xz = -1
      if y1 > y2:
        yz = -1
      locgrid[x1 + xz * i, y1 + yz * i] += 1
    
total = 0
for i in np.nditer(locgrid):
  if i>1:
    total += 1

