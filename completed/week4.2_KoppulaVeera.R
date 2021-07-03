# Assignment: Week4, Assignment 2
# Name: Koppula, Veera
# Date: 2010-06-21

## Load the ggplot2 package
library(ggplot2)
library("readxl")
library(MASS)

theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
##setwd("/home/jdoe/Workspaces/dsc520")

## Load the `data/acs-14-1yr-s0201.csv`
acs_df <- read.csv("data/acs-14-1yr-s0201.csv")
acs_df


## Load the `data/acs-14-1yr-s0201.csv`
acs_df <- read.csv("data/acs-14-1yr-s0201.csv")
acs_df

## load housing data
housing_data <- read_excel("data/week-6-housing.xlsx")
housing_data
typeof(housing_data)
##Use the apply function on a variable in your dataset
sale_price <- housing_data$`Sale Price`
sale_price
square_footage <-housing_data$square_feet_total_living
square_footage
sale_price_per_feet <- mapply(function(x, y) x/y, sale_price, square_footage)
sale_price_per_feet

##Use the aggregate function on a variable in your dataset
mean_sale_price_by_zip <- aggregate(housing_data$`Sale Price`,list(housing_data$zip5),mean)
mean_sale_price_by_zip

##Use the plyr function on a variable in your dataset – more specifically, I want to see you split some data, perform a modification to the data, and then bring it back together
library(dplyr)
library(tidyverse)
housing_data <- read_excel("data/week-6-housing.xlsx")
housing_data <- housing_data %>% 
  mutate(ctyname = case_when(is.na(ctyname) & zip5 <= 98502  ~ "REDMOND",
                                TRUE ~ ctyname))
housing_data
##Check distributions of the data
plot(housing_data$`Sale Price`/1000, housing_data$square_feet_total_living, xlab = "Sale Price(in 1000$)", ylab = "Lot Size(in Sq.Ft)", main = "Distribution of Sale Price vs Lot size")

##Identify if there are any outliers
summary(housing_data$`Sale Price`)
  #based on the above summary and also the data distribution plot shared above there are outliers in the data. The min sale price is shown as $698 while Mean & Median are around $600000
##Create at least 2 new variables
housing_data <- read_excel("data/week-6-housing.xlsx")
sale_price <- housing_data$`Sale Price`
square_footage <-housing_data$square_feet_total_living
sale_price_per_feet_living_space <- mapply(function(x, y) x/y, sale_price, square_footage)
mean_sale_price_by_zip <- aggregate(housing_data$`Sale Price`,list(housing_data$zip5),mean)

