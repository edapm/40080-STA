#' ---
#' title: "Week 5 Chi Square Self Test Exercise"
#' author: "Liz Hamilton"
#' date: "16/09/2020"
#' output:
#'   pdf_document: default
#'   html_document: default
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

rm(list=ls())

#' 
#' ## Todd Data File
#' 
#' I have put a paper on Canvas that you should scan read to understand the background to this exericse. 
#' 
#' 1.	Access the paper by Todd et al., (2007): https://www.sciencedirect.com/science/article/pii/S0168159106003182 . Scan read the methods section, and look at the results. Also, take note of how they present their results (i.e. the figures). Answer the following questions:
#' a.	What are the categories that Todd et al (2007) use for their Chi-Square analyses?
#' b.	How are the results presented?
#' c.	Why is there a statement at the bottom of the figure regarding percentages?
#' 
#' *Answers:
#' a. The five activity categories
#' b. Bar chart
#' c. To clarify that they used the raw data - not the % data to run the test. You should never run a chi square test on percentages.*
#' 
#' Download the Todd data file and bring the data into R. Run the Chi Square test and see if you get a similar result as the paper (or thereabouts) - it may differ slightly as I was working with secondary plot data and it is not quite as accurate as if I had the real data.
#' 
## ------------------------------------------------------------------------
todd <- read.delim("Todd-1.txt", row.names = 1, header = TRUE)
chisq <- chisq.test(todd)
chisq

#' 
#' Examine the observed and expected groups. What do the standardised residuals tell you about the effect of group size on behaviour?
#' 
## ------------------------------------------------------------------------
chisq$observed
chisq$expected

#' 
#' Another way to look at the effect of the category on the Chi Square value is to look at the standardised residuals. Values greater than |2| when there are few cells or about 3 when there are many cells indicates lack of fit of Ho in that cell i.e. there is an important effect!
#'  We can do this with the following code:
#' 
## ------------------------------------------------------------------------
chisq$stdres

#' 
#' Which of the categories has the greatest effect?
#' 
#' Answer: Grooming behaviour when there are no visitors is increased.
#' 
#' ## Plotting the data
#' 
#' The plot in Todd plots percentages. If we want to plot the percentages, we need to work them out first:
#' 
## ------------------------------------------------------------------------
library(dplyr)
perc.todd = mutate(todd, 
                zero = Zero / sum(Zero),
                small = Small / sum(Small),
                large = Large / sum(Large))
perc.todd$behaviour<-c("Observing", "Feeding and chewing", "Playing", "Grooming", "Resting and sleeping")

#' 
#' Notice that I have done a simple calculation to work them out first and used the mutate function in dplyr to make a new data frame called perc.todd. I will still need to rearrange this for plotting.
#' 
#' Can you rearrange the data using the gather function from tidyr to create a new data frame called perc.todd_long. You should create new variables for visitor.no and percent first, and then use ggplot to graph the data.
#' 
## ------------------------------------------------------------------------
library(tidyr)
perc.todd_long <- gather(perc.todd, visitor.no, percent, zero:large, factor_key = TRUE)

library(ggplot2)
ggplot(perc.todd_long, aes(x = behaviour, y = percent, fill = visitor.no)) + geom_bar(stat = "identity", position = "dodge") + xlab("Behaviour") + ylab("Fraction")

#' 
#' Or you could create a better looking plot!
#' END...............
