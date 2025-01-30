dataset1<-read.csv(file.choose(), header=T, sep=",")
str(dataset1)
library(pastecs)
options(digits=2)
stat.desc(dataset1)
summary(dataset1)
IQR(dataset1$variable1)
hist(dataset1$variable1, xlab = "Variable 1 (au)", main="")
boxplot(dataset1$variable1, xlab = "Variable 1 (au)")

## Q1
weight<-c(12.4, 21.5, 34.6, 75.4, 67.5, 67.5, 90.1, 34.5, 78.4, 98.3)
pebble<-data.frame(weight)
summary(pebble$weight)
stat.desc(pebble)

## Q2
dataset2<-c(19, 27, 69, 17, 30, 55, 87, 32, 15, 16, 12, 21, 10, 12, 19, 18, 50, 18)
hist(dataset2)

median(dataset2)
IQR(dataset2)

## Q3
toothlen<-c(9, 10, 10, 11, 6, 7, 8, 10, 12, 13, 9, 11)
stat.desc(toothlen)
