# ---
# title: "Week2.R"
# author: "Liz Hamilton"
# date: "9/09/2022"
# output:
#   pdf_document: default
#   html_document: default
# ---

# ## Week 2: Freqency Distributions Samples and Confidence Intervals

# NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE:
# 1. Completed the lecture material by Dr Ian Phillips
# 2. Completed the compulsory reading and additional exercises for the previous week.

# ### Clearing the workspace

# It is a good idead to clear your workspace every time you start a new session in R. The
# code below lets you do this. Also check that the global environment is clear (click the
# little brush) and the same for plots.

rm(list=ls())

# Another useful exercise is to set the working directory so that when you ask R to import
# a file for you, it will automatically choose the working directory location - this can 
# save a lot of time trying to remember where you saved the file. To set the working directory
# Click "Session" in the taskbar. Then "Set working directory" followed by "To Source file 
# location". THIS WILL BE IMPORTANT FOR SAVING YOUR WORK LATER SO DON'T SKIP THIS STEP.

# ### Frequency Distributions

# In Ian's lecture this week you were introduced to Frequency Distributions. There was 
# also a hint of this week's work at the end of last week's R code. As you know, we can
# look at the shape of our data by creating a frequecy distribution. Let's use the code 
# that we used last week and work with the riverwidth data. We can enter the data for 
# riverwidth manually and then put it into a data frame:

riverwidth<-c(9.4, 5.3, 12.8, 11.6, 10.5, 15.1, 2.4, 5.7, 9.8, 11.6, 
              10.4, 13.1, 6.7, 9.8, 7.7, 6.7, 9.8, 8.7)

# Creating a histogram in R where you have one variable (or vector) is very easy:

hist(riverwidth)

# R is very flexible when it comes to graphics, we can add additional functions to basic
# plot code to customise it. Try changing the colour in the following code - a list of 
# colours can be found here:  http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

hist(riverwidth, col="red")

# ### *QUESTION*
# But back to the distribution. What kind of distribution do you think is displayed in 
# the histogram of river width? We can overlay a curve as well using:

hist(riverwidth, freq = FALSE, col="red")
lines(density(riverwidth), col="blue")

# Notice also the additional code "freq = FALSE" here. This allows you to switch between
# a frequency and a density plot, which we need if we are going to plot the normal curve
# over the top. There is quite a good explanation of the difference between density and 
# frequency histograms here: 
#https://math.stackexchange.com/questions/2666834/what-is-the-difference-between-frequency-and-density-in-a-histogram
# but you don't really need to worry too much about that for this course. 

# ### *QUESTION*
# What do you think about the histogram for riverwidth? Does it approximate the normal 
# distribution? Yes

# We have entered just the variable (or vector) riverwidth above. But you may remember 
# from last week that it is more usual for us to work with data frames where you have 
# multiple variables. The following code tells R to treat the variable riverwidth as an 
# object within the data frame called river. 

river<-data.frame(riverwidth)

# Now we have our data in a data frame, we could also produce the histograms using the 
# following code:

hist(river$riverwidth, freq = FALSE, xlab = "River Width (m)", main="")

# Notice that we write the data frame first, followed by the operator "$", followed by 
# the variable name. You will need to remember this format. the function "xlab" tells
# R what to call the label on the x-axis. The code "main =" tells R what the title of 
# the plot should be. Here I have left it blank because we never use a plot title in 
# scientific writing (although you might want to use it to keep track of what plots you 
# have produced - just dont include a title in your reports).
 
# What if we want to produce a boxplot? A boxplot is a convenient way to display the 
# minimum, first quartile, median, third quartile, and maximum values in your data. 
# There is more information on boxplots here: 
# https://towardsdatascience.com/understanding-boxplots-5e2df7bcbd51. 
# Use the code "boxplot" and the format for histogram to produce a boxplot of river 
# width:
 
boxplot(river$riverwidth, ylab = "River Width (m)")

# We can label the various aspects of the boxplot with the following code (note that you
# do not need to undertand the following code, it is just to illustrate what the lines 
# of the box plot mean)

bxp<-boxplot(river$riverwidth, ylab = "River Width (m)") # create the boxplot
mtext(c("Min","Max"), side=2, at=bxp$stats[c(1,5)],las=2, line=-10) # add max and min
mtext(c("Q1","Q3"), side=2, at=bxp$stats[c(2,4)], line=-8) # add quartiles
mtext(c("median"), side=2, at=bxp$stats[c(3)],las=2, line=-8) # add median 

# ### *TASK*
# Have a look at how we added colour to the histogram code above. Try changing the 
# colour of the boxplot by adding the col function to the boxplot code - remember to 
# include the comma.

bxp<-boxplot(river$riverwidth, ylab = "River Width (m)", col="red")

