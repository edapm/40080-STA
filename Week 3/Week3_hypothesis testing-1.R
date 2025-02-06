#' ---
#' title: "Week3"
#' author: "Liz Hamilton"
#' date: "12/08/2020"
#' output: html_document
#' ---
#' 
 
#' ## Week 3: Hypothesis Testing - t-tests
#' 
#' NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE:
#' 
#' 1. Completed the lecture material by Dr Ian Phillips
#' 2. Completed the compulsory reading (i.e. Chapter 2-3 of the Handbook) and additional exercises
#' 
#' ### Clearing the workspace
#' 
#' It is a good idea to clear your workspace every time you start a new session in R. The code below 
#' lets you do this. Also check that the global environment is clear (click the little brush) and 
#' the same for plots.

rm(list=ls())

#' 
#' ### Examining the data
#' 
#' With Ian this week you examined whether there was a difference in the percentage meadow between 
#' two geological areas, upland limestone and lowland clay. Let's import the data file that you will 
#' work with to run these tests in R:
#' 

meadow_pc<-read.csv(file.choose(),  header=T, sep=",")

#' Notice the structure of the data. I have a factor variable that states whether the data are from 
#' clay or limestone and all of the percent (pc) values are in one column. You will remember that we 
#' are looking to conduct a test that allows us to make a more objective judgement about the 
#' difference. But, before we conduct any test, it is good practice to examine our data by running 
#' summary statistics and some basic plots. You should be well practiced at this now, so write some 
#' code below that allows you to this. Remember to use the histogram function from the lattice 
#' package to split the histograms by factor (look back to the code from last week to see how to do 
#' this). You will also need to load the psych package for sumary stats.







#' ### Testing the assumptions of normality and homogeneity
#' We need to examine normality because this will determine whether we will use a parametric, or 
#' non-parametric test. 
 
#' #### QUESTION
#' What would be your first assessment of normality based on the histograms, skew and kurtosis? 
#' Should we use a parametric or non-parametric test? NB: You may see a slightly different value of 
#' skew if you run another statistical package but this is because the calculations can sometimes be 
#' different between packages. 
 
#' You will also remember from last week that we can run a statistical test to examine normality - 
#' we will use the Shapiro-Wilk test because we have < 2000 samples. Use the tapply function from 
#' last week to run the test on both factors.






#' You should be able to see that the data are normal, so we will are looking good for being able to 
#' apply a parametric independent samples t-test. However, we also need to satisfy the assumption of 
#' homogeneity of variance (i.e. that the samples are taken from populations that have similar 
#' variances). In Ian's lectures you looked at the variance ratio but we can also conduct a test to 
#' examine whether variances are homogeneous. The function that you need is leveneTest found in the 
#' "car" package. **You will need to install the package first before running the library code below. 
#' Note that this is a large package and will take some time to install. If the little red stop symbol 
#' is still showing the top right of the Console then it is still downloading.** We can conduct the test
#' with the following code. Note the way round that leveneTest is coded. You have the percent (pc) value
#' followed by the factor variable meadow separated by a "~". The function  center = mean tells R that 
#' we want to use the mean for the measure of central tendency. 

library(car)

leveneTest(pc~meadow, data=meadow_pc, center=mean)

#' #### QUESTION 
#' What does the output of Levene's test mean?
#' We are given a number of values, Df refers to degrees of freedom (see Ian's lectures for more info
#' on this but basically, it tells you something about the number of factors and the number of samples).
#' An F value which is the test statistic and the p value which is 0.758. Unlike most statistical tests,
#' in Levene's tests our null hypothesis is that there is no difference in variance and we want there to
#' be no difference. So, if our p value is greater than 0.05, then we happy that we can now conduct a 
#' parametric test.

#' #### QUESTION 
#' *What if Levene's test indicated that our data did not have homogeneity of variance? Well, all is 
#'  not lost, we can still conduct a parametric test with a slight adjustment to the code (see below).*

#' ### Conducting an independent t-test

#' So now we know that we can use a parametric independent t-test, we can use R to calculate the 
#' statistics for us. Conducting the test is easy
 
t.test(meadow_pc$pc ~ meadow_pc$meadow, var.equal=TRUE)

#' Notice that we have the variable that we want to test first (pc) followed by the factor variable (meadow). The var.equal = TRUE code tells us that we know that are variances are equal. If we knew that they were not equal, then we would change TRUE to FALSE. Have a go at changing the code to FALSE and examine the output. You should see that the test has made a slight adjustment to the degrees of freedom and this has resulted in a slightly higher p value and confidence intervals. 

t.test(meadow_pc$pc ~ meadow_pc$meadow, var.equal=FALSE)
 
#' I have not said anything about one and two sided tests yet. This is because the t.test function 
#' automatically assumes that you want to conduct a two-sided test. But if you do want to conduct a 
#' one sided test then you can make a slight adjustment to the default code to take account of this. 
#' The argument "alternative = "greater"" will indicate that you want a one-sided test specifying 
#' that the alternative hypothesis assumes that the difference in mean for clay is greater than for 
#' limestone: (NB that R will take the factor variables in alphabetical order, so clay comes before 
#' limestone, meaning that the code will test for the assumption that clay is greater than limestone 
#' if you put "greater").

