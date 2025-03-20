
# title: "Week9_self_test"
# author: "Tom Matthews"
# date: "02/09/2022"


# Week 9: MULTIPLE LINEAR REGRESSION
## Self-test exercise

### Loading and formatting the data
#We will use a smaller version of the Crime_R dataset (Crime2_R.csv) from the
#practical. Dataset details:
#Crime_rate	Crime rate (number of offences per million population) (our response variable)
#Location	state location E = east, C = central, W = west (categorical predictor)
#Youth	Young males (number of males aged 18-24 per 1000)
#Education	Education time (average number of years schooling up to 25)
#ExpenditureYear0	Expenditure (per capita expenditure on police)  
#LabourForce	Youth labour force (males employed 18-24 per 1000)
#Males	Males (per 1000 females)
#StateSize	State size (in hundred thousands)
#YouthUnemployment	Youth Unemployment (number of males aged 18-24 per 1000) 
#MatureUnemployment	Mature Unemployment (number of males aged 35-39 per 1000)
#Wage	Wage (median weekly wage)
#BelowWage	Below Wage (number of families below half wage per 1000)
#n.b. the Location variable has been randomly simulated to provide a categorical predictor, it did
#not originally appear in the dataset

#so load this inand call it 'dat', have a look at the dataset
#and all of its columns using e.g. the head() function.

dat <- read.csv(file.choose())

head(dat)


## Build a MLR Model

#remember, lots of these predictor variables are on different scales (see the
#variable descriptions above). You need to bear this in mind when interpreting
#the model coefficients.

# as a first step for you to do, build a multiple linear regression model (MLR)
# with Crime_rate as the response variable and all the other variables as the
# predictor variables (the full model). Look at and save the summary of this
# model, and then extract (from the summary output object) and save the model R2
# and model adjusted R2 values as different objects.

l <- lm(data = dat, Crime_rate ~ .)
sum_l <- summary(l)
model_r2 <- sum_l$r.squared
model_adjr2 <- sum_l$adj.r.squared

# Have a look at this output - do you think we need all of these variables in here?
# no

#For our categorical predictor (Location), as discussed in the main practical,
#we have multiple terms / coefficients in our model as it has three levels (E, C
#and W) and it compares our E level (LocationE) to the base level (here C was
#used) and our 2 level (LocationW) to the base level. Use the anova function to
#have a look at the p-value for the categorical variable as a whole. Is it
#significant at the 0.05 level? no

aov(l)

## Stepwise model selection

#Use the step() function to run a stepwise model process using your full model
#as the starting point. Call the object x Remember to use the direction = "both"
#argument to ensure if runs a stepwise selection. Save the step function output
#as an object, and look at the summary() of this object.

x <- step(l, direction = "both")
summary(x)

# What variables have been selected in this optimal model? Using the coefficient
# sign (positive or negative) can you interpret this model output, i.e. how
# these predictors affect the response variable (crime_rate)? Youth, ExpenditureYear0, LabourForce, MatureUnemployment
# Youth makes crime_rate go up, ExpenditureYear0 makes crime_rate go down, LabourForce makes crime_rate go down, MatureUnemployment makes crime_rate go up


# Compare the R2 and adjusted R2 of this simplified model with the values from
# your full model that you saved earlier. Do the changes make sense?
# yes


# Use the drop1 function to test dropping the Youth variable from this
# simplified model. What happens to the model AIC? Then use add1() to add back
# in the Males variables. Based on this, is our model selection correct in
# including Youth in the optimal model and excluding Males? Yes, the AIC is lower when Youth is included
# Remember: a lower AIC means a better fitting model, and the model with the
# added/removed variable is on the second row.
drop1(x, "Youth")
add1(x, "Males")

## Additional exercise
# Often we are interested in how two variables interact. In short, this means
# that the value of one variable changes depending on the value of another. For
# example, we might expect the effect of ExpenditureYear0 (per capita
# expenditure on police) to have a larger effect on the crime_rate in states
# where StateSize (popn size in hundred thousands) is higher, and vice versa. We
# include interactions in MLR in R using the star(*) sign instead of the +
# sign. For example, lm(y ~ A*B) tests the effects of A and B on y individually,
# as well as the interaction between A and B. This is useful, as you should
# always include the individual effects of variables as well as their
# interaction.

# have a go at building a MLR model, with crime rate as the response variable
# and with two predictors: ExpenditureYear0 and StateSize. And then also testing
# the interaction between them. Look at the summary of the this model and the
# coefficient and significance of the interaction term. Was our hypothesis of an
# interaction correct?
y <- lm(data = dat, Crime_rate ~ ExpenditureYear0 * StateSize)
summary(y)

# No, the interaction term is not significant (p = 0.161)