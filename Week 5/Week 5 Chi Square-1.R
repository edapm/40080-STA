#' ---
#' title: "Week 5 Chi Square"
#' author: "Liz Hamilton"
#' date: "15/09/2020"
#' output:
#'   pdf_document: default
#'   html_document: default
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

#' 
#' ### Clearing the workspace
#' 
#' It is a good idea to clear your workspace every time you start a new session in R. The 
#' code below lets you do this. Also check that the global environment is clear (click the 
#' little brush) and the same for plots.
#' 
## ------------------------------------------------------------------------
rm(list=ls())

#' 
#' ### Chi Square
#' 
#' So this week you have looked at the non parametric Chi Square test for frequencies/proportions. 
#' If you are conducting survey data then this is still a quantitative method and Chi Square is 
#' going to be go to test in most circumstances. There are two forms of the Chi Square test i.e. 
#' the Goodness of Fit test (used where you only have one categorical group e.g. sex of participant)
#' and the Chi Square Test of Independence (or Association). 
#' 
#' Let's use the example from Ian's lecture where you looked at household size. I have put the 
#' data in a file called Household.Size that you can download from Canvas and save before 
#' importing. Notice that this time the file is a text file (it is easier to save in this format 
#' for Chi Sq) - and that the import code has been changed accordingly.
#' 
## ------------------------------------------------------------------------
Household.Size <- read.delim(file.choose(), row.names = 1)
Household.Size

#' 
#' Ian worked with the one person households first, so lets extract just that data from the data 
#' frame. In this case we just have the one category so strictly speaking this is a goodness of 
#' fit test. We can conduct it with the code in the chunks below. 
#' 
#' You will see that I have created a new data frame called one.person and subsetted the data. 
#' This is followed by the name of the original data frame that I want to extract the data from 
#' (i.e. Household.Size) and then notice, I am telling R that I want just one row and then there 
#' is a comma followed by an empty space. The empty space if for specifying the number of columns. 
#' In this case I want all columns so I have left it blank. There is a link here to more examples:
#'  https://dzone.com/articles/learn-r-how-extract-rows. I now have only the data I want to test 
#'  (i.e. one person households) in the new data frame, one.person.
#' 
## ------------------------------------------------------------------------
one.person<-Household.Size[1,]

#' 
#' Let's assume that we would expect there to be an equal number of one person households in the 
#' two towns. We can tell R that we expect the proportions to be i.e. 50:50 statsitically. Let's 
#' create a new object called res, and then run the test. Notice that the function is chisq.test 
#' and that this is followed by the data frame that you want to work with. Finally, I have told R 
#' that I expect the proportions to be 50:50, or in this case 1/2 and 1/2. 
#' 
## ------------------------------------------------------------------------
res <- chisq.test(one.person, p = c(1/2, 1/2))
res

#' 
#' You can see that if I just look at the data for the one person households, there is not a 
#' signficant difference. *However, when you did the calculations with Ian, you were not looking 
#' at one person households in isolation. You were considering all of the different household 
#' size categories in the survey data.* In other words, you have two groups that you want to look 
#' at - the towns and the household size. So, for this we need the test of association. 
#' 
#' Let's work with the Household.Size file that has all of the data in it. We can conduct the 
#' test as follows:
#' 
## ------------------------------------------------------------------------
chisq <- chisq.test(Household.Size)
chisq

#' 
#' This is similar to Ian's calculation *(although see Ian's notes at the end of the lecture for 
#' why it is not exact)*. We can also see the observed and expected values by using the following 
#' code:
#' 
## ------------------------------------------------------------------------
chisq$observed
chisq$expected

#' 
#' These do agree with Ian's values but you can see that they are to 4 d.p. rather than 2.
#' 
#' Let's use another example of Ian's. You looked at the Khartoum data earlier this week. Download
#' and install the Khartoum file from Canvas and then bring it into the workspace. Take a look at 
#' the structure of the data by clicking on the data frame to the right. 
#' 
## ------------------------------------------------------------------------
Khartoum <-read.csv(file.choose(),  header=T, sep=",")

