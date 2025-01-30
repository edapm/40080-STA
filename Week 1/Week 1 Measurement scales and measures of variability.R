# Statistical Methods 
## written by Liz Hamilton 2022 - taugh by Rhiannon Blake 2025
  
  
### Week 1: Getting familiar with R: Measurement scales; measures of central tendency and variability
  
#NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE COMPLETED THE LECTURE MATERIAL WITH DR. IAN PHILLIPS. 
#Now you have opened the file, please save as in an appropriate folder for this week's work. 
# It is a good idea to save all of the documents that you will work with for this week in the same 
# folder.

######################################################################################################
#Descriptive statistics

# Earlier this week you learned about descriptive statistics. Whenever you collect data, the first 
# step is to be able to describe that data. This usually starts with calculating measures of central 
# tendency and variability. 

# Before we begin, we need to enter some data into R. (Note: Often you will have entered your data 
# into Excel and you will "importing" it into R. Excel is rather more user-friendly for date entry, 
# especially if you have a lot of data. For now, though, we will enter data directly into R).

# We are only going to be entering data for one variable in this case - riverwidth (metres). Notice 
# that I have given the variable a name "riverwidth" with no spaces (R doesn't like spaces in names), 
# followed by "<-" which acts like "=". The "c" gathers together (or concatenates) all of the values 
# within the vector riverwidth. Notice that each of the values is separated by a comma so that R knows 
# it is a new value after each comma. 

# Run the code below by putting the cursor anywhere on the line that you want to run and click [Ctrl+Enter]
# for Windows or [Cmd+Return] for Mac. Alternatively, click the [Run] button on the task bar at the 
# top or in the right hand side of grey box below. 

riverwidth<-c(9.4, 5.3, 12.8, 11.6, 10.5, 15.1, 2.4, 5.7, 9.8, 11.6, 10.4, 13.1, 6.7, 9.8, 7.7, 6.7, 9.8, 8.7)

# We can then print out the data by running the code below:

riverwidth

# Notice that there is a new entry on the right hand side of R Studio in the environment window that
# shows the variable riverwidth and the numbers that you have just entered. The data are collected 
# together as a **VECTOR** (you know this because it is under the values tab) which is ok, but there
# are better ways to organise your data. For example, suppose we also measured river flow at each point 
# we measured river width: It would make sense to have river width and river flow in one "spreadsheet" 
# so that we can examine them together. In this case, we would need to store our variable riverwidth
# within a **DATA FRAME** You can think of a data frame as being a little like an Excel spreadsheet 
# where you have multiple columns and multiple rows. To create a data frame, run the following code 
# below (i.e. click Ctrl+Enter or alternative as above).

river<-data.frame(riverwidth)

# Notice that I have called the data frame "river" and then used the **OPERATOR** "<-" to tell R that
# river is a data frame (data.frame is the **FUNCTION** that creates the data frame) and that it has
# one variable, riverwidth. You will see that there is now a new entry in the Environment tab on the
# right of the screen calle "river" and that there are 18 river width observations for the one variable 
# riverwidth. If you click on "river" in the Environment, you will see the data frame pop up as a new 
# tab. Click back to this tab when you have finished examining the data frame. 

######################################################################################################
# Measures of Central Tendency
  
# So now we have our data, let's start looking at some measures of central tendency. R has lots of 
# built-in functions that are intuitive. So, if we want to know the mean river width for the samples
# that we measured we could run the code below:

mean(riverwidth)

# The function "mean", followed by the vector "riverwidth" in brackets gives us the mean river width.
# ..all very simple and easy to understand. However, an important point to note here is that R is 
#  using the **VECTOR** "riverwidth" to do this calculation because that is what I have told it to do. 
# But I have already told you that it is much better to work with your data within a data frame, so 
# we need to know how to extract this information from the DATA FRAME rather than the vector. Have a
# look at the code below and see if you can understand the parts of the code:

mean(river$riverwidth)

# We have the same mean function, but now I have told R to calculate it from riverwidth belonging to
# the data frame river. The operator "$" tells R that riverwidth is contained within river. 

# We can also calculate the median in the same way:

median(river$riverwidth)

# The other measures of central tendency that you did this week were the mid-range and the mode. 
# These require a little more coding but are still easier to calculate than by hand, especially if 
# you have a lot of values to work through!

# For the mid-range we first need to find the minimum and maximum values. I could find out the min 
# and max values from R's built-in fuctions as below:
  
min(river$riverwidth)
max(river$riverwidth)

# And then use the results to calculate the mid-range like this:

(15.1 + 2.4)/2

# Alternatively, I could avoid having to type in the values and produce my own "function". Have a 
# look at my alternative way of calculating the mid-range below:

min<-min(river$riverwidth)
max<-max(river$riverwidth)
(max+min)/2

