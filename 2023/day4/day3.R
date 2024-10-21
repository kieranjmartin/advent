library(stringr)
library(dplyr)

test <- readLines("2023/day3/test.txt")
input <- readLines("2023/day3/input.txt")

neighbour_finder <- function(x,y, matrixin = mat_numbers){
  neighbour <- c()
  N <- nrow(matrixin)
  for (i in -1:1){
    for (j in -1:1){
      if(!(i==0 & j == 0) & x+i<N & y + j <N){
        entry <- matrixin[x+i, y + j]
        if(length(entry) >0 ) neighbour <- c(neighbour, entry)
      }
      
    }
  }
  
  any(!str_detect(neighbour, "(\\d)|\\."))
}

adjacency_finder <- function(vector){
  runs <- 1
  value <- 1
  for (i in 2:length(vector)){
      if(vector[i] - vector[i-1] != 1){
        value = value + 1
      }
    runs <- c(runs, value)
  }
  runs
}

get_value <- function(symbols, x, y, matrixin){
  if(any(symbols)){
    
    values <- as.numeric(matrixin[x[1],y])
    total <- 0 
    for (i in 1:length(y)){
      total <- total + values[i] * 10 ^ (length(y)-i)
    }
    return(total)
    
  }
  return(0)
}

calculate_locations <- function(stringin){
  mat_numbers <-matrix(unlist(strsplit(stringin, split = "")), 
                       ncol = length(stringin), byrow = TRUE)
  
  numbers <- mat_numbers
  
  numbers[] <- vapply(numbers, str_detect, logical(1), pattern = "\\d")
  
  
  number_location <- which(numbers == "TRUE", arr.ind = TRUE)      
  number_location <- number_location[order(number_location[,1]),]
 tibble(row = number_location [,1], col = number_location [,2],
                      symbol = unlist(Map(neighbour_finder, 
                                          number_location[,1], 
                                          number_location[,2],
                                          MoreArgs = list(matrixin = mat_numbers))
                                      ))
}

locations_test <- calculate_locations(test)

locations_full <- calculate_locations(input)

get_coords <- function(location_in){
  location_in %>% 
    group_by(row) %>% 
    mutate(
      run = adjacency_finder(col)
    )
}

coords_test <- get_coords(locations_test )
coords_full <- get_coords(locations_full )

get_parts <- function(coords_in, stringin){
  coords_in %>% 
    group_by(row, run) %>% 
    summarise(value = get_value(symbol, row, col, 
                                matrix(unlist(strsplit(stringin, split = "")), 
                                       ncol = length(stringin), byrow = TRUE))) %>% 
    filter(value!=0)
}

parts_test<- get_parts(coords_test, test)
parts_full <- get_parts(coords_full, input)


parts_test %>% 
  ungroup() %>% 
  summarise(total = sum(value))

parts_full %>% 
  ungroup() %>% 
  summarise(total = sum(value))

# part 2

get_stars <- function(parts, coords, stringin){
  parts_locations <- parts %>% right_join(select(coords, row, col, run),
                                          by = c("row", "run"))
  
  
  stars <-  matrix(unlist(strsplit(stringin, split = "")), 
                   ncol = length(stringin), byrow = TRUE)
  
  stars[] <- vapply(stars, str_detect, logical(1), pattern = "\\*")
  
  neighbour_finder <- function(x,y, matrixin = parts_locations){
    parts <- c()
    N <- nrow(matrixin)
    for (i in -1:1){
      for (j in -1:1){
        if(!(i==0 & j == 0) & x+i<N & y + j <N){
          
          entry <- pull(filter(matrixin, row ==x+i, col==y+j), value)
          if(length(entry) >0 ) parts <- c(parts, entry)
        }
        
      }
      
    }
    parts <- unique(parts)
    if(length(parts) == 2) return(prod(parts))
    return(0)
  }
  
  
  star_location <- which(stars == "TRUE", arr.ind = TRUE)      
  star_location <- star_location[order(star_location[,1]),]
  
  tibble(row = star_location[,1], col = star_location[,2],
         value = unlist(Map(neighbour_finder, star_location[,1], star_location[,2],
                            MoreArgs = list(matrixin = parts_locations))))
}

get_stars(parts_test, coords_test, test)


gears <- get_stars(parts_full, coords_full, input)
