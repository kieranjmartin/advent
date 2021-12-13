import numpy as np
import re
import itertools

with open('2021/inputs/day13.txt') as f:
    lines = f.readlines()

lines = [line[0:(len(line)-1)] for line in lines]


xmax = 0
ymax = 0
folding = []
dots = []
for l in lines:
  if l[0] == "f":
    folding.append([re.findall("x|y",l)[0], re.split("=",l)[1]])
  else:
    numbers = re.split(",", l)
    x = int(numbers[0])
    y = int(numbers[1])
    dots.append([y, x])

ymax = int(folding[1][1])*2+1
xmax = int(folding[0][1])*2+1


paper = np.zeros((ymax, xmax))  
  
for d in dots:
  paper[d[0], d[1]] = 1
  

def folder(paperin, instruction,xmax, ymax):
  if instruction[0] == "x":
    paper1 = paperin[:,0:(int(instruction[1]))]
    paper2 = np.fliplr(paperin[:,int(instruction[1])+1:(xmax+1)])
  else:
    paper1 = paperin[0:(int(instruction[1])),:]
    paper2 = np.flipud(paperin[int(instruction[1])+1:(ymax+1),:])  
  return paper1 + paper2

papernew = paper
papernew = folder(papernew, folding[0], xmax, ymax)

# part2 

papernew = paper
for i in folding:
  papernew = folder(papernew, i, xmax, ymax)
  
  

  
papernew = paper1 + paper2 

papernew[papernew>0] = 8

print(papernew)
  
for i in range(0, np.shape(papernew)[0]):
  X = (papernew[i,:]).tolist()
  X = [" " if x == 0 else "#" for x in X]
  print("".join(X)

