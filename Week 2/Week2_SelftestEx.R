# Statistical Methods 
## Liz Hamilton 2022


### Week 2: Frequency distributions, normality, confidence intervals and transformations

### Self-test exercise

###########################
# Clearing the workspace  #
###########################

# It is a good idea to clear your workspace every time you start a new session in R. The
# code below lets you do this. Also check that the global environment is clear (click the
# little brush) and the same for plots if you have any.
rm(list=ls())

##########################
# Importing a file       # 
##########################
# Import the data file that you have downloaded named "castor"

castor<-read.csv(file.choose(),  header=T, sep=",")

# Examine the variables; you have a number of variables in this file. In fact the 
# temperature of two European beavers (Castor fiber) have been taken every every ten 
# minutes over a number of days. The researchers have also recorded whether the animals 
# were active or inactive. It is a good idea to check how R is reading the data.

# TASK
# Look back to Week 1 and find the code that allows you to examine the structure of your 
# data. How is R interpreting the variables for each beaver, the date, time, temperature
# and activity?

# ANSWER
str(castor)
 
# All the variables are being read in as integers except for temperature which is numeric.

# QUESTION
# We can see that there are 5 variables and that most of them are integers and one of 
# them is numeric. Has R made a mistake in any of these variables e.g. is there a 
# variable that should be a factor rather than an integer?

# ANSWER
# beaver_no should be a factor

# We can re-code variables using the "as.factor" or "as.numeric" etc.

castor$beaver_no<-as.factor(castor$beaver_no)

# TASK
# Run the structure code again and see if it has changed. Notice that this has 
# overwritten the previous variable. If we wanted to create a new variable and keep the 
# old one, we would give the new variable a unique name e.g. castor$beaver_no1

# ANSWER
str(castor)

# TASK
# Use the lattice package to produce a histogram that splits the temperature for each 
# beaver. Remember to load the package into the workspace if you haven't already. Then
# copy and modify the code for "histogram" from the practical coding file. 

# ANSWER
library(lattice)
histogram(~temp|beaver_no,data=castor)


# QUESTION
# What is your first assessment of normality?

# ANSWER
# Beaver1 is more normal than Beaver2

# TASK
# Change the coding variable so that you examine temperature by beaver activity.

# ANSWER
histogram(~temp|active,data=castor)

# It is a little difficult to see but there is an orange line in the title bar that 
# tells you which plot relates to the coding variable. The left plot is "0", not active.
# The right plot is "1" which is active.

# QUESTION
# What do you think about the distribution?

# ANSWER
# Looks normal


# We can also check normality using a statistical test:

############################
# Checking normality       # 
############################

# The two main tests for normality are the Shapiro-Wilk test and the Kolmogorov-Smirnov 
# test. Use the Kolmogorov-Smirnov test if you have a lot of data points (at least 1000,
# preferably 2000). Otherwise use the Shapiro-Wilk test.

# TASK 
# Find a function from this week's code that allow you to test normality of the data by 
# factor. I.e. we want to run two Shapiro tests at the same time on the temperature of 
# each beaver. HINT: use tapply!

# ANSWER
tapply(castor$temp, castor$beaver_no, shapiro.test)

# Notice that the temperature comes first and the factor varaiable comes second. The 
# third bit of code tells R to apply the Shapiro test. 

# QUESTION
# Examine the output for the Shapiro test. Are your data normal? What about if you split
# by activity level rather than by beaver number. 

# ANSWER
# Both suggest non-normality

# QUESTION
# What do we do now we know that our data are not normal?

# ANSWER
# Must use a non-parametric test or transform the data.


############################
# Transforming data        #
############################

# We could transform the data if we thought that it would make the distribution more 
# normal. A word of caution here...although there are some fields where data 
# transformation is a usual process, there are many instances where it is not an 
# appropriate thing to do. If in doubt, you should use a non parametric test rather than
# transform your data. 

# But for now let's learn how to do it. Tranforming data in R is easy. We can either 
# create a new variable and then use the same code with the new transformed variable 
# substituted for the old. Or we can use brackets to apply the transformation function 
# to the old variable. I have shown you both for a common transformation - log. Note 
# however that there are other transformations available to you depending on the shape 
# of your data. 

# QUESTION
# Create a new variable of log temperature for the castor data:

# ANSWER
castor$log_temp<-log(castor$temp)

# If you have done it correctly you now have 6 variable columns in your data frame.

# QUESTION
# Using brackets, log transform the temperature variable in situ (note that you do not 
# need to transform the factor variable)

# ANSWER
tapply(castor$log_temp, castor$active, shapiro.test)

# QUESTION
# Plot the histogram of the log transformed data. Has log transforming helped?

# ANSWER
histogram(~log_temp|active,data=castor)
# Log transform has not helped (still non-normal)


