# Assignment: Week5
# Name: Koppula, Veera
# Date: 2010-07-05

## Load the ggplot2 package
library(ggplot2)
library("readxl")
library(MASS)
library(dplyr)
library(tidyverse)


theme_set(theme_minimal())

## load housing data
housing_data <- read_excel("data/week-6-housing.xlsx")
housing_data
typeof(housing_data)

##GroupBy,Summarize, Mutate, Filter, Select, and Arrange
#GroupBy
housing_data_bedrooms <- housing_data %>% group_by(bedrooms)
housing_data_bedrooms
#Summarize
housing_data_bedrooms %>% summarise(
  `Sale Price` = mean(`Sale Price`),
  square_feet_total_living = mean(square_feet_total_living)
)
#Mutate
library(dplyr)
housing_data_bedrooms <- housing_data_bedrooms %>%
  mutate(ctyname = case_when(is.na(ctyname) & zip5 == 98052 ~ "REDMOND", 
                             TRUE ~ ctyname))
housing_data_bedrooms
#Filter
housing_data_bedrooms %>% filter(`Sale Price` == 3995000)
#Select
housing_data_bedrooms %>%
  dplyr::select(bedrooms)
#Arrange
arrange(housing_data_bedrooms,housing_data_bedrooms$`Sale Price`)

##Using the purrr package – perform 2 functions on your dataset.  You could use zip_n, keep, discard, compact, etc.
library(purrr)
library(tidyverse)

housing_data_bedrooms

#show all rows with  bedrooms = 4
housing_data_bedrooms %>%
  filter(map_lgl(bedrooms, ~ all(c("4") %in% .x)))

#discard rows where city name is NA
mutate(housing_data_bedrooms, ctyname = map(ctyname, ~discard(.x, is.na)))

#Compacting the entire data set
map(housing_data_bedrooms,compact)

##Use the cbind and rbind function on your dataset
sale_price <- housing_data_bedrooms$`Sale Price`
square_footage <-housing_data_bedrooms$square_feet_total_living
sale_price_per_feet_living_space <- mapply(function(x, y) x/y, sale_price, square_footage)
housing_data_bedrooms_df <- data.frame(housing_data_bedrooms)
new_row <- c("2021-07-06", 500000,1,3,15,"R1","17121 NE TEST CT", 98052, "REDMOND","REDMOND", -122.1124,47.70139,9,10000,4,2,1,1,2021,0,"R4",20000,"R",2,50)
#cbind
house_data_bedrooms_cbind <- cbind(housing_data_bedrooms_df,sale_price_per_feet_living_space)
house_data_bedrooms_cbind
#rbind
house_data_bedrooms_rbind <- rbind(house_data_bedrooms_cbind,new_row)
house_data_bedrooms_rbind %>%
  filter(map_lgl(sale_price_per_feet_living_space, ~ all(c("50") %in% .x)))

##Split a string, then concatenate the results back together
sample_text <- "This is a great exercise to try for split and concatenate"
words_vector <- unlist(strsplit(sample_text, " "))
words_vector
paste(words_vector, collapse=" ")
