#Ignore
#.libPaths("U:/")

##INDEPENDENT SAMPLES AND ANOVA

#' ---
#' title: "Week4"
#' author: "Tom Matthews"
#' date: "29/09/2022"
#' output: html_document
#' ---
#' 

#All of this should follow on from Ian's lecture, so make sure to go through
#that first! If you are still unsure about what an ANOVA is, go to the end of 
#the script and have a read of the ANOVA re-cap I have prepared.

##As a first step, we will look at the dataset we will use. We will be using a
#dataset (called PlantGrowth) which comes with R. It contains the weight of
#plants obtained under a control and two different treatment conditions.

dat <- PlantGrowth #this is copying the dataset into an object called 'dat'

dat #this will print the dataset to your console / screen.

#ANOVA is used when we have a continuous response variable (here, 'weight') and
#a categorical predictor variable with more than 2 levels (here, 'group'). When
#we use ANOVA with this dataset we are asking whether there are significant
#differences in the mean weight between the three groups (ctrl, trt1, trt2)

##We can look at the number of datapoints in each group.For ANOVA you generally
#don't want big differences in the size of the groups (although there is not
#really a hard rule on specific size differences)
table(dat$group) #they are all equal so no issues here

##remember the null and alternative hypotheses for ANOVA:
#Null - there are no significant differences in the means between groups
#Alternative - there are significant differences in the means between groups

##The use of ANOVA (a parametric test) is based on a number of assumptions, including:
#1) Homogeneity of variances (we do this before we run the ANOVA)
#2) Normality of the errors / residuals (discussed below; done after we run the ANOVA)

##ASSUMPTION 1: Homogeneity of variances
#If you remember from last week, to test whether variances are homogeneous we
#can use the leveneTest found in the "car" package.

#install.packages("car") #use this line if you haven't installed the package before
library(car)

leveneTest(weight ~ group, data=dat, center=mean)

#Remember, with the leveneTest our null hypothesis is that the variances are
#homogeneous between groups (what we want for ANOVA) and so we want to see a
#P-value > 0.05

#QUESTION: does out PlantGrowth data (dat) meet the assumption of homogeneity of
#variances? Yes


##FIT THE ANOVA MODEL:

#the lecture showed us how ANOVA is based on the total sum of squares, sum of
#squares between the samples, and the error sum of squares (i.e. sum of squares
#within samples). At the end of this practical I have included a more detailed
#re-cap of ANOVA, which I suggest you read if you unsure, but it is not a 
#compulsory part of the practical.
#R takes care of all of these sums of squares for us, so all we need to do is
#make sure we use the correct notation and formula for calculating it! We use
#the 'aov' function to run the ANOVA test, and then add in our response variable
#(weight) and our categorical grouping predictor / factor (group). The response
#variable always goes to the left of the ~, and the categorical predictor
#variable to the right. The ~ (tilde) sign is standard model notation in R and
#we will see it again in the regression lectures and practicals. It simply
#separates our response (what we are trying to explain) from our predictors
#(what we are using to explain our response)

res <- aov(weight ~ group, data = dat) #the data argument is for us to tell R what our dataset object is called (so it can find the data!)

#And that's all there is to calculating an ANOVA in R! We can look at the res object:

res

#It shows use the sums of squares and degrees of freedom that you heard about in
#the lecture. But it doesn't really give us all the information we want. For
#that, we use the 'summary' function. You can use 'summary' on lots of different
#things in R, and you will get back different information depending on what
#object you use it with. For an ANOVA,

summary(res)

#remember, we use the F-statistic as our test statistic in ANOVA. The larger the
#F-value, the greater the probability there is a significant difference between
#our samples. The P-value (Pr(>F) here) tell us the probability of observing an
#F-value this large if the null hypothesis is true. We generally use a threshold
#of 0.05 (5% probability) and conclude there is a significant difference (and we
#can accept the alternative hypothesis) if P < 0.05.

#QUESTION
#What about here - does this P-value mean we accept or reject the null hypothesis? Accept


##ASSUMPTION 2: The residuals are normally distributed. The residuals are the
#variance in the response variable NOT explained by your grouping variable, and
#can easily be extracted from the model fit object using the residuals function
#More technical detail on this assumption is provided in the ANOVA re-cap at the
#end of the script (but don't worry if that is too technical!)

r <- residuals(res)

