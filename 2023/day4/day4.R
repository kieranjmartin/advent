library(stringr)
library(dplyr)
library(readr)


test <- readLines("2023/day4/test.txt")

read_cards <- function(stringin){
  split_values <- read_delim(stringin, delim = ":", col_names = FALSE)
  numbers <- read_delim(
    paste(split_values$X2, collapse = "\n"), delim = "|", col_names = FALSE)
  winning <- read_table(
    paste(trimws(numbers$X1), collapse = "\n"), col_names = FALSE)
  entries <- read_table(
    paste(trimws(numbers$X2), collapse = "\n"), col_names = FALSE)
  return(tibble(
    winning = winning, entry = entries
  ))
}

count_function <- function(winning, entry){
  winners <- (sum(unlist(entry) %in% unlist(winning)))
  if (winners == 0) return(0)
  2 ^ (winners - 1)
}


calculate_value <- function(cards_in){
  cards_in %>% 
    rowwise() %>% 
    mutate(
      score = count_function(winning, entry)
    ) %>% 
    pull(score) %>% 
    sum()
  
}


 read_cards("2023/day4/test.txt") %>% 
   calculate_value()

 
 read_cards("2023/day4/input.txt") %>% 
   calculate_value()

 ## part 2
 
winner_count <- function(row_number, winning, entry){

   winners <- (sum(unlist(entry) %in% unlist(winning)))
   if (winners == 0) return(list(c())) 
   return(list(row_number + seq(1, winners)))
 }
 


 calculate_value <- function(cards_in){
   
   winning_cards <- cards_in %>% 
     mutate(row = row_number()) %>% 
     rowwise() %>% 
     mutate(
       victory = winner_count(row, winning, entry)
     ) %>% 
     ungroup()
   
   index <- 1
   copy_winners <- winning_cards %>% 
     mutate(multiplier = 1)
   
   while(index <= nrow(copy_winners)){
     new_rows <- unlist( copy_winners[index,]$victory)
     new_rows <- new_rows[which(new_rows %in% copy_winners$row)]
     if (length(new_rows) >= 1 ){
       copy_winners[new_rows,]$multiplier <- copy_winners[new_rows,]$multiplier + copy_winners[index,]$multiplier
     }
     index <- index + 1
   }
   sum(copy_winners$multiplier)
   
   
 }


 
 read_cards("2023/day4/test.txt") %>% 
   calculate_value()
 
 read_cards("2023/day4/input.txt") %>% 
   calculate_value()
 