# ---
#   title: "Week8_self_test"
# author: "Tom Matthews"
# date: "29/08/2022"
# ---

# Week 8: SIMPLE LINEAR REGRESSION
# Self-test exercise

### Loading and formatting the data
#We will use the same dataset (Crime_R.csv) from the practical, so load this in
#again and call it 'dat', have a look at the dataset and all of its columns
#using e.g. the head() function.

dat <- read.csv(file.choose())



## ------------------------------------------------------------------------



### plotting
#We are going to look at whether Education10 (average number of years schooling
#up to 25 - 10 years ago) is a significant driver of CrimeRate10 (the crime rate
#in US states ten years ago). As a first step, build a scatter plot of these two
#variables. Make the points red using the 'col' argument


plot()


## ------------------------------------------------------------------------


#Does there look to be a relationship between Education10 and CrimeRate10?
  

### linear regression
#Fit a linear model using these two variables (remember to get the response and
#the predictor variables the correct way round in the formula notation). Look at
#the model summary to investigate the model fit


mod <- lm()

## ------------------------------------------------------------------------


#Is Education10 a significant predictor of Crime10? What does the model R2 and
#p-value (of the F-statistic) tell us about this model?
  

### Plotting the model fit
#Repeat the above exercises but instead testing whether Wage10 (median weekly
#wage ten years ago) is a significant driver of CrimeRate10.




## ------------------------------------------------------------------------


#What does the model summary (e.g. predictor coefficient, model R2) tells us
#about this relationship?
  
#Re-do your scatter plot and then plot the fitted values from your model on top
#as a dark blue line. HINT: remember to use the fitted() function as a first
#step on your model




## ------------------------------------------------------------------------


### Model prediction

#Using the plot of your model fit (dark blue line), estimate by hand what the
#CrimeRate10 would be with a Wage10 value of 600. By hand I just mean find 600
#along the x axis and go up to the regression line and then go across to the
#y-axis and read off the value

#Now create a new dataframe with one column (Wage10) and one value in the column
#(600) and use the predict function to get your model to predict exactly the
#value of CrimeRate10.



## ------------------------------------------------------------------------


#Does this match roughly what you got doing it by hand?
  
  
### Additional exercises
  
#Repeat the prediction exercise, but predicting using a value of Wage10 outside
#of the range of the data we have (E.g. 1000), and then plot this point (colour
#it green) on your model fit plot, using the xlim and ylim arguments to expand
#the plot axes to fit this point in.




## ------------------------------------------------------------------------

#As a final step experiment with what happens if instead of providing a specific
#colour as our 'col' argument (e.g. "green") we give it a variable with
#different categories. For example, in our 'dat' dataframe / table, there is a
#column called "Southern" (whether the state is southern or not). Give this
#column to the 'col' argument in the plot function and see what it does.

#As a first step you will need to run this line (it converts the southern
#column, which has values of 1 and 0, to a categorical variable - i.e. where R
#realizes 0 and 1 are different groups - rather than a continuous variable)


dat$Southern <- as.factor(dat$Southern)


#Now have a go at using it in the plot function.



## ------------------------------------------------------------------------


#Can you see what this has done?
  
  
  
  
  
  
  
  
  
  
  

