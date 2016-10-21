## 0) Load dplyr
library(dplyr)


## 1) Mean total steps per day

## read data

working_directiory <- "C:/Users/IBM_ADMIN/Dropbox/General/Data_Science/coursea/5 - reproducible research/project 1"
setwd(working_directiory)
act <- read.csv(unz("repdata_data_activity.zip", "activity.csv"))

## Convert $date to as.Date()
act$date <- as.Date(x = act$date, "%Y-%m-%d")


## 1) Calculate and report the total number of missing values in the dataset
sum(is.na(act))

## Devise a strategy for filling in all of the missing values in the data set

   # act$steps[is.na(act$steps)] <- mean(act$steps, na.rm = TRUE)

average_steps_per_interval<- act %>% 
  group_by(interval) %>% 
  summarize(av_steps=mean(steps, na.rm=TRUE))

## 3) Create a new dataset that is equal to the original dataset 
## but with the missing data filled in

act$steps[is.na(act$steps)] <- average_steps_per_interval$av_steps

## 4) make a histogram of the total number of steps taken per day.
## and calculate and report the mean and median total number of steps per day
## do these differ from the values in the first part of the assignment?
## What was the impact of imputing missing data on estimates of total?

  ## total number of steps per day
steps_per_day<- act %>% 
  group_by(date) %>% 
  summarize(num_steps=sum(steps))

total_steps_per_day <- sum(steps_per_day$num_steps)

  ## make histogram
hist(steps_per_day$num_steps, main="Histogram: Total number of steps per day [imputed]",
     ylab="Count", 
     xlab="Total number of steps per day")

  ## calculate mean and median
mean_steps_per_day <- mean(steps_per_day$num_steps)
median_steps_per_day <- median(steps_per_day$num_steps)
