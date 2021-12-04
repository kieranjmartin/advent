with open('2015/inputs/day9.txt') as f:
    lines = f.readlines()

def counter(string):
  count = 0
  result = []
  previous = None
  N = len(string)
  if(N == 1):
    return(["1", string])
  
  for i in range(0, N):
    if (i == 0):
      count += 1
      previous = string[i]
      continue
    if string[i] == previous:
      count += 1
    else:
      result.append(str(count))
      result.append(previous)
      count = 1
      previous = string[i]
    if(i == (N-1)):
      result.append(str(count))
      result.append(previous)
  return(result)

input = "1113122113"

for i in range(0, 40):
  input = counter(input)

len(input)

## part 2


input = "1113122113"

for i in range(0, 50):
  input = counter(input)

len(input)



