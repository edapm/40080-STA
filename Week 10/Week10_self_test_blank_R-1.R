
# title: "week10_self_test"
# author: "Tom Matthews"
# date: "09/09/2020"
  

## Loading and formatting the data
# We will be using a dataset called heart.data.csv. The dataset contains
# observations on the percentage of people biking to work each day (biking), the
# percentage of people smoking (smoking), and the percentage of people with
# heart disease (heart.disease) in an imaginary sample of 500 towns. It comes
# from: https://www.scribbr.com/statistics/linear-regression-in-r/

# Load it in and call it 'dat'. Have a look at it using the head() function.


# First, fit a simple linear model (call it mod) using heart.disease as your
# response variable and biking as your single predictor variable. And then look
# at the summary and plot the fit of the model using code learnt in previous
# practicals



# QUESTION: based on this plot, does there appear to be a linear relationship
# between biking and heart.disease? Remember, a linear relationship can be
# positive or negative. Can you interpret the model summary output and what it
# is telling us?



## Testing assumptions
# Now, using this model test the assumptions of linear regression you went over
# in the main practical. First, check the normality of the residuals assumption
# by looking at the QQ plot and by running a Shapiro Wilks test.



# QUESTION: Based on the QQ plot and the shapiro.test, do you think we have
# violated the residual normality assumption?


# To try and deal with this violation of normality, first have a look at
# log-transforming the response variable using the log() function. This function
# can be used within the lm() function. Call this new model, mod2. Then re-make
# the QQ plot and re-run the shapiro test.
# Remember - a number like 2.2e-16 is very small!

mod2 <- lm(log(heart.disease) ~ biking, data = dat)




# So that doesn't look to have helped! Perhaps it is instead a sign that we are
# missing an important predictor variable. Remove the log() function and add the
# predictor 'smoking' into your model (i.e. a model with 2 predictors). Call
# this model, mod3. Then re-make the QQ plot and re-run the shapiro test.
# Remember, it is a good idea to test for any multicollinearity between the
# predictors first. As there are only two variables you can use cor.test().
# QUESTION: how does this look?

cor.test(dat$biking, dat$smoking) #QUESTION: how does this look?

mod3 <- lm()


# QUESTION: Has including smoking improved things in terms of normality?

# Now examine the linearity assumption and the homogeneity of (residual)
# variance assumption using the relevant plots we went over in the practical,
# using this new 'mod3'. 



## Additional exercise 1

# using mod3, look at the relevant plots for checking for influential outliers.
# Do you think there is any problems with outliers in our model? Remember to
# look at the Cook's distance values and the standardised residuals values.


# To illustrate what an outlier problem looks like have a go at running the
# following lines, and then re-making the plots. The first line is adding a new
# row to our 'dat' dataframe with some new values which are extreme (i.e. heart
# disease of 100%!) but just by way of example. And it then re fits our model
# using this new version of the dataset.


dat2 <- rbind(dat, c(4, 1, 100))

mod3 <- lm(heart.disease ~ biking + smoking, data = dat2)


# Look at the Cook's distance and standardized residual of this new point. You
# can now see what a true influential outlier looks like!

## Additional exercise 2

# lets simulate some data with some amount of temporal autocorrelation. To do this we need
# to install and load a new R package called DHARMa. We then use the createData function
# which simulates some regression data for us, with some amount of temporal autocorrelation
# included.


#install.packages("DHARMa")
library(DHARMa)

#just run this as is to simulate the data and call it testData
testData <- createData(sampleSize = 100, family = gaussian(), 
                       temporalAutocorrelation = 5)

#now we fit a lm model with observedResponse as the response variable,
#and Environment1 as the predictor, in the testData dataset
testMod <- lm(observedResponse ~ Environment1, data = testData)

#Now run the durbin watson test on this model's residuals (remember, we just give the
#function the model, it extracts the residuals itself)
library(car)


# QUESTION: based on the DW statistic and p-value do we have significant temporal
# autocorrelation here? Is it positive or negative.














