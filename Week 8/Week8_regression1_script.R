##SIMPLE LINEAR REGRESSION

#' ---
#' title: "Week8"
#' author: "Tom Matthews"
#' date: "28/09/2022"
#' ---
#' 

# WEEK 8: Simple linear regression

#NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE:
  
#  1. Completed the lecture material by Dr Ian Phillips
#  2. Completed the compulsory reading (i.e. Chapter * of the Handbook) and additional exercises

## Regression
#You have previously looked at correlation, which is testing for an association
#between two variables, but it does not make any assumptions about causality.
#Regression on the other hand is directional - we have a response variable (that
#we want to explain) and 1 or more predictor variables that we believe will
#explain our response variable. For example, our response variable might be the
#number of birds in forests, and our predictors could be size of forest, distance
#of forest to other forests, latitude of forest and amount of human disturbance.
#We then test whether these predictors do explain variation in the number of
#birds between different forests.When there is more than one predictor it is
#called multiple linear regression and is the focus of next week's lecture. Today
#we are interested in simple (bivariate) linear regression: one response and one
#predictor.

#Remember: a response variables is also called a dependent variable, and the
#predictor variable is also called the independent variable

#In today's practical we are focused on what is called a continuous predictor
#variable, i.e. it can take any number (e.g height, weight, amount of rainfall).
#If you remember back to our ANOVA lessons, the predictor was categorical, i.e.
#it was split into groups (e.g. Control and treatments). ANOVA is actually a
#form of linear regression, simply where the predictor is of this categorical
#form. But today we are interested in cases when the predictor is continuous.

## Loading the data
#lets load in the dataset we will use today (Crime_R) and take a look at it.
#This provides the crime rates in US States with a number of additional variables, such
#as number of people in the state, money spent on police and education etc.


dat <- read.csv(file.choose())

head(dat)
str(dat)


## Plotting the data
#For the first exercise we will be using as our response variable - Crime_rate
#(number of offenses per million population), and as our predictor variable
#CrimeRate10 (crime rate ten years ago in the same place), As always, a useful
#first step is to plot the data, and as we are using continuous data, we will
#use a scatter plot. This is a good example of the use of regression as here our
#hypothesis would be that the crime rate ten years ago is a driver of the
#current crime rate, rather than vice versa (the current situation is not going
#to cause things to happen in the past) 

#first, lets look at a simple scatter plot of the two variables


plot(dat$CrimeRate10, dat$Crime_rate)


#QUESTION: is crime10 a good predictor of the current crime rate based on this plot?
  
#We can also look at the distributions of the two variables using histograms.
#The assumptions of linear regression normality actually refer to the residuals
#(i.e. the residuals need to be normally distributed) but if either the response
#or predictor variables are very skewed, we will often have issues with our
#residuals. We will go over the concept of residuals and how to test they
#are normally distributed in week 10, so don't worry if you don't understand
#what that all means at this stage!

hist(dat$Crime_rate)

hist(dat$CrimeRate10)


## Fitting a regression model
#lets proceed to actually fitting the regression model. We use the 'lm' function
#for this and, as with most tests we have looked at, it only needs one line of
#code. You should be familiar with this notation now from the ANOVA lecture: our
#response variable goes to the left of the ~, and out predictor to the right.


mod <- lm(Crime_rate ~ CrimeRate10, data = dat)


#We can look inside the mod object, but as with ANOVA, more useful information
#is provided from using the summary function. This gives us an output table with
#the regression coefficients in it, and some other useful info. The coefficients
#table gives us our coefficient (also called the slope) for CrimeRate10. A
#regression coefficient tells us how much the response variable increases with a
#1 unit increase in the predictor variable. So a coefficient of 2 would mean
#that increasing the predictor by 1 means the response increases by 2.We also
#have information about the coefficient's corresponding standard error (how
#precise it is), t-value (the ratio of the coefficient and its standard error)
#and P-value (if significant it tells us the coefficient is significantly larger
#than zero). It also gives us a model intercept: where the regression line
#crosses the y-axis, so the value of our response variable when our predictor
#variable is zero. The F-statistic and p-value tell us whether the model as a
#whole is significant, and the R2 is giving us a measure of how well our model
#explains the response variable (it is between 0 and 1, with 1 being a perfect
#fit)

