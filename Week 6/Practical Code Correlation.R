################################################################################################################
# Statistical Methods  # 
# Liz Hamilton 2020    #
################################################################################################################

################################################################################################################
# WEEK 7 Practical Code File
################################################################################################################

###########################
# Clearing the workspace  #
###########################

# Clear your workspace as usual:
rm(list=ls())

# Listed below are the pacakges that you will need for the code this week. If you have not installed
# them already, please do so by navigating via the Tools tab at the top before you run the library
# code.
library(tidyr)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)

##########################
# NH4NO3 Data. The following file gives the chemical properties for a number of soil samples
# collected across an agricultural field. nh4 is the ammonia concentration in mg/kg; no3 is nitrate
# po4 is phosphate, carbon is carbon content and Fe is iron. 

# Bring in the data and examine the structure:
nh4no3<-read.csv(file.choose(),  header=T, sep=",")
str(nh4no3)

############################
# Plots & Normality        # 
############################

# Examine the data by looking a the plots and normality. You can change the variables if 
# you want to examine them all...but we will work through with nitrate (NO3) and ammonia (nh4) first.
boxplot(nh4no3$no3, ylab="Nitrate (mg/kg)")
boxplot(nh4no3$nh4, ylab="Ammonia (mg/kg)")

library(lattice)
histogram(nh4no3$no3, type="density")
histogram(nh4no3$nh4, type="density")

library(psych)
describe(nh4no3$no3)
describe(nh4no3$nh4)

# QUESTION: What is your first thought on normality for no3?
# ANSWER: The data appear to look relatively normal at first sight.

# Run a test for normality - we will use the Shapiro-Wilk test because we have < 2000 samples
shapiro.test(nh4no3$no3)
shapiro.test(nh4no3$nh4)

# Are your data normal?
# Both tests indicate that the data are normal.

############################
# Plots                    # 
############################

# Correlation starts with a plot. We might have good reason to think that ammonia and nitrate
# in soils are related (i.e. nitrification and mineralisation) - it is not important to know the 
# reason for now, but they are both forms of soil nitrogen. 
plot(nh4no3$nh4,nh4no3$no3)

# What do you think about the relationship between ammonium and nitrate?
# There appears to be a positive relationship between the variables. 

# Examine some other relationships between the variables.

############################
# Correlation coefficient  # 
############################

# In Ian's lectures, you calculated the correlation coefficient r. We can do this in R using the 
# following code: 
res<- cor(nh4no3, method = "pearson")
res
# This looks complicated but it is giving us the correlation coeffcients for all of the variables
# against each other. 
# But, this only gies you the correlation coefficient and we usually want the rest of the output
# including the p value. However, when it comes to creating visualisation (see later) this is a 
# useful bit of code to use. 

# To get the full output for a correlation, we can use the following code:
res1<-cor.test(nh4no3$nh4, nh4no3$no3, method = "pearson")
res1
# The output gives the p value and the correlation coefficient (see Ian's notes for further
# explanation).
# Notice that in this case, I have indicated that the method that I want to use is Pearson's. 
# This is because I know that my data are normal. If my data were not normal, I could run the 
# following code:
cor.test(nh4no3$nh4, nh4no3$no3, method = "spearman")
# HOwever, I get an error message saying that R cannot compute exact p values with ties. This
# is because Spearman's test considers the rank of values and in this case, there are two or 
# move values with the same rank. We can get around this with a small addition:
res2<-cor.test(nh4no3$nh4, nh4no3$no3, method = "spearman", exact=F)
res2

# If we wanted to examine the relationship between multiple variables in one go, we could run the 
# following code which give us just the correlation coeffcient for all of the variables in our
# data frame. The code round( , 3) just tells R to limit the number of decimal places to 3.
res3<-round(cor(nh4no3, method = "pearson", use = "complete.obs"),3)
res3

# The function rcorr() [in Hmisc package] can be used to compute the significance levels for pearson and 
# spearman correlations. It returns both the correlation coefficients and the p-value of the correlation for all 
# possible pairs of columns in the data table.
library(Hmisc)
res4<-rcorr(as.matrix(nh4no3),type=c("spearman"))
res4
# we can also extract specific aspect from the res4 object:
res4$r # Extracts the r values
res4$P # Extracts p-values
# These matricies duplicate values either side of the diagonal so you only need to read it one 
# way. 

############################
# Visualisations           # 
############################

# Sometimes it is easier to visualise correlations. The corrplot function is one code that can
# be used but please note it only works with the cor function, not the cor.test function. 
library(corrplot)
corrplot(res, type = "upper", method = "number")

# Which of the variables are most strongly correlated with each other?
# NO3 and Carbon because the r value is 0.99.

# My favourite visualisation though is the one in the PerformanceAnalytics package. Although
# I appreciate that not everyone will be a fan:
library("PerformanceAnalytics")
chart.Correlation(nh4no3, histogram=TRUE, pch=19)
# This plot has it all - the scatterplots with fitted line (althugh not a linear one!) 
# Correlation coefficient (r) - The strength of the relationship. p-value - The significance 
# of the relationship. Significance codes 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
# Histogram with kernel density estimation and rug plot. You dont have to worry about this if
# it doesn't suit your needs but I find it a quick way to look at the my data in one go. 

############
#END

