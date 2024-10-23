library(stringr)
library(dplyr)
library(readr)
library(profvis)
library(data.table)
seeds <- c(79, 14, 55,13)

consume_map <- function(path){
  read_table(path, col_names = c("Destination", "Source", "Length"), show_col_types = FALSE)
}

map <- consume_map("2023/day5/test/seed-soil")

map_numbers <- function(source_number, map_in){
  add_end <- map_in %>% 
    mutate(
      End = Source + Length - 1
    )
  find_value <- add_end %>% 
    filter(source_number >= Source & source_number <= End)
  
  if(nrow(find_value) == 0) return(source_number)
  

  return(source_number + find_value[1,]$Destination - find_value[1,]$Source)
  
}

map_values <- function(number_in, test = "test"){
  
  seedsoil <- consume_map(paste0("2023/day5/", test, "/seed-soil"))
  soilfertiliser <- consume_map(paste0("2023/day5/", test, "/soil-fertiliser"))
  fertiliserwater <- consume_map(paste0("2023/day5/", test, "/fertiliser-water"))
  waterlight <- consume_map(paste0("2023/day5/", test, "/water-light"))
  lighttemperature <- consume_map(paste0("2023/day5/", test, "/light-temperature"))
  temperaturehumidity <- consume_map(paste0("2023/day5/", test, "/temperature-humidity"))
  humiditylocation <- consume_map(paste0("2023/day5/", test, "/humidity-location"))
  
  map_numbers(number_in, seedsoil) %>% 
    map_numbers(soilfertiliser) %>% 
    map_numbers(fertiliserwater) %>% 
    map_numbers(waterlight ) %>% 
    map_numbers(lighttemperature ) %>% 
    map_numbers(temperaturehumidity) %>% 
    map_numbers(humiditylocation) 
}

lapply(seeds, map_values, test = "input")

seeds <- c(1132132257, 323430997, 2043754183, 4501055, 2539071613, 1059028389, 1695770806, 60470169, 2220296232, 251415938, 1673679740, 
           6063698, 962820135, 133182317, 262615889, 327780505, 3602765034, 194858721, 2147281339, 37466509)


map_range <- function(source_number, source_max, map_in){
  add_end <- map_in %>% 
    mutate(
      End = Source + Length - 1
    )
  find_value <- add_end %>% 
    filter(source_number >= Source & source_number <= End)
  
  if(nrow(find_value) == 0) return(source_number)
  
  
  return(source_number + find_value[1,]$Destination - find_value[1,]$Source)
  
}



maps <- function(test= "test"){
  
  return(list(
    seedsoil = consume_map(paste0("2023/day5/", test, "/seed-soil")),
    soilfertiliser = consume_map(paste0("2023/day5/", test, "/soil-fertiliser")),
    fertiliserwater = consume_map(paste0("2023/day5/", test, "/fertiliser-water")),
    waterlight = consume_map(paste0("2023/day5/", test, "/water-light")),
    lighttemperature = consume_map(paste0("2023/day5/", test, "/light-temperature")),
    temperaturehumidity = consume_map(paste0("2023/day5/", test, "/temperature-humidity")),
    humiditylocation = consume_map(paste0("2023/day5/", test, "/humidity-location"))
  ))

}


reverse_values <- function(number_in, maps){
  
  reverse_map(
    reverse_map(
      reverse_map(
        reverse_map(
          reverse_map(
            reverse_map(
              reverse_map(
                number_in, maps$humiditylocation),
              maps$temperaturehumidity),
            maps$lighttemperature),
          maps$waterlight  ),
        maps$fertiliserwater ),
      maps$soilfertiliser),
    maps$seedsoil)
  
}


reverse_values(35, maps("test"))

seed_checker <- function(value, seed_range){
  dim(seed_range[value>= start & value <= end])[1] > 0
}

reverse_map <- function(source_number, map_in){
  find_value <- map_in[source_number >= Destination & source_number <= (Destination + Length -1)]
  if(dim(find_value)[1] == 0) return(source_number)
  return(source_number - find_value[1,]$Destination + find_value[1,]$Source)
  
}


find_min <- function(seed_range, my_maps, start = 0){
  seed <- reverse_values(start, my_maps)
  if(seed_checker(seed, seed_range)) return(FALSE)
  return(TRUE)
}

seeds <- c(1132132257, 323430997, 2043754183, 4501055, 2539071613, 1059028389, 1695770806, 60470169, 2220296232, 251415938, 1673679740, 
           6063698, 962820135, 133182317, 262615889, 327780505, 3602765034, 194858721, 2147281339, 37466509)

library(trampoline)


seed_range <- data.table(start = seeds[seq(1,(-1+length(seeds)), by = 2)],
                            end = seeds[seq(2,(length(seeds)), by = 2)] + seeds[seq(1,(length(seeds)-1), by = 2)])


consume_map <- function(path){
  as.data.table(read_table(path, col_names = c("Destination", "Source", "Length"), show_col_types = FALSE))
}

# seeds <- c(79, 14, 55,13)
# seed_range <- data.table(start = seeds[seq(1,(-1+length(seeds)), by = 2)],
#                          end = seeds[seq(2,(length(seeds)), by = 2)] + seeds[seq(1,(length(seeds)-1), by = 2)])


seeds <- c(1132132257, 323430997, 2043754183, 4501055, 2539071613, 1059028389, 1695770806, 60470169, 2220296232, 251415938, 1673679740, 
           6063698, 962820135, 133182317, 262615889, 327780505, 3602765034, 194858721, 2147281339, 37466509)

seed_range <- data.table(start = seeds[seq(1,(-1+length(seeds)), by = 2)],
                         end = seeds[seq(2,(length(seeds)), by = 2)] + seeds[seq(1,(length(seeds)-1), by = 2)])

consume_map <- function(path){
  as.data.table(read_table(path, col_names = c("Destination", "Source", "Length"), show_col_types = FALSE))
}

continue <- TRUE 
start <- 0
map_in <- maps("input")
while(continue){
  start <- start + 1
  continue <- find_min(seed_range,map_in , start = start)
 
}


reverse_map(11113, humiditylocation)