#Technical information (don't worry if confusing): 
#The correlation coefficient (i.e. the correlation of y and x, cor(y,x)) is the
#slope relating Y to X in a lm if both variables are measured as z scores (each
#having mean zero and standard deviation one). The squared correlation
#coefficient (which is the R2) indicates the proportion of variance in Y that is
#shared with (or accounted for) by X.


mod

summary(mod)


#QUESTION: Based on the coefficient p-value and the model R-squared, do you
#think CrimeRate10 is a good predictor of the current crime rate? YES
  
## Plotting a linear regression fit
#We may wish to plot the fit of our regression model, and could be tempted to
#use the 'plot' function. However, with an lm object, the plot function will
#provide model diagnostic plots. These are very useful, allowing us to test the
#assumptions of the regression model, and we will come back to this in a future
#practical.

#To actually plot the model fit, we need to first plot the points and then we
#add the fitted line from the regression model. To do this we need the fitted
#values, and we extract them using a function called 'fitted'. This gives us,
#for each data point we have, the value of the response variable our model has
#predicted. We then use the 'lines' function to add these on as a line, where
#our predictor variable is on the x-axis, and our fitted values are on the
#y-axis. The lines function draws a line through these points. 

#As a way of helping you understand a regression coefficient, we can add what is
#called a 1-1 line to the plot. This is a line that goes through the origin (0,0
#point) and has a slope of 1, so an increase of the predictor variable by 1
#equals an increase in the response variable by 1. If we add this to our plot we
#can see our model line (red) is shallower.

#NB YOU DO NOT need to add 1-1 lines on plots in general (or for your
#assignments), it is just here in this instance to help you understand what a
#regression coefficient (slope) means


f <- fitted(mod)

plot(dat$CrimeRate10, dat$Crime_rate, pch = 16)

lines(dat$CrimeRate10, f, lwd = 2, col = "red")

abline(0,1)

#QUESTION: looking at this abline, the fitted regression line and the
#coefficient for CrimeRate10, does this make sense? What is this telling us?
#REMEMBER: the coefficient of a predictor is also called its 'slope'.

## Using a regression model for prediction
#One use of a regression model can be to predict values of our response value.
#For example, say you acquired new crime data from ten years ago for an area in
#the US that wasn't in our original dataset, we may then want to use our model
#to predict what the current crime rate would be. This can be done within the
#range of our original data, or we can extrapolate, i.e. extend that red line to
#new values of CrimeRate10, though we should note that this can be very risky.
#For this we use the predict function, but first we have to create a new table /
#dataframe with a column with the same name as our predictor and then our values
#we want to use.

new_dat <- data.frame("CrimeRate10" = c(40, 400, 1000))

p <- predict(mod, newdata = new_dat)

p


#we can then make a new plot with these values added on as large blue triangles.
#have a look at this website for different arguments you can use with plot
#(point shape, size, colour etc):
#http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r

plot(dat$CrimeRate10, dat$Crime_rate, pch = 16)

lines(dat$CrimeRate10, f, lwd = 2, col = "red")

points(new_dat$CrimeRate10, p, pch = 17,  cex = 3, col = "blue")


#BUT, you will notice that only one of our predicted values (blue triangles) is
#on the graph.

#QUESTION: can you think, looking at the code, why that might have happened?

#it is because our original plot (called using the plot function) was based on
#CrimeRate10 and Crime_rate, and R automatically adjusts the axis ranges to fit
#these data. But if we add new lines and points on to this plot, it doesn't
#extend the axes, so new points outside this range are not shown. To deal with
#this, we need to extend our axis ranges at the start when we call the plot
#function. We can use xlim and ylim arguments to do this. But you will need to
#put in sensible values based on the smallest and largest values in your
#predictor and fitted & predicted values.


plot(dat$CrimeRate10, dat$Crime_rate, pch = 16, 
     xlim = c(0, 1000), ylim = c(0, 800))

lines(dat$CrimeRate10, f, lwd = 2, col = "red")

points(new_dat$CrimeRate10, p, pch = 17,  cex = 3, col = "blue")


#QUESTION: plotting like this shows us how far outside the range of our model
#two of our predicted values are. Do you think it is sensible to extrapolate our
#model so far to make predictions like this? No
  
#**Well done - you can now run and interpret a simple linear model in R! Now,
#work your way through the self-test exercise.**
  
  