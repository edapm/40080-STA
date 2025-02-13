#---
#  title: "Week4_self_test"
#author: "Tom Matthews"
#date: "27/08/2022"
#---


# Week 4: INDEPENDENT SAMPLES AND ANOVA
# Self-test exercise

### Loading and formatting the data

#We are going to use the same diet dataset as from last week.This data set
#contains information on 78 people using one of three diets. We are interested
#in seeing whether there is any significant differences in the weight lost
#across the three diets. Last week you compared pre and post weight for the same
#individuals, and these were thus not independent. However, here the data we
#will use are independent as we are interested in weight loss per diet. This is
#independent as the subjects are only used in one diet and were randomly chosen
#(i.e. not from the same family etc) dataset to load is called Diet_R

#First load the datafile in using read.csv() 
#Call the dataset 'dat'

dat <- read.csv(file.choose())

#You then need to run this line. Ignore it for now, it is just needed to put the
#data in the correct format

dat$Diet <- as.factor(dat$Diet)

#Have a look at the data, and use the table command to see how many individuals used each diet.

head(dat)

table(dat$Diet)


#We are interested in weight lost, but in the dataset we only have the weight at
#the start (pre.weight) and the weight after six weeks (weight6weeks). So, we
#need to create a new column called 'weightLost, which is the pre weight -
#weight at six weeks. We create new columns using the $ operator. For example,
#if our data frame / table was called 'Tom' and we wanted to create a new column
#called 'ecology', we would use: Tom$ecology <- 5, for example, and then all
#values in that column would be 5. Try and create the weightLost column in the
#'dat' dataframe.


dat$weightLost <- dat$pre.weight - dat$weight6weeks


### Assumptions and plots
#Using the new weightLost column as your response variable, check the
#homogeneity of variances using the leveneTest. Are we able to proceed with the
#ANOVA? YES Remember to load the car package first.

library(car)
leveneTest(weightLost~Diet, data = dat, center = mean)

#build a boxplot to look at the differences between weight lost through the different
#diets. Give the boxplot a title ("Weight loss from different diets"), and colour
#the boxes green.

boxplot(weightLost~Diet, data=dat, center=mean, main="Weight loss from different diets", col="green")


#which diet seems to be most effective according to the box plots? Do the
#medians of all three groups differ? Diet 3

### ANOVA and Tukey tests Now run an ANOVA and determine whether we can conclude
#significant differences in mean weight loss across the three diets

res <- aov(weightLost~Diet, data=dat)

summary(res)


#After running the anova we need to check that the residuals are normally
#distributed. So, run the shapiro wilks normality test on the extracted
#residuals and examine the histogram.Change the x-axis to say 'Residuals'

r <- residuals(res)
shapiro.test(r)
hist(r, xlab="Residuals")


#Are we confident that our ANOVA meets this assumption? Yes

#Looking at the boxplot earlier, it seemed that there were not large differences
#between all groups, and so a Post hoc test would be useful.

#Run a Tukey Post hoc test on the data. Which groups differ from each other?
#Does this match up with your interpretation of the boxplot?

tukey_out <- TukeyHSD(x=res) 
plot(tukey_out)

### ADDITIONAL EXERCISES
#Use the same workflow to analyses whether there is a significant difference in
#the heights of people on the different diets. So here, height is our response
#variable instead of weightLost. As a first step, look at the boxplot - does
#there look to be any differences? Then, fit the ANOVA model and look at the
#residuals. Do you they meet the assumption of normality? If not, fit a Kruskal
#Wallis test. Do the ANOVA and Kruskal Wallis test give the same results?

#make a boxplot
boxplot(Height~Diet, data=dat, center=mean, main="Height of people on different diets", col="green")


#run the anova
res2 <- aov(Height~Diet, data=dat)

#extract and inspect the residuals
r2 <- residuals(res2)
shapiro.test(r2)
hist(r2, xlab="Residuals")

#run the kruskal wallis test
kruskal.test(Height~Diet, data=dat)