# Notice that in this case, I created some new values called min and max (they will also have 
# appeared in the Environment on the left had side). I then added them together (notice the brackets
# which tells R to add them first) before dividing by 2. 

# To calculate the mode, we have to do a little more work. However, the good news is that there will
# be very few occasions where you will have to calculate the mode. But, for completeness you can 
# calculate the mode using the following code:

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

v<-river$riverwidth
getmode(v)

# Don't worry too much about understanding this now, but lines above create a function 
# called "getmode" which tells R to look for the mode within a variable that is nominally called "v".
# Line 117 then tells R that for the moment v = river$riverwidth. Finally, line 118 runs the function
# getmode and prints the output. 

####################################################################################################
# Measures of variability

# This week you also covered measures of variability including the Range, Variation ratio, Quartile 
# deviation / semi-interquartile range, Mean absolute deviation, Standard deviation and Co-efficient
# of variation. We will examine how we can caluclate these in R. 

# As you know R has some built in functions that we can use. So, for common measures such as the 
# standard deviation, we might expect there to be a function available in the basic R package. Have 
# a look at the code below and calculate the standard deviation (sd).

sd(river$riverwidth)

# Likewise, we have already seen how to calculate the range above. Can you remember the code that 
# we used to calculate the max and min values? If so, calculate the range in the box below. 
# (Answer = 12.7)

(max-min)

# To calculate the variation ratio, you will recall that this makes use of the mode and is calculated
# as:
# VR = 1 - (number of observations in the modal class / total number of obserations). To calculate this
# we first have to count the number of unique observations. We can do this by using the function "table" 
# below:

table(river$riverwidth)

# As you can see from the output, R has counted the number of observations for each river width. You 
# should see that there are 3 rivers that have a width of 9.8 m. Now we know that there are 3 observations, 
# and we also know that the total number of observations is 18. Can you write a function below to calculate 
# the variation ratio from this information? 
# (Answer = 0.833)

1-(3/18)


# Next we will calculate the inter-quartile range. 

IQR(river$riverwidth)

# We can also get individual quartile values by running the following code: 

summary(river)

# Until now, we have calculated all of these measures separately. But R can give you multiple summary
# statistics in one line of code. There are many ways to do this but today we will use the fuction 
# "stat.desc". 

# Until now, we have been working with the basic built in functions that R has. But there are many 
# specialist functions out there that are available in various PACKAGES that you can download and 
# INSTALL into R. The stat.desc function is not built in, it is contained in the package "pastecs", 
# so we are first going to INSTALL and then LOAD pastecs in order to use it. **You only need to 
# INSTALL a package once. However, you will need to LOAD the package every time you start a new 
# session in R if you wish to use it.** Think of installing as buying a book and putting it in your 
# library (you only need to do this once to have it at your disposal); and loading as taking off the
# shelf to read it. **IT IS A COMMON MISTAKE TO FORGET TO LOAD A PACKAGE - if a function will not 
# run, check that you have loaded the package to which the function belongs.**

# Install and load the package by going to the toolbar menu at the top and selecting:
# Tools > Install Packages - then type in "pastecs" and hit install. You can also use the code below
# to install the package.

install.packages("pastecs") # this is the INSTALL code for the package "pastecs"
library(pastecs)            # this is the LOAD code for the package "pastecs"

# The code should state that the package was successfully unpacked. You can now run the stat.desc 
# code to get multiple descriptive statistics:

stat.desc(river$riverwidth)

# You will notice that there is the number of observations (18), number of null and na vaues (zero),
# min (2.4), max (15.1), range (12.7), sum (167.1), median (9,8), mean (9.283), standard error of 
# the mean (0.739), confidence interval (1.56), variance (9.843), standard deviation (3.137) and 
# coefficient of variation (0.338).

# I find it quite anoying to have so many decimal places, so to tidy it up, we can add a little bit 
# more code. Notice that changing the number of digits to 3 below and then running the code again 
# gives a much neater output!

options(digits = 3)
stat.desc(river$riverwidth)

###################################################################################################
# Measurement scales (and data types in R)

# Earlier this week you looked at data types (nominal, ordinal, interval, ratio). We will examine 
# how R deals with these different types of data and also learn how to import an Excel file into R. 

# Most of the time that you use R, you will want to import your data from another computer package 
# such as Excel. This is what we will do now. NB: students sometimes have difficulty with this, so 
# I have set out a list of common problems below and produced a troubleshooting video on Canvas to 
# guide you through this. Look at both of these first and if you still cannot import the data, 
# **PLEASE CONTACT ME THIS WEEK FOR HELP**. Importing data is a key skill that you will need to have
# mastered before next class!

# Before you run the code below, please download the [heightweight] file from Canvas and save it somewhere 
# that you will remember. **IT IS IMPORTANT THAT YOU SAVE THIS FILE IN THE SAME FORMAT THAT IT IS 
# GIVEN i.e. A CSV FILE - DO NOT RE-SAVE IT AS A WORD DOCUMENT OR THE CODE BELOW WILL NOT WORK.** 

heightweight<-read.csv(file.choose(),  header=T, sep=",")

# When you run the code, a new window will open in which you can navigate to the location where you 
# saved the file and select it. The new window should show on the taskbar at the bottom of your 
# screen. **IF YOU CANNOT SEE IT, TRY MINIMISING EVERY APPLICATION THAT YOU HAVE OPEN UNTIL YOU SEE 
# A BOX THAT ALLOWS YOU TO SELECT A FILE**. If you have selected the file correctly, then you will 
# see it appear in the Environment window on the left had side, it should show 10,000 observations 
# of 3 variables. If you are having trouble with this, go through the troubleshooting list below 
# and/or watch the troubleshooting video on Canvas. 

# So, now you have the file imported, let's have a look at the data. You can click the file in the 
# Environment window which shows the three variable are "Gender", "Height" and "Weight". Pay 
# attendion to the variable names - R is case senstive! What type of data do you have for these 
# three variables?
  
# Let's have a look at the structure of the data first. The function "str( )" is a compact way to 
# display the structure of an R **OBJECT**.

str(heightweight)

# You will notice from the output that R gives us some summary information about the data frame first;
# then it gives us summary information about each variable. For example, Gender is a **FACTOR** 
# variable with two levels, male and female. R has automatically recognised gender as a factor variable
# because it is non-numeric (i.e. text) in the data frame but it has nominally assigned Females as 
# "1" and Males as "2". Height and Weight have been recognised as numeric ("num") variables. 

# So, our data should align with our understanding that Gender is nominal and height and weight are 
# both ratio. 

# There are some practice exercises for you to complete this week to help you get more familiar with 
# R. Please work your way through these before next week's class. 

# Now save your work!
  
#END
--------------------------------------------------------------------------------------------
  
#############################################################################################
# Troubleshooting file imports
  
# If you are having difficulty importing the file. Please close the R file and then re-open 
# it so that you are starting with a clean document. It is a good idead to clear your workspace 
# every time you start a new session in R, so run the "rm(list=ls())" code below then work your 
# way through the numbered list. 


rm(list=ls())


# 1. Navigate to line 224 above and run the code ONCE only. Running it multiple times will cause 
# R to crash and you will have to start again. You can tell if the code has worked because you 
# will see a little red stop symbol in the top right of the Console box below. If you have that 
# stop symbol, this means that there is an open window somewhere on your desk top. 

# 2. Check for the open window on the taskbar at the bottom of your screen. Is should look like 
# a little window icon. Click this icon and a browse and select box should appear. You can then 
# navigate to the file that you have saved and you should see it load in the Environment. 

# 3. If you cannot see the window icon at the bottom of your screen, minimise every application, 
# icluding R, until you reveal the browse and select box. You can then choose the relevat file. 

# 4. If you have chosen the file but it is not loading with the correct data then you have 
# probably re-saved the file in the wrong format when you downloaded it. If you have saved it 
# as anything other than a csv (comma separated values) file, then it will not work. Download the 
# file again and made sure that you save it in the correct format, then go through the steps 
# above to import the file. 

# 5. If none of these works, have a look at the help video on Canvas. 

# 6. If you still cannot get the file to load, then you must contact me! You will need to be able 
#to perform this task in order to do next week's work and keep up with this course. 

###################################################################################################
# Glossary of R Jargon in today's lesson

# DATA FRAME: A data set. More formally, a set of vectors bound together in a list. They can be 
# different modes or classes (e.g., numeric and character), but they must have equal length.

# FACTOR: A categorical variable and its value labels. Value labels will be nothing more than "1," 
# "2,". . . , if not assigned explicitly.

# FUNCTION: A command and/or a function. More formally, an R program that is stored as an object

# INSTALL: R comes with some standard packages that are installed when you install R. However, 
# specialist additional R packages, for example, the "pastec" package contain addtional useful 
# functions. These additional packages do not come with the standard installation of R, so you need 
# to install them yourself. You only need to install once.

# LOAD: Before you can use a package, you have to load it into R by using the library() function. 
# You need to load a package at the start of each session in R.

# OBJECT: A data set, a variable or even the equivalent of a Stata command). More formally, almost 
# everything in R. If it has a mode, it is an object. Includes data frames, vectors, matrices, arrays, 
# lists and functions.

# OPERATOR: A symbol that tells R to perform specific mathematical or logical task e.g. + (add), - (minus) etc.

# PACKAGE: Packages are collections of R functions, data, and compiled code in a well-defined format. 
# The directory where packages are stored is called the library. R comes with a standard set of packages. 
# Others are available for download and installation. Once installed, they have to be loaded into the 
# session to be used.

# VECTOR: A basic data structure in R, in essence you can think of it as a variable. It can exist 
# on its own in memory or it can be part of a data set. 


