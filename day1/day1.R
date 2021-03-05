# read in data
library(magrittr)

data <- file("day1/input") %>% 
    readLines()

# simple solution

all_sums <- data %>% 
    as.numeric()

for(i in 1:200){
    for(j in (1:200)[-i]){
        for(k in (1:200)[-c(i,j)]){
            
        
        sum <- all_sums[i] + all_sums[j] +all_sums[k]
        if(sum == 2020){
            outcome <- all_sums[i] * all_sums[j] * all_sums[k]
            break
        }
        }
    }
}

# do minus solution

minus_me <- 2020 - all_sums
solution <- which(all_sums %in% minus_me)
all_sums[solution]

#part 2

minus_me <- 2020 - all_sums