# ### Skew & Kurtosis
# Last week, we used the pastecs package to run summary statistics. You may remember 
# that I mentioned there are a lot of different functions to get summary stats in one 
# go. One of my favourite is the "describe" function in the psych package. You will 
# need to install and load the package before you can use the function. First, let's 
# install the package: **Click on TOOLS at the top of the taskbar, select INSTALL 
# PACKAGES and type PSYCH into the search bar. You can then select the package and 
# install it. Once it has installed, you will need to LOAD the package into this session 
# in R by running the following code:

library(psych)

# Use the describe function to give summary stats and take a minute to examine the 
# output:

describe(river)

# ### *QUESTION*
# What do the skew and kurtosis values tell you about the distribution? As a rule of 
# thumb, if skew is less than |1| (i.e. plus or minus one) then you have a normal 
# distribution. Likewise, if kurtosis is less than |2| then the distribution is normal. 

#NB: There are different ways of calculating skew and the describe function in R gives 
# you some options. First, let's have a look at what those options are by navigating to 
# the help tab opposite. If you put "describe" into the main search bar then you should 
# come up with the describe function help page. Scroll down until you locate the "type" 
# argument. You will see further down the page that there are three options: 1, 2 and 3.
# For each there is a slightly different calculation. We will chose type = 2. 

describe(river, type = 2)

# You should see a slightly different value for skew as type = 3 is the default. 
# The value that you have from the type 2 code is the same one that you calculated by 
# hand with Ian.

# The other useful calculation that you did with Ian this week was to look at the 
# standard error of skewness. We will run the following function that allows us to 
# calculate this:

se.skew = function(x){
        N = length(na.omit(x))
        sqrt(6*N*(N-1)/((N-2)*(N+1)*(N+3)))
}

se.skew(river$riverwidth)

# Again, you do not need to remember this function - it is to illustrate how you 
# could calculate the measures that Ian introduced you to in his lecture. 

# We can now calculate the Z score of skewness: 
        
Zscore<-(-0.32/0.536)
Zscore

# Last week we worked with the hightweight data. Import the data into R using the same 
# code as last week:

heightweight<-read.csv(file.choose(),  header=T, sep=",")

# ### *TASK*
# Create histograms for both height and weight for the heightweight data file. Are both 
# height and weight normally distributed? Run the describe function and look at skew and
# kurtosis for both variables. Does this support your inital thinking?

hist(heightweight$Height, freq=FALSE, col="red")
lines(density(heightweight$Height), col="blue")

hist(heightweight$Weight, freq=FALSE, col="green")
lines(density(heightweight$Weight), col="black")

# You might see that sometimes it is not easy to determine the normal distribution. 
# Another way to determine normality is to run a test. Next week Ian will introduce you 
# to the Kolmogorov-Smirnov test for normality. Basically, it allows you to run a 
# statisical test to see whether the data are normal. If p < 0.05, your data are not 
# normal. We can run this test for heightweight like this:

ks.test(heightweight$Height, "pnorm", mean=mean(heightweight$Height), 
        sd=sd(heightweight$Height))
ks.test(heightweight$Weight, "pnorm", mean=mean(heightweight$Weight), 
        sd=sd(heightweight$Weight))

# In the code above, we have the function ks.test, we have then told R which variable 
# we want to test (either Height or Weight), the "pnorm" code tells R that we are testing 
# the variable agains a normal distribution. Finally we have specified that the mean and
# standard devation of the normal distribution should be "shifted" to reflect our data. 

# ### *QUESTION*
# Does the ks.test indicate that the distributions are normal? Remember for this test, 
# if p < 0.05, your data are not normal.
# yes and no

# If you answered no to Weight, some of you might be thinking this is because we have a 
# bimodal distribution that is likely to be reflecting the two factors i.e. Male and 
# Female in the data. It would be more informative if we could split the file by male 
# and female (i.e. by factor and examine the plots this way). Luckily, we can do this 
# easily with the histogram function from the lattice package. **Install the package 
# first and then run the code below. Remember that you need to go to 
# TOOLS > INSTALL PACKAGES first.**

library(lattice)
histogram(~Weight|Gender,data=heightweight)

# Notice that this code tells R to choose the variable Weight and then split it by 
# Gender (you will need to use the vertical line usually above the forward slash on your
# keyboard), the code also tells R which data to use for these two variables. THIS IS A
# USEFUL STRUCTURE FOR MANY FUNCTIONS, SO IS WORTH REMEMBERING. 

# We could split our data and run the ks.test again by Male and Female, but if we look 
# at the results for height we might realise that this doesn't really solve our problems -
# our data are still not normal according to the ks.test. Why might this be the case? 
# Well, it is all to do with the size of our dataset. If you have a large enough sample,
# even a seemingly small difference could be considered "too big" and a criticism of the
# K-S test is that it can be overly sensitive to this where you have a large data set. 

# But we can also check skew and kurtosis using the following code from the psych package:

describeBy(heightweight$Weight, heightweight$Gender, mat=T)

