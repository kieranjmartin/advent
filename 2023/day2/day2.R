library(stringr)

test <- readLines("2023/day2/test.txt")
input <- readLines("2023/day2/input.txt")

red <- 12
green <- 13
blue<- 14

value_compare <- function(string){
  colour <- str_extract(string, "[a-z]+")
  number <- as.numeric(str_extract(string, "\\d+"))
  if(colour == "red" & number > red) return(0)
  if(colour == "green" & number > green) return(0)
  if(colour == "blue" & number > blue) return(0)
  return(1)
}


set_reader <- function(set){
  values <- str_extract_all(set, pattern =  "\\d+ [a-z]+")
  prod(sapply(values, function(x) prod(sapply(x, value_compare))))

  }





set_finder <- function(string){
  sets <- lapply(str_split(string, "(:|;)"), function(x) x[-1])
  pass <- lapply(sets, set_reader)
  sum(which(pass == 1))   
  
}




set_finder(input)


# part 2

colour_max <- function(string, colour){
  only_col <- str_extract_all(string, pattern =  paste0("\\d+ ", colour))
  values_out <- str_extract_all(only_col, pattern =  "\\d+")
  if(length(values_out) == 0) return(0)
  max(sapply(values_out, as.numeric))
}

set_reader <- function(set){
  values <- str_extract_all(set, pattern =  "\\d+ [a-z]+")
  min_col <- lapply(
    values,
    function(x){
      c(colour_max(x, "blue"), colour_max(x, "red"), colour_max(x, "green"))
    }
  )
  sum(sapply(min_col, prod))
  
}
set_reader(input)

