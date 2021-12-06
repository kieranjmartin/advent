import re
with open('2021/inputs/day6.txt') as f:
    lines = f.readlines()
    
    
fish = [re.split(",", line) for line in lines] 
fish = [int(x) for x in fish[0]]
fish_array = np.array(fish)

generations = 80

# long solution
for i in range(0, 80):
  fish_array = fish_array - 1
  new = np.where(fish_array < 0)[0].size
  fish_array[np.where(fish_array < 0)] = 6
  fish_array = np.append(fish_array, [8 for i in range(0, new)])


fish_array.size


## more clever solution
fish_list = [0,0,0,0,0,0,0,0,0]

for x in fish:
  fish_list[x] +=1


for i in range(0, 256):
  fish_list = [fish_list[1], fish_list[2], fish_list[3], fish_list[4], fish_list[5], fish_list[6], fish_list[0] + fish_list[7], fish_list[8], fish_list[0]]
  #fish_list = new_list  
  
sum(fish_list)  
  
  
