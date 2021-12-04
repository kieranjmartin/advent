with open('2021/inputs/day4.txt') as f:
    lines = f.readlines()
    
lines = [x[0:(len(x)-1)] for x in lines]
lines = [x.strip() for x in lines]

pattern = re.split(",",lines[0])
pattern = [int(x) for x in pattern]

class bingo_card:
  def __init__(self,bingo):
    self.bingocard = []
    self.filled = [[],[],[],[],[]]
    self.winnervalue = None
    for line in bingo:
      self.bingocard.append([int(x) for x in re.split(" +",line)])
  def num(self, number):
    for i in range(0, len(self.bingocard)):
      if number in self.bingocard[i]:
        self.bingocard[i].remove(number)
        self.filled[i].append(number)
        if len(self.filled[i]) == 5:
          self.winner(number)
  def winner(self, win):
      self.winnervalue = (sum([sum(x) for x in self.bingocard]) * win)


N = len(lines)
bingoN = (N-1)/6
bingocards = []

for i in range(0, int(bingoN)):
  bingocards.append(bingo_card(lines[(6*(i)+2):(6*(i+1)+1)]))

winner = None
for number in pattern:
  for card in bingocards:
    card.num(number)
    if card.winnervalue is not None:
      winner = card.winnervalue
  if winner is not None:
    break
  
winner


## part 2

bingocards = []

for i in range(0, int(bingoN)):
  bingocards.append(bingo_card(lines[(6*(i)+2):(6*(i+1)+1)]))
  
winner = None 
for number in pattern:
  for card in bingocards:
    card.num(number)
    if card.winnervalue is not None:
      if len(bingocards) > 1:
        bingocards.remove(card)
      else:
        winner = card.winnervalue
  if winner is not None:
    break  

winner
