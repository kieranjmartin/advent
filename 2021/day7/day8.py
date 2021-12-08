import re
import numpy as np
with open('2021/inputs/day8.txt') as f:
    lines = f.readlines()
    
digit_dict = {0:"abcefg", 1:"cf", 2:"acdeg", 3:"acdfg",4:"bcdf",5:"abdfg",6:"abdefg",7:"acf",8:"abcdefg",9:"abcdfg"}
new_dict = {i:None for i in range(0, 10)}

lines = [line[0:(len(line)-1)] for line in lines]

output = [x[1] for x in [re.split("\|",line) for line in lines]]
output = [re.split(" ", x) for x in output]
input = [x[0] for x in [re.split("\|",line) for line in lines]]
input = [re.split(" ", x) for x in input]



countunique = sum([len([idx for idx, el in enumerate(x) if len(el) in [2, 4, 3, 7]]) for x in output])


def regexmaker(string):
  str = "(" + string[0]
  for i in string[1:len(string)]:
    str = str +  "|" + i
  str = str + ")"
  return(str)

def stringsort(string):
   return "".join(sorted(string))

def decoder(inputin, outputin):
  lens = [len(x) for x in inputin]
  new_dict[1] = stringsort(np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 2]][0])
  new_dict[4] = stringsort(np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 4]][0])
  new_dict[7] = stringsort(np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 3]][0])
  new_dict[8] = stringsort(np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 7]][0])
  
  # disambiguate 6 and 9
  
  len6 = np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 6]]
  index = [idx for idx, el in enumerate(len6) if len(re.sub(regexmaker(new_dict[1]),"",el)) == 5]
  new_dict[6] = stringsort(len6[index][0])
  len6 = np.delete(len6, index)
  new_dict[0] = stringsort(len6[[idx for idx, el in enumerate(len6) if len(re.sub(regexmaker(new_dict[4]),"",el)) == 3]][0])
  new_dict[9] = stringsort(len6[[idx for idx, el in enumerate(len6) if len(re.sub(regexmaker(new_dict[4]),"",el)) == 2]][0])
  
  len5 = np.array(inputin)[[idx for idx, el in enumerate(lens) if el == 5]]
  index = [idx for idx, el in enumerate(len5) if len(re.sub(regexmaker(new_dict[1]),"",el)) == 3]
  new_dict[3] = stringsort(len5[index][0])
  len5 = np.delete(len5, index)
  new_dict[2] = stringsort(len5[[idx for idx, el in enumerate(len5) if len(re.sub(regexmaker(new_dict[4]),"",el)) == 3]][0])
  new_dict[5] = stringsort(len5[[idx for idx, el in enumerate(len5) if len(re.sub(regexmaker(new_dict[4]),"",el)) == 2]][0])
  
  outputin = outputin[1:len(outputin)]
  ret_value = [list(new_dict.keys())[list(new_dict.values()).index(stringsort(x))] for x in outputin]
  return int("".join([str(x) for x in ret_value]))

total = 0 
for i in range(0, len(input)):
  total = total + decoder(input[i], output[i])

  
  
  
