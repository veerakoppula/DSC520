# Assignment: ASSIGNMENT 3.1
# Name: Koppula, Veera
# Date: 2010-06-21

## Load the ggplot2 package
library(ggplot2)
theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
##setwd("/home/jdoe/Workspaces/dsc520")

##What are the elements in your data (including the categories and data types)?
acs_df <- read.csv("data/acs-14-1yr-s0201.csv")
acs_df

class(acs_df)
##3.2 - Please provide the output from the following functions: str(); nrow(); ncol()
##str() result
str(acs_df)
##nrow() result
nrow(acs_df)
##ncol() result
ncol(acs_df)

##3.3 Create a Histogram of the HSDegree variable using the ggplot2 package.
##Set a bin size for the Histogram.
##Include a Title and appropriate X/Y axis labels on your Histogram Plot.
ggplot(acs_df, aes(HSDegree)) + geom_histogram(colour = "black", fill = "grey", binwidth = 1,bins = 1) +  ggtitle("High School Graduation Distribution") + labs(x = "% with HS Degree", y = "Count by County")


##4.6 Include a normal curve to the Histogram that you plotted.
ggplot(data = acs_df) + geom_histogram(mapping = aes(x = HSDegree, y=..density..),color="grey", binwidth = 1,bins = 1) + ggtitle("High School Graduation Dist w/ Normal Curve") + xlab("% With HS Degree") + ylab("Count by County")+ stat_function(fun = dnorm, color = "blue", args = list(mean = mean(acs_df$HSDegree), sd = sd(acs_df$HSDegree)))

## 5. Create a Probability Plot of the HSDegree variable.
ggplot(acs_df, aes(sample=HSDegree)) + stat_qq(col="blue") + stat_qq_line(col="black")

## 7.Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() function. Include a screen capture of the results produced.
stat.desc(acs_df$HSDegree, basic=FALSE, norm=TRUE)

stat.desc(acs_df$BachDegree, basic = FALSE, norm = TRUE)