#if you remember from last week, to test for normality we can use the shapiro
#wilks test. Remember, the NULL hypothesis here is that the data are normally
#distributed, so we are looking for a non-significant P-value

shapiro.test(r)

#QUESTION: are these residuals normally distributed? Yes

#we can verify our results by looking at a histogram of the residuals

hist(r)


##PLOTTING THE RESULTS:

##The ANOVA function provides the formal analysis of variance test, but it is
#usually useful to plot your data in order to properly interpret it. With ANOVA
#type data, the general plot used is a boxplot, with a separate box for each of
#the groups. This is really easy to do in R, using the 'boxplot' function,

boxplot(weight ~ group, data = dat)

#We can see that trt2 has a higher average weight than both the control and
#trt1. You can use lots of different arguments to change things in the plot,
#like colours and axis titles. Have a look at the help file for the boxplot
#function for all the options

?boxplot #help file

boxplot(weight ~ group, data = dat, col = "blue", xlab = "Experiment groups")


#It is perfectly fine to use the boxplot function. But it is useful to be aware
#that, in R, there are two main ways of plotting data. boxplot comes from what
#is called the base plotting functions. But we can also use the ggplot2 package,
#which provides alternative functions. In this particular example it is useful
#because boxplot uses the median (i.e. in each box the black horizontal line is
#the median) while ANOVA compares means. ggplot2 provides an easy way of
#plotting the means.

install.packages("ggplot2") #you only need to do this once, and then it will be saved on your PC

library(ggplot2)

ggplot(data = dat, aes(group, weight)) + geom_boxplot() +
  stat_summary(fun = mean, geom="point", shape=20, size=10, color="red", fill="red")

#this creates a similar boxplot, but now the mean is signified with a red dot
#(it is a useful example for highlighting how the mean and median differ). Don't
#worry at this stage about the code used to run this ggplot2 function, it is
#simply to highlight the flexibility of R and the two main plotting frameworks.

##POST-HOC TESTS:

#As mentioned in the lecture, ANOVA tells us if there is a significant
#difference between the means of our groups, but it doesn't tell us which groups
#significantly differ from one another. A significant ANOVA result does not
#necessarily mean that the means of each individual group significantly differs
#from all other groups. To test this, we can use a Tukey Post-Hoc test. Post-Hoc
#just means a test we do after our main test (here, ANOVA)

TUKEY <- TukeyHSD(x=res) #res is our ANOVA object from above
TUKEY

#There is no summary function for the TukeyHSD function, and all the information
#we need is just in the object itself. The output shows us the pairwise
#comparison of each individual group (e.g. trt1-ctrl is the comparison of the
#mean of trt1 with the mean of ctrl). The diff column is then the difference in
#means, and the lwr and upr columns are the lower and upper bounds of the
#confidence intervals (remember lecture 2) around this difference. Then the p
#adj is the p-value telling us whether this difference is significant or not.
#The adj bit means that the p-value has been adjusted for the fact we are
#undertaking multiple tests (here, 3) - the more tests you do, the more likely
#you will get a significant result (i.e. a P < 0.05) just by chance (i.e. a Type
#1 error). The p-value can be adjusted (as is done here) to account for this.
#For interpreting these p-values, you still use the same threshold (0.05).


#QUESTION: based on this output, which groups differ from one another? Does this
#match up with the boxplot trt2 and trt1 differ most from each other


#you can plot the Tukey test results using the plot function. Here, the middle
#bars are the differences, and the ends are the upper and lower confidence
#intervals. Significant differences will occur where the the confidence interval
#doesn't overlap zero

plot(TUKEY , las=1 , col="brown")

#QUESTION: does this plot match up with the results from the formal Tukey test above? yes

##NON-PARAMETRIC ALTERNATIVE TO ANOVA:

##Earlier we checked two assumptions of ANOVA: 1) homogeneity of variances, and
#2) normality of the residuals. So what do we do if our data do not meet these
#assumptions? As with the t-test, there is a non-parametric alternative to ANOVA
#that we can use. This is called the Kruskall Wallis test, and as with ANOVA, is
#easy to use in R

##to illustrate this test we will use a new dataset called 'airquality' (Daily
#air quality measurements in New York, May to September 1973) use the head()
#function to look at the top of the data table.
head(airquality) 