# What does this tell you about normality? 

# Another issue with using the ks.test is that it is fine for relatively large samples, 
# but where your sample is small e.g. < 2000, then you are probably better off using 
# and alternative test called the Shapiro-Wilk test. This is the case for our riverwidth
# data. We can run the Shapiro-Wilk test with the following code:

shapiro.test(river$riverwidth)

# ### *QUESTION*
# What do the results of the Shapiro-Wilk test tell you about river width?
# It is normal

# Let's add a factor variable to the river width that indicates whether the measurement 
# was taking during a period of high or low flow:

river$flow<-c("low","low","high","high","high","high","low","low",
              "low","high","high","high","low","low","low","low","low","low")

# Examine the data frame to see that we now have two variables within it:

str(river)

# Let's examine normality of the riverwidth data by flow. How you apply the test will 
# depend on the structure of your data. Because we want our data split by factor i.e. 
# high flow and low flow, we need to test the normality of the data by factor in the 
# same way that we did for the histograms. We can use the tapply function to do this. 
# Take note of how the variables are entered. You can use the function "tapply" for 
# other purposes. Try changing "shapiro.test" for "mean".
 
histogram(~riverwidth|flow,data=river)
tapply(river$riverwidth, river$flow, shapiro.test)

# ### *QUESTION*
# What do the Shapiro tests say about normality of the data?
# It is normal

## Transformation in R
 
# You learned earlier this week that if a variable is skewed then transforming the data 
# prior to  running the test might help us to meet the assumption of normality. 
# Transforming data in R is easy. Suppose we want to log-transform the Weight variable 
# in the heightweight data frame. We can add some additional code and brackets to 
# log-transfor the data as follows:

ks.test(log(heightweight$Weight), "pnorm", mean=mean(log(heightweight$Weight)), 
        sd=sd(log(heightweight$Weight)))

# ### *QUESTION*
# What does the KS.test tell you about normality of the transformed data?
# Normal

# It is a bit of a pain to go back and change our code all the time to put the log 
# transformation in. But there is an easier way to code this. We could create a new 
# variable called e.g. L_Weight (for log transfermed weight) like this:

heightweight$L_Weight<-log(heightweight$Weight)

# If you examine the dataframe again, you will see that we now have four variables:

str(heightweight)

# This is a neater way of doing it as it means you do less typing and avoids issues 
# with you forgetting to log transform some of the code. If we have a new variable 
# then we can just substitute this into the original ks.test code to give the following 
# output:
 
ks.test(heightweight$L_Weight, "pnorm", mean=mean(heightweight$L_Weight), 
        sd=sd(heightweight$L_Weight))
 
# Let's look at the difference in the histograms between the transformed and 
# untransformed data:

hist(heightweight$Weight)
hist(heightweight$L_Weight)

# ### *QUESTION*
# What do you think about the log-transformed histogram?
# More skewed

# **A WORD OF CAUTION ABOUT TRANSFORMATIONS**
# Current statisical thinking is that there are very few specific circumstances where 
# we should be using transformations. It is probably more appropriate in most cases to 
# use a non-parametric test than to force your data into a transformation for a 
# parametric test. If you do need to do a transformation, there is a very good guide to 
# transformations in R here: https://rcompanion.org/handbook/I_12.html

# ### Confidence Intervals
 
# For some of the statistics that you have calculated already, confidence intervals 
# have already been calculated for you. Remember the stat.desc function from the pastecs
# package:

library(pastecs)
stat.desc(river)

# You will see that confidence intervals are automatically calculated for the mean at 
# 95%CI. Let's say we wanted to calculate the 99% interval. How might we change the code? 
# Well, to know where to start, lets have a closer look at the function. To do this we 
# can type:

?stat.desc

# Notice that the help for this function has now appeared in the help window opposite. 
# You might also notice that there is a search button at the top of the window on the 
# right hand side that you can type any function in to find out more about it. Sometimes,
# you will need to know the package that it comes from as there can be several functions
# with the same name. If we look at the argument "p" we will see that this is "the 
# probability level to use to calculate the confidence interval on the mean (CI.mean). 
# By default, p=0.95". So what might happen if we add the argument "p = 0.99" for the 
# 99% confidence interval?

# ### *TASK*
# Add the argument p = 0.99 to the stat.desc function for the river data. Remember to 
# add the comma to separate arguments. **NOTE: confidence intervals can be calculated 
# for a variety of statistics, such as the median, or slope of a linear regression etc. 
# In most of this course we will calculate a probability (p-value) of the likelihood 
# of data and draw a conclusion from this p-value.  However, you should be aware that 
# there are alternatives, once of which is proposed by John McDonald (see optional 
# reading list for this week) which describes how confidence intervals can be used as 
# an alternative approach. #' ### END of this week's text. Please work your way through
# the additional exercises and the compulsory reading for this week. 

stat.desc(river, p=0.99)
