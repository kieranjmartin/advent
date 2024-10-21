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