#' 
#' Notice that this is a csv file rather than a text file. As you will see, the data are in long 
#' form and what we really need to do is summarise it. We can do this by putting in into a table 
#' where we count all the instances in each category:  
#' 
## ------------------------------------------------------------------------
Khartoum.table <- with(Khartoum, table(reszone, educ))
Khartoum.table

#' 
#' We can also tell R to give us the proportions: 
#' 
## ------------------------------------------------------------------------
Khartoum.prop<- prop.table(Khartoum.table, margin = 1)
Khartoum.prop

#' 
#' For the next part. I would like you to save your file before we continue. Make sure that you 
#' are saving it somewhere logical. Once you have saved it, we will set the working directory. 
#' This is something that you probably have done already but not really known about it. But 
#' setting the directory can make importing files etc. much easier as the browser takes you 
#' straight to the file location. Go to Session > Set Working Directory > To Source File Location. 
#' You will then have told R where to keep any additional files you create/install. This is 
#' important for the next part where we export the table that we have created into a new Excel 
#' file.
#' 
write.table(Khartoum.table, file = "KhartoumNew.txt", sep = ",", quote = TRUE, row.names = T)

#' 
#' Check your working directory (i.e. where you have saved this file), you should now see a new 
#' text file has appeared called KhartoumNew! This is useful if you want to save the data for 
#' later analysis. 
#' 
#' We can also get the counts, contributions to Chi Square and summary totals using the following 
#' code. This is useful for identifying those categories that make the most contribution to the 
#' final Chi Square test value i.e. which categories have the most influence. The function is 
#' in the gmodels package so install this first by going to Tools > Install Packages.
#' 
## ------------------------------------------------------------------------
library(gmodels)
CrossTable(Khartoum$reszone, Khartoum$educ)

#' 
#' Running the test is simple - we just use the function chisq.test:
#' 
## ------------------------------------------------------------------------
Khartoum.chisq<-chisq.test(Khartoum$reszone, Khartoum$educ)
Khartoum.chisq

#' 
#' However, you can see that there is an error message here stating that the approximation may 
#' be incorrect. If we look at the expected and observed counts we will be able to see why. As 
#' you know from the lecture, there are quite a few instances that fall foul of the 20% rule. 
#' 
## ------------------------------------------------------------------------
Khartoum.chisq$observed
Khartoum.chisq$expected

#' 
#' To circumvent this, we can recode the data as you did with Ian. You will need to install the 
#' plyr package first if you have not already by going to Tools > Install Packages. 
#' 
## ------------------------------------------------------------------------
library(plyr)
Khartoum$newEduc<- as.numeric(revalue(as.character(Khartoum$educ), c("2" = "1", "3" = "2", 
                                                                     "4" = "2", "5"="2")))

#' 
#' This code looks a little comple but all we are doing is telling R to create a new variable 
#' called newEduc and that it is numeric. We then use the revalue function and code it as a 
#' character (this particular function only works for character vectors) before telling R what 
#' the old value was and what should replace it. You should see that there is a new column in 
#' your file with the new coded variables. We can now run the Chi Sq test again but using this 
#' new variable:
#' 
#' 
## ------------------------------------------------------------------------
Khartoum.chisq<-chisq.test(Khartoum$reszone, Khartoum$newEduc)
Khartoum.chisq

#' 
#' Hooray! We no longer have an error message and you have completed the Chi Square coding.  
#' 
#' ### Plotting the results of Chi Sq
#' 
#' As this week is rather simple in terms of the code, I thought it might be an idea to include 
#' some plotting. The main plots that you will need for Chi Square are the pie charts (although 
#' as and Environmental Scientist these are not my favourite!) and bar charts (ahh, much nicer 
#' and less likely to make me feel slightly queasy). Despite my prejudice, there can be a time 
#' and a place for a pie chart so let's do one of these first.
#' 
## ------------------------------------------------------------------------
pie(Household.Size$Exeter, main="Exeter")
pie(Household.Size$Exmouth, main="Exmouth")

