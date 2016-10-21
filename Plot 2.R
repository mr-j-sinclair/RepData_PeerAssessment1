## 0) Load dplyr
library(dplyr)


## 1) Mean total steps per day

## read data

working_directiory <- "C:/Users/IBM_ADMIN/Dropbox/General/Data_Science/coursea/5 - reproducible research/project 1"
setwd(working_directiory)
act <- read.csv(unz("repdata_data_activity.zip", "activity.csv"))

## Convert $date to as.Date()
act$date <- as.Date(x = act$date, "%Y-%m-%d")

## Calculae average number of steps taken each day
average_steps_per_day <- act %>% 
  group_by(interval) %>% 
  summarize(av_steps=mean(steps, na.rm=TRUE))



##Plot time series plot

plot(average_steps_per_day, type="l", main="Average number of steps taken across intervals", xlab="Interval", ylab="Average steps")

## Find which 5 minute interval, contains the maximum number of steps
average_steps_per_day[which.max(average_steps_per_day$av_steps) , 1]
