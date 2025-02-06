#' ---
#' title: "Week3_Self_test_exercise"
#' author: "Liz Hamilton"
#' date: "13/08/2020"
#' output: html_document
#' ---


#' 
#' ## Week 3: Hypothesis testing - independent and paired tests (parametric and non-parametric)
#' ## Self-test exercise
#' 
#' ### Clearing the workspace  
#' 
#' It is a good idea to clear your workspace every time you start a new session in R. The code below lets 
#' you do this. Also check that the global environment is clear (click the little brush) and the same for 
#' plots if you have any.
## ------------------------------------------------------------------------
rm(list=ls())

#' 
#' ### Importing a file        
#' First, you will need to download the "gastro" file from Canvas and save it somewhere that you remember. 
#' Import the data file:
#' 
## ------------------------------------------------------------------------


#' 
#' Take a look at the data that you have imported by clicking on the file in the Global Environment 
#' opposite. The file contains data collected by Ward & Quinn (1988) who studied aspects of the ecology 
#' of the intertidal gastropod Lepsiella vinosa on a rocky shore in southeastern Australia. They collected
#'  egg capsules of Lepsiella vinosa from either the littorinid zone (high shore with snails) or the mussel
#'   zone (mid shore with mussel beds) and recorded the number of eggs per capsule. We will focus on 
#'   differences in the number of eggs per capsule between zones. ***This is an independent comparison 
#'   because individual capsules can only be in one of these two zones.***
#' 
#' ### TASK
#' 
#' Run some code that lets you examine the structure of the data, then run boxplots and histograms that 
#' allow you to examine the number of eggs by zone.You will need the lattice package for the histogram code 
#' and the psych package for the describe code.
#' 
## ------------------------------------------------------------------------
 

#' 
#' It would also be useful to look at our summary statistics including skew and kurtosis, but if we run 
#' the describe function on the data frame then we will only get summary statistics for the number of egg 
#' counts in both zones. Examine the output of the code below:
#' 
## ------------------------------------------------------------------------


#' What we really want is a function that lets us split the data by zone in the same way that we have 
#' done for the plots. To do this, we can use the function "describeBY". Conveniently, this is also in 
#' the psych package. ***Search for the describeBY function in the help window and you should see the help 
#' page come up with all of the arguments that are contained in the function.*** Now, run the code below.
#' 
## ------------------------------------------------------------------------


#' 
#' You will see that we have the eggs first followed by the zone. The code mat=T just tells R to keep the 
#' output in a convenient matrix so that we can compare them. 
#' 
#' ### QUESTION
#' What is your first thought on normality?
#' 
#' Let's double check our answer by running a Shapiro-Wilk test. You should know how to do this by 
#' using the tapply function:
#' 
## ------------------------------------------------------------------------


#' Next, we need to test for homogeneity of variance. First you will need to load in the car package 
#' and then add the code to test for homogeneity (i.e. Levene's test).
#' 
## ------------------------------------------------------------------------
 

#' 
#' ### QUESTION
#' Which test should we apply to see if there is a difference in the number of eggs found between zones? 
#' Conduct the test below. 
#' 
## ------------------------------------------------------------------------
 

#' 
#' ## ADDITIONAL EXERCISES
#' You have two additional data sets to download this week. For both of them, run summary statistics, 
#' produce some plots and conduct an appropriate test based on the information that you are given. A 
#' summary of each data set and the test that you need to do is given below:
#' 
#' ### USCrime dataset
#' 1. UScrime: contains information on the crime rate in 47 states of the US. The variable location 
#' also classifies the state as being the south or the north of the country. You need to examine whether 
#' there is a difference in crime rate between north and south. 
#' 
#' #### Workflow
#' Import the file:
## ------------------------------------------------------------------------
 

#' Examine structure, plots and summary stats:
## ------------------------------------------------------------------------
 

#' Run tests for normality and homogeneity:
## ------------------------------------------------------------------------
 

#' Run an appropriate test:
## ------------------------------------------------------------------------
 

#' NB: key here is to change the var.equal code to FALSE because Levene's test has indicated that you do 
#' not have equal variance. 
#' 
#' Is there a signficant difference in the crime rate between north and south?
#' 
#' ### Diet dataset
#' 2. Diet: This dataset includes a number of variables that looked at pre and post weights of people 
#' in a study where participants were asked to follow one of two different diets for 6 weeks. You are 
#' asked to examine whether there is a difference in the pre-diet and post-diet weight of participants 
#' i.e. has dieting been successful?
#' 
#' #### Workflow
#' Import the file:
## ------------------------------------------------------------------------
 

#' Examine structure, plot and summary stats (NB that you have two variables here and that the data are 
#' pre- and post- this should indicate that the data are not independent). NB: as the data are paired, 
#' you will need to create the new variable of the difference between pre- and post- weights.
## ------------------------------------------------------------------------
 

#' 
#' 
#' Run tests for normality: NB homogenity is not applicable to paired data
## ------------------------------------------------------------------------
 

#' Run an appropriate test:
## ------------------------------------------------------------------------
 

#' Does dieting work in this study?
#' 
#' #### Extend your knowledge. 
#' 
#' There were two different diets in this study, can we do a test to see whether one diet is more 
#' successful than the other? NB: If you examine the structure of the data, you will see that the diet 
#' type (Diet) is coded as an integer, you will need to recode it as a factor for some of the code to
#'  work. Do this before you run the rest of the code. 
#' 
## ------------------------------------------------------------------------
 


