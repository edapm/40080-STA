# Statistical Methods 
## Liz Hamilton 2021

# Week 1: Self-test Exercise
 
 ### Clearing the workspace
# It is a good idea to clear your workspace every time you start a new session in R. The code 
# below lets you do this. Also check that the global environment is clear (click the little
# brush) and the same for plots if you have any.
  
rm(list=ls())
 
# Another useful exercise is to set the working directory so that when you ask R to import
# a file for you, it will automatically choose the working directory location - this can 
# save a lot of time trying to remember where you saved the file. To set the working directory
# Click "Session" in the taskbar. Then "Set working directory" followed by "To Source file 
# location". THIS WILL BE IMPORTANT FOR SAVING YOUR WORK LATER SO DON'T SKIP THIS STEP. 

 ### Importing a file       
# At the end of the Practical Code which you should have worked through, we worked with the
# file heightweight. 
 
 ### TASK 1 
# Find the code that lets you import the heightweight file, copy and past it below and 
# import the data. 
## ------------------------------------------------------------------------

heightweight<-read.csv(file.choose(),  header=T, sep=",")
 
 ### TASK 2
# Find the code (and enter it below) that lets you look at the structure of the data and run
# it. 
## ------------------------------------------------------------------------

str(heightweight)
 
 ### TASK 3 
# We will need to use the package pastecs. Find the code that loads the package pastecs into
# this session of R.
## ------------------------------------------------------------------------

library(pastecs)
 
 ### TASK 4
# Use the function in the pastec package that gives multiple summary statistics for the 
# variable Height in the heightweight data frame. NB: you will need to change the name of 
# the dataframe and the variable from the original code to match the data frame 
# "heigthweight" and variable "Height". Once you have completed this, do the same for Weight.
# **NB R is case senstive and you will need to pay attention to whether words are 
# capitalised or not!**
## ------------------------------------------------------------------------

stat.desc(heightweight$Height)

# **Note that the results are given in scientific notation where 1.000000e+04 is the same 
# as 1x10 to the power 4 i.e. 10,000.**
 
 ### TASK 5
# Find the function for the interquartile range and change the data frame and variable names
# so that  you can calculate the interquartile range for Height and Weight in the data 
# frame heightweight.
## ------------------------------------------------------------------------

IQR(heightweight$Height)
IQR(heightweight$Weight)
 
 ### TASK 6
# Report the mean, median, standard deviation and interquartile range for the height and 
# weight of participants in this study. Which measure of central tendancy and variabilty 
# would you use?

stat.desc(heightweight$Height)
stat.desc(heightweight$Weight)

## Median, IQR
 
 
#### A quick preview for next week: run the code below and examine the plots for each of the
# variables, what do you notice about the shape of the plots? Why do you think this might 
# be the case?
 
## ------------------------------------------------------------------------
hist(heightweight$Height)

## ------------------------------------------------------------------------
hist(heightweight$Weight)

# A USEFUL TIP
# Many students struggle to adapt to the way R is saved. Essentially, there is no need to 
# print out your data as the code can be run in one go every time you open the file. But 
# there are times when it is useful to have something to refer to, especially when you are 
# learning. So, if you click [Ctrl + Shift + K] you should get the option to render a 
# report. Choose PDF from the dropdown list and then choose the heightweight file again (you
# need to do this because R runs all the code again to create the PDF). You should now have
# a PDF document in your working directory area. 

#END
 

 
 
