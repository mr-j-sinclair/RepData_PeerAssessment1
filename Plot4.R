## 0) Load dplyr
library(dplyr)
library(chron)


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

## ................................................... ##

## Are there differences in activity patterns between weekdays and weekends


#1) Create a new factor variable with two levels - "weekday" and "weekend"
library(chron)
act$weekend <- as.factor(is.weekend(act$date))
library(plyr)
act$weekend <- revalue(act$weekend, c("TRUE" = "Weekend", "FALSE" = "Weekday"))

#2) make a pannel plot containing a time series plot of 
## the 5 minute interval  (x-axis) and the average number of steps taken

g <- ggplot(data=act, aes(x=interval, y=steps))
g + facet_grid(weekend ~ .) + geom_line()

