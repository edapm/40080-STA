################################################################################################################
# Statistical Methods  # 
# Liz Hamilton 2020    #
################################################################################################################

################################################################################################################
# WEEK 7 Self Test Exercise
################################################################################################################

###########################
# Clearing the workspace  #
###########################

# Clear your workspace as usual:
rm(list=ls())
library(tidyr)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)

# TASK 1: Bring in the data set called GlobalTempCo2 which you should download from Canvas. Then look at
# the structure of the data. The data are Global Annual Temperature Anomalies on Land and Annual 
# Global Average CO2 for 1959 - 2012.
GlobalTempCo2 <- read.csv("GlobalTempCo2.csv", header = TRUE)

# TASK 2: Examine the data by looking at plots and normality
boxplot(GlobalTempCo2$Land)
boxplot(GlobalTempCo2$CO2)

histogram(GlobalTempCo2$Land)
histogram(GlobalTempCo2$CO2)

describe(GlobalTempCo2$Land)
describe(GlobalTempCo2$CO2)

# What do the plots say about normality?
# non-normal

# TASK 3: Run a test for normality as well. 
shapiro.test(GlobalTempCo2$Land)
shapiro.test(GlobalTempCo2$CO2)

# Do the normality test support this?
# Yes  

# TASK 4: Plot the data and visualise the correlations before running an appropriate test. 
plot(GlobalTempCo2$Land, GlobalTempCo2$CO2)

res<-cor.test(GlobalTempCo2$Land, GlobalTempCo2$CO2, method="spearman", exact=F)
res

# What is the value for the correlation coefficient and is the relationship a significant one?
# r = 0.960, p-value < 0.001, significant
