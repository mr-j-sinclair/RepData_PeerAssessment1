## 0) Load dplyr
library(dplyr)


## 1) Mean total steps per day

## read data

working_directiory <- "C:/Users/IBM_ADMIN/Dropbox/General/Data_Science/coursea/5 - reproducible research/project 1"
setwd(working_directiory)
act <- read.csv(unz("repdata_data_activity.zip", "activity.csv"))

## Convert $date to as.Date()
act$date <- as.Date(x = act$date, "%Y-%m-%d")

## use Tapply to calculate total number of steps per day
steps_per_day <- act %>% 
  group_by(date) %>% 
  summarize(steps=sum(steps, na.rm=TRUE))

total_steps_per_day <- sum(steps_per_day$steps)

## make histrogram of total number of steps per day
hist(steps_per_day$steps, main="Histogram: Total number of steps per day", ylab="Count", xlab="Total number of steps per day")

## Calculate Mean and Median steps per day

      ## Mean
mean_steps_per_day <- mean(steps_per_day$steps)

      ## Median
median_steps_per_day <- median(steps_per_day$steps)

........
