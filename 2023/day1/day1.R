example_data <- "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

library(stringr)
library(testthat)

string_input <- readLines("2023/day1/input.txt")

get_value <- function(stringin){
  first <- as.numeric(str_sub(str_extract(stringin,"^\\D*\\d"), -1))
  second <- as.numeric(str_sub(str_extract(stringin,"\\d\\D*$"), 1, 1))
  output <- first * 10 + second
  list(
    first,
    second,
    sum(output)
  )
}

test <- readLines("2023/day1/test.txt")

get_value(test)
get_value(string_input )

# part 2

test <- readLines("2023/day1/test2.txt")

valid_digit <- c("one", "two", "three", "four",
                 "five", "six", "seven", "eight", "nine")

valid_digit_reverse <- stringi::stri_reverse(valid_digit)


digit  <- paste0(
  "(",
  paste(valid_digit, collapse = "|"),
  "|\\d)")

digit_reverse <- paste0(
  "(",
  paste(valid_digit_reverse, collapse = "|"),
  "|\\d)")

digit_converter <- function(digit_in, validation){
  
  for (i in seq_along(validation)){
    if(digit_in == validation[i]) return(i)
  }
  return(as.numeric(digit_in))
}

test_that("digit converter works properly",
          {
            for (i in 1:9){
              expect_equal(i, digit_converter(valid_digit[[i]], valid_digit ))
            }
            expect_equal(4, digit_converter("4", valid_digit ))
          })



get_value <- function(stringin){
  all_digits_forwards <- str_extract_all(stringin, digit)
  all_digits_backwards <- str_extract_all(stringi::stri_reverse(stringin),
                                          digit_reverse)
  
  
  first <- sapply(all_digits_forwards, function(x, v) digit_converter(x[[1]], v),
                  v = valid_digit )
  second <- sapply(all_digits_backwards, function(x,v) digit_converter(x[[1]],v),
                   v = valid_digit_reverse)
  output <- first * 10 + second
  sum(output)

}

test_that("get value works properly",
          {
            expect_equal(41, get_value("fiivesiixeiightfour1"))
          })

get_value(test)
get_value(string_input)




