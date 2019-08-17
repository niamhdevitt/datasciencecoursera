
url = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url,destfile="./Data/Dataset.zip",sep="/")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

?hist
hist(steps)

#hist
data <-read.csv("./data/activity.csv")
str(data)
summary(data)

daily_steps <- tapply(data$steps, data$date, sum)
hist(daily_steps, main = "Histogram of Total Daily Steps", col =4, xlab = "Steps")

#or
library(dplyr)
data2 <- data %>% select(date, steps) %>% group_by(date) %>% summarize(total_steps = sum(steps)) %>% na.omit()
hist(data2$total_steps, main = "Histogram of Total Daily Steps", col =4, xlab = "Steps", breaks= 20)

#mean/median
mean(data2$total_steps)
median(data2$total_steps)

#time series plot
data3 <- data %>% select(interval, steps) %>% na.omit() %>% group_by(interval) %>% summarize(ave_steps = mean(steps))

library(ggplot2)
ggplot(data3, aes(x=interval, y=ave_steps)) + geom_line() + 
  labs(y="Ave number of steps") +
  labs(title = "Average number of steps taken per day")

subset(data3, data3$ave_steps==max(data3$ave_steps))


data5 <- data_mean %>% select(date, steps) %>% group_by(date) %>% summarize(total_steps = sum(steps))
hist(data5$total_steps, main = "Histogram of Total Daily Steps (after Imp)", col =4, xlab = "Steps", breaks=20)
