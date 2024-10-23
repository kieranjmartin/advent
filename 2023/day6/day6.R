library(stringr)
library(dplyr)
library(readr)
library(profvis)
library(data.table)

times <- read.table("2023/day6/test")


distance <- function(time, speed ) speed * (time - speed)

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


speeds((51 + 92 + 68 + 90), (222+2031+1126+1225))