t.test(meadow_pc$pc ~ meadow_pc$meadow, var.equal=TRUE, alternative = "greater")

#' ### Non-parametric independent t-test
 
#' This is all very well if we know that we can run a parametric test, but what happens if our data 
#' are not normal? In this case we have to run a non-parametric test and the alterative test in R is 
#' called the wilcox.test - this is the WILCOXON RANK SUM TEST, do not confuse it with the Wilcoxon 
#' Signed Rank test which is for dependent (paired) samples. It is also called the Mann-Whitney test 
#' in some books. Let's look at the castor data from last week.

#' In the homework example last week, you should have downloaded the castor file and run some basic 
#' plots and summary statistics. We will have a brief recap of this and then go on to examine 
#' differences. First, you will need to download the "castor" file from Canvas and save it somewhere 
#' that you remember. Import the data file that you have downloaded:

castor<-read.csv(file.choose(),  header=T, sep=",")

#' Examine the variables; you have a number of variables in this file. In fact the temperature of 
#' two European beavers (Castor fiber) have been taken every every ten minutes over a number of days. 
#' The researchers have also recorded whether the animals were active or inactive. It is a good idea 
#' to check how R is reading the data so we will examine the type of data that is in the data frame:

str(castor)

#' You can see that we have two beavers (coded as an interger 1 or 2), the integers date and time, 
#' the numeric variable temperature and another integer for activity (coded 0 for inactive and 1 for 
#' active). We really want to see beaver_no and activity coded as a factor variable, so running the 
#' following code allows us to recode these integers as factors:

castor$beaver_no<-as.factor(castor$beaver_no)
castor$active<-as.factor(castor$active)

#' When we re-run the code, we now have the following structure:

str(castor)

#' You can find out more about converting between vector types here: 
#' http://www.cookbook-r.com/Manipulating_data/Converting_between_vector_types/

#' We know from running summary statistics and plots last week that our data are non-normal. Import 
#' the castor data, run the summary stats and plots again to examine temeperature by activity. 
#' Conduct the Shapiro-Wilk test to look at normality. Remember to load the packages that are 
#' associated with the functions that you want to run. 







#' We know that our data are non-normal and so this means we have to use a non-parametric test. The 
#' code to conduct a non-parametric t-test is as follows: 

wilcox.test(castor$temp~castor$active, paired=F)

#' You can see from the output that we have a test value, W and a p value which is much smaller than 
#' 0.05. What does this tell you about the temperature of the animals when they are active and not 
#' active? If you answered that there is a signficant difference in temperature then you are correct!

#' ### Conducting a paired t-test

#' In the cases that we have examined so far, our samples have been independent. But you might see 
#' from the wilcox.test code above that conducting a non-parametric paired test is as simple as 
#' changing the argument "paired = F" to "paired = T" for false or true. It is the same with the 
#' t.test code but an example might help. Let's use the example that you saw earlier this week for 
#' air and soil temperature. Download the file and import it into R then run summary stats. 

AS_temp<-read.csv(file.choose(),  header=T, sep=",")
describe(AS_temp)


#' You may remember that when we test normality of paired data, we need to do so on the DIFFERENCES 
#' rather than on the individual variables. So, have a look at the code below to see how I have done 
#' this. First I create a new variable called difference by subtracting (notice the "-" air_temp from 
#' "soil_temp"), then I run the code for histograms and Shapiro-Wilk on the new difference variable.

AS_temp$difference<-AS_temp$air_temp - AS_temp$soil_temp
hist(AS_temp$difference)
shapiro.test(AS_temp$difference)

#' ### QUESTION 
#' Should we run a parametric or non-parametric test based on this data?

#' Let's run both of them in any event. Notice that we do not need to worry about homogenity of 
#' variance for a paired test. 

t.test(AS_temp$air_temp, AS_temp$soil_temp, paired=TRUE)
wilcox.test(AS_temp$air_temp, AS_temp$soil_temp, paired=TRUE)

#' Both tests show that there is a difference but we need to use the parametric test based on the 
#' normality of the data. As you will see the signficance values are different and this is a good 
#' example of how a parametric test can be more powerful than a non-parametric test. 

#' The very observant among you might have noticed a very slight but important change in the code. 
#' After the first variable has been entered (AS_temp$air_temp) there is now a "," rather than a "~". 
#' If you had left in the "~", R would have given you an error message but sometimes it is difficult 
#' to know what you have done wrong. Pay attention to the details in R and you will get it to bend to 
#' your will!

#' You should see that both of these tests indicate that there is a difference. 

#' **Well done! You have completed you first set of statistical tests. Now, complete the compulsory 
#' Handbook reading and work your way through the self-test exercise. **