#for the purposes of this, we are interested in whether there is a variation in
#mean Ozone (response variable) across months (categorical grouping predictor
#variable). Lets check the leveneTest for homogeneity of variance. For now
#ignore the as.factor() function.

leveneTest(Ozone ~ as.factor(Month), data = airquality, center = mean)

#Question: What are the results of this test telling us? The variances are not homogeneous

##Finally, we can run the Kruskall Wallis test

kruskal.test(Ozone ~ as.factor(Month), data = airquality)

#QUESTION: as the p-value of the test is significant, what can we conclude about
#our data? There is a significant difference between the means of the groups

#' **Well done - you can now run and interpret an ANOVA in R! Now, complete the
#' compulsory Handbook reading and work your way through the self-test exercise.
#' **


########################################################################
###############ANOVA RECAP############################################
############################################################################

#This is not a compulsory part of the practical, I leave it up to you whether or
#not you go through it - it is just a re-cap of what ANOVA is doing!

#In ANOVA we work with three different types of what are called sums of squares.
#All this means is, for a given group of interest, we calculate the mean of all
#data points in that group, then calculate the difference between each point in
#that group and this mean, square that difference, and then sum all the squared
#differences together. 

#The three sums of squares we work with are: 
#1)	Total sum of squares (SST) 
#2)	Sum of squares between groups (SSB) 
#3)	Sum of squares within groups, also called residual sum of squares (SSW) 

#Say for our dataset we are conducting an experiment on the effect of two diet
#pills on weight loss. We get a group of 300 volunteers, weigh them and then
#place them in one of three groups for the experiment: Diet pill 1 (G1), Diet
#pill 2 (G2) and a control group (G3). Our experiment lasts for three months and
#we then weigh everyone again and look at the difference in their weight between
#the start and end of the experiment. Our null hypothesis is that there are no
#differences in mean weight loss between the three groups.

#In this example, to calculate SST, we ignore the three groups, pool all our
#data together and calculate what is called the grand mean - just the mean for
#the whole dataset regardless of group membership. For each data point (weight
#difference) in our dataset we then calculate the difference between the weight
#difference given by that point and the grand mean weight difference, square
#this value, and then sum across all data points.

#For SSW, we look at each of our three groups (G1, G2, G3) individually. Within
#each group, we calculate the mean weight difference using just the values in
#that group. Then, again just for the data points in that group, we calculate
#the difference between each weight difference value and the group mean, square
#and sum across all data points in the group. We do that separately for each of
#our three groups, and then sum all the values together.

#SSB can just be calculated as SST - SSW, as the total sum of squares (the total
#amount of variation in our data) is just the sum of the variation within our
#groups and the variation between our groups. But it can also be calculated as,
#for each group individually, calculating the difference between the group mean
#and the grand mean and then multiplying this value by the number of data points
#in the group. This is then done for each of the three groups and the three
#values summed. 

#Our F-statistic is then simply given by, 

#F = (SSB / df1) / (SSW / df2), 

#where df1 and df2 are the degrees of freedom associated with SSB and
#SSW respectively. Using this F-value and the two degrees of freedom values we
#can then look up the probability of obtaining an F-value this larger or larger,
#if the null hypothesis of no difference in our means is true (i.e. the
#P-value). A larger F-value, for a given set of data, means there are more
#differences between the group means. This makes sense if we look at how F is
#calculated - the ratio of the total variation between groups to the total
#variation within groups. If the numerator (number on top of the division line)
#is larger than the denominator (number on bottom), F will be larger. So, in
#this case it means if more of the total variation is due to differences between
#groups than within groups, F will be larger. And this is what we want - we want
#differences between groups to show our diet pills actually have an effect.

#Normality assumption (don't worry if you don't understand this):
#The real assumption here is that the "conditional distributions of Y given x
#are normally distributed". This is the same for linear regression, which we look
#at in Weeks 8-10. Given we normally only have one sample of data, in linear
#regression, we cannot check this directly (so we instead look at the
#residuals); but in ANOVA we can, as it is the distribution of Y-values (our
#response variable) within each group. As such, you often see the normality
#assumption of ANOVA stated as: “The distribution of Y within each group is
#normally distributed.” But this gives us the same distribution as looking at
#the residuals (the difference between a response value and the mean of its
#group), and thus we can do either, and in this practical we look at the
#residuals.

#################################################################################
#################################################################################




