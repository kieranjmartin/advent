library(stringr)
library(dplyr)
library(readr)
library(profvis)
library(data.table)

times <- read.table("2023/day6/test")


distance <- function(time, speed ) speed * (time - speed)

binary_search <- function(time, record, start, end, last_big){
  
  midpoint <- floor(start + (end - start)/2)
  if (midpoint == start){
    bigger <- distance(time, midpoint) > record
    if(bigger) return(midpoint)
    return(last_big)
  }
  bigger <- distance(time, midpoint) > record
  if(bigger){
    last_big <- midpoint
    binary_search(time, record, start = start, end = start + floor((end-start)/2), last_big)
  }else{
    binary_search(time, record, start = start + floor((end-start)/2), end = end, last_big)
  }
    
}

calculate_total <- function(time, record){
  endpoint <- binary_search(time, record, 0, time, 0)
  2*(time/2 - endpoint) + 1
}


speeds <- function(time, record){
  maxima <- time/2
  count <- 0
  continue <- TRUE
  if (maxima == floor(maxima)){
    if(distance(time, maxima) > record){
      count <- count + 1
    } else{
      continue <- FALSE
    }
    nextval <- maxima - 1
  } else{
    nextval <-  floor(maxima)
  }
  while(continue & nextval >= 1){
    if(distance(time, nextval) > record){
      count <- count + 2
      nextval <- nextval - 1 
    } else{
      continue <- FALSE
    }
  }
  return(count)
}




speeds(51, 222) * speeds(92, 2031) * speeds(68, 1126)  * speeds(90, 1225)


calculate_total((51926890), (222203111261225))