#' 
#' This is the most simple version of a pie chart that you can create in R but you can polish it 
#' to make it stand out and there are ways to make it more exciting. Let's use the Exeter data. 
#' 
## ------------------------------------------------------------------------
slices <- c(44, 81, 45, 30) # create a new vector with the values 
lbls <- c("one", "two", "three", "four or more") # give the labels a better name
pct <- round(slices/sum(slices)*100) # convert the values to percentages
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % symbol to labels
pie(slices,labels = lbls, col=cm.colors(length(lbls)), # change the colour scheme 
    #- other options include rainbow, topo.colors, terrain.colors.
   main="Pie Chart of Household Size in Exeter")

#' 
#' My preferred option is a bar chart. For this we can use the simple bar chart standard creation,
#'  or else we can spend a bit of time and create something that is truely of publishable quality.
#'   I will show both. 
#' 
## ------------------------------------------------------------------------
barplot(Household.Size$Exeter, main="Exeter",
   ylab="Number of Participants")

#' 
#' As you can see, this is not a very good plot as I dont know what the bars relate to. This is 
#' because of the way that I have set up my file Household.Size. You will see that the categories 
#' are not in a separate column, so to resolve this I am going to create a new variable with the
#'  names of the categories: 
#' 
## ------------------------------------------------------------------------
Household.Size$Category<-c("one", "two", "three", "four or more")

#' 
#' Let's plot the bar chart again with a little modification to include this: 
#' 
## ------------------------------------------------------------------------
barplot(Household.Size$Exeter, main="Exeter", names.arg=Household.Size$Category,
   ylab="Number of Participants", xlab="Household Size", col="blue")

#' 
#' I still would not be overly pleased with the look of this but it is ok. But what I really want
#'  to do is have the two cities size by side so it is easier to compare the categories. To do 
#'  this, I need the data in a different format. The easy way to do this is to rearrange the data
#'   in Excel and reimport it, but I will code it in R for those of you that are a bit more 
#'   confident. Don't worry, if you have to do it for your own data, you can arrange it in Excel 
#'   and then bring in the new file. 
#' 
#' You will notice that the code below uses a function from the tidyr package - so install this 
#' first if you haven't already. Then it uses the gather function, I have stated the old data 
#' frame name and then given some new variable names of Place and Number because these are the 
#' ones that I am interested in rearranging. I then tell R to rearrange the old variables Exeter 
#' to Exmouth and that it is a factor. 
#' 
## ------------------------------------------------------------------------
library(tidyr)
Household.Size_long <- gather(Household.Size, Place, Number, Exeter:Exmouth, factor_key=TRUE)
Household.Size_long
str(Household.Size_long) # this shows that Category is a character variable 
#- I want to change it to a factor variable
Household.Size_long$Category.f<-as.factor(Household.Size_long$Category) 
  # creates a new factor variable

#' 
#' I can now plot the data in an easier way by using the ggplot package.
#' 
## ------------------------------------------------------------------------
library(ggplot2)
ggplot(Household.Size_long,  aes(x = Category.f, y = Number, fill = Place)) + 
       geom_bar(position="dodge", stat="identity")

#' 
#' This is a basic plot which I dont really like the look of, so to tidy it up I can make the 
#' code a little more complex. 
#' 
## ------------------------------------------------------------------------
Household.Size_long$Category.f <- factor(Household.Size_long$Category.f,
                                         levels = c("one", "two", "three", "four or more")) 
# this bit of code just tells R the order that I want the factor in - otherwise R will plot 
# it alphabetically as it has above.

ggplot(Household.Size_long,  aes(x = Category.f, y = Number, fill = Place)) + 
       geom_bar(position="dodge", stat="identity")+ # basic plot
  scale_fill_manual(values = c("dark grey", "black")) + # change the bar colours
  theme_bw()+ theme(axis.text = element_text(size = 12))+ # change colour scheme to black and white
  theme(axis.title.y = element_text(size = 13))+ # set axis title size
  xlab("") + ylab("Number of Participants") # change the titles of the x and y labels

#' 
#' Much better! I am sure you can improve on this too - there are a lot of options within ggplot 
#' - Google it if interested.
