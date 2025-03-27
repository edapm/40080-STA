
#Ignore
#.libPaths("U:/")


##LINEAR REGRESSION ASSUMPTIONS

#' ---
#' title: "Week10"
#' author: "Tom Matthews"
#' date: "07/09/2024"
#' ---
#' 

# WEEK 10: Regression Assumptions

#NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE:

#  1. Completed the lecture material by Dr Ian Phillips
#  2. Completed the compulsory reading and additional exercises

#A couple of good web resources on checking linear regression assumptions in R
#http://www.sthda.com/english/articles/39-regression-model-diagnostics/161-linear-regression-assumptions-and-diagnostics-in-r-essentials/
#https://ademos.people.uic.edu/Chapter12.html#2_regression_assumptions

## Load the data
#We will use a dataset (marketing) from the datarium package. This is a data
#frame containing the impact of the budget spent on three advertising medias (youtube, facebook and
#newspaper) on sales. The advertising experiment has been repeated 200 times
#(200 rows).

#install.packages("datarium") #install the package if you have not previously done so

library(datarium)

data(marketing)

head(marketing)

#As a first step, fit a simple linear model using youtube advertising to predict sales

mod <- lm(sales ~ youtube, data = marketing)

summary(mod)

#Plot the model fit
plot(marketing$youtube, marketing$sales)
lines(marketing$youtube, fitted(mod))

#QUESTION: what is the model telling us? What is the model R2, the coefficient, P-value etc
# R2 = 0.6099, coefficient = 0.047..., p-value = 2.2e-16 (significant!)

## Re-cap on residuals 
#Formally, a residual is the vertical distance between a data point and the
#regression line. More generally, it is the part of the response variable (the
#error) that is not explained by the fitted line (your model). Unless your model
#perfectly fits all of the data (i.e. your R2 value = 1), some of the residuals
#will be greater / less than zero. We can have a look at the residuals from our
#model above, using the residuals() function we used in previous practicals.

#Today we will use a different function from the broom package. This returns a
#table where we have our values of our response and predictor, and then the
#fitted values (i.e. the values in our straight line) and then the residuals.
#You will see that the you can get the residual value by simply subtracting the
#the fitted value from the response value (here, sales). And the residual can be
#positive (the response value is above the fitted line) or negative (the
#response value is below the fitted line). Ignore the hat, sigma and cooksd columns for now

#install.packages("broom")
library(broom)

model.res <- augment(mod)
head(model.res) #ignore the other columns for now


#Linear regression makes a number of assumptions about the properties of the residuals, and 
#we will now look at these

## ASSUMPTIONS

#this is the typical four plots that R provides for testing linear regression assumptions

par(mfrow = c(2, 2))
plot(mod)

#we can also call these plots individually, and we will now go through them in this way

dev.off()#first run this to turn off the 4 plots, so the new plots can fill up the whole plotting window (rather than 1/4)

## Assumption 1: the residuals are normally distributed
#You will remember from previous practicals that we have been interested in
#testing whether our residuals are normally distributed (i.e. roughly
#bell-shaped). We can test this using what is called a QQ plot. If our residuals
#(the black points) are normally distributed they should follow the straight
#dashed line. They will rarely follow it perfectly, and we can accept some
#scatter, but you just don't want substantial deviations from the straight line.

plot(mod, 2)

#we could also look at a histogram of the residuals to check for normality

r <- residuals(mod)

hist(r)

#While not perfectly normally distributed, this amount of scatter is OK and we
#can conclude that this assumption has been met

#Finally, we could also use a Shapiro Wilks test of normality

shapiro.test(r)

#QUESTION: does this test indicate the residuals are normally distributed?
#Remember from your previous practicals, that the NULL hypothesis in this test
#is that the data are normally distributed, i.e. we want a non-significant
#P-value = 0.2133, so we can accept the null hypothesis that the residuals are normally distributed


#what can you do if this assumption is not met?
#1. you can try log transforming your response variable. To show you how this is done, for this model
#you would do:
# mod <- lm(log(sales) ~ youtube, data = marketing)
#2. It could be a sign that there are missing predictor variables (e.g. important variables you have not included)
#3. Use an alternative model - you can ignore this option for your own work / assignment


## Assumption 2: Linearity of the relationship
#Linear regression is based on the assumption that there is a linear (not
#surprisingly, given the name!) relationship between the predictor and the
#response. Think about it like this: if the true relationship was U-shaped, then
#fitting a straight line is not going to give a very good fit. Violating this
#assumption is quite severe as it is basically showing you your choice of model
#is wrong, and wont do a good job of explaining or predicting your response
#variable.

#to test this assumption, we can use the residuals vs. fitted plot R returns. To
#meet this assumption we are hoping that the red line is relatively horizontal
#along the dashed line meeting 0 on the y-axis. This is because, usefully, if
#the relationship between x and y is non-linear, the residuals will be a
#non-linear function of the fitted values (and thus the red line will be
#non-linear, e.g., hump or u-shaped).

plot(mod, 1)

#QUESTION: Do you think we are OK with this model according to the plot?
# yes, line is straight (mostly)

#what can you do if this assumption is not met?
#1. you can try (log) transforming your response variable to see if this linearises the relationship (see above)
#2. Add in polynomial terms (e.g. quadratic terms) which fit curved lines
#3. Use alternative models, such as GLMs and non-linear models, which can account for these relationships
#you can ignore 2 and 3 for your own work this year as they are above the pay grade for 1st years!


## Assumption 3: Homogeneity of the residual variance
#The residuals are assumed to have a constant variance - this basically means we
#don't expect to see any patterns in the residuals along our range of fitted
#values. When looking at the plots we are hoping to see what is described as a
#"starry sky", basically a random distribution of points. We can use two of R's
#plots to look at this.

#The first is the same we used to test assumption 2 and shows the values of the
#raw residuals against our fitted values (i.e. the values that make up the
#straight line - see the model fit plot above). We are hoping that the variance
#/ range in the points does not increase or decrease as we go along our fitted
#values (the x-axis). But you will notice that this is not the case here! As we
#move from left to right, the variance (range on the y-axis) increases, such
#that we get a sort of fan or wedge shaped pattern. This shows the model does a
#very good job at small fitted values (i.e. the residuals are small) but a worse
#job at larger fitted values (residuals are larger). This is quite a common
#problem.

plot(mod, 1)

#This assumption can also be checked by examining the scale-location plot (the
#fitted values plotted against standardized residuals). In this, we want to see
#a horizontal line with equally spread points. If the red line has a positive
#slope to it (i.e. is not flat), or if the data points are not randomly spread
#out, the assumption is violated.

plot(mod, 3)

#QUESTION: Can you interpret this plot? Does it match up with our conclusion from the previous plot? Yes, plot has positive slope

#what can you do if this assumption is not met?
#1. you can try (log) transforming your response variable (see above)
#2. It is often a sign that there are missing predictor variables (e.g. important variables you have not included)

#To try the first option (log-transforming the response variable):
mod2 <- lm(log(sales) ~ youtube, data = marketing)
plot(mod2, 3)#we then re-make the plot to see if it has helped - has it?


## Assumption 4: there are no influential outlier points
#An outlier is a data point with an extreme response value (i.e. very different
#to the others). Having outlier data points that are overly influential (e.g.
#having extreme values that drag the regression line towards them) can bias your
#regression coefficient estimates, standard errors and confidence intervals etc.
#This tends to be more of a problem in smaller datasets. To look for influential
#Outliers, we used what is called "Cook's distance" - a measure of the influence
#of each observation on the regression coefficients, measured as the extent of
#change in model estimates when that particular observation is omitted. Any data
#point for which the Cook's distance is greater than 1, or that is substantially
#larger than other Cook's distances (i.e. highly influential data points),
#should be looked at. We can use some of R's plots for this. The first shows us
#the Cook's distance for each point, and provides the data point number for the
#three data points with the highest Cook's values. In our case, we can evidently
#see these 3 points are higher than the others, but the absolute Cook's values
#are all quite low (far below 1) and so we are probably OK.

plot(mod, 4)

#You can also use the residuals vs. leverage plot to look at this. Here, any
#points that have standardised residuals (y-axis) > 3 or < -3 are generally
#considered outliers, and R uses red lines as Cook's distance thresholds to mark
#out points that are likely influential outliers.

plot(mod, 5)

#QUESTION: do we have any points that have standardized residuals marking them out as outliers? No

#what can you do if this assumption is not met?
#You can inspect these points and think about why they are extreme values. Was
#there possibly a measurement error? Either way, you can decide whether to
#remove the points or keep them in based on your own judgment. If you decide to
#remove them, just delete the corresponding rows in your spreadsheet, re-load it
#into R and re-fit your model


##Assumption 5: There is no multicollinearity (in MLR models)
#Our above examples have focused on a simple linear regression model, i.e. where
#we only have one predictor variable. You will remember from last week though,
#that we are often interested in fitting multiple linear regression models,
#where we have more than one predictor. In these cases, we also need to test for
#what is called multicollinearity, i.e. whether our different predictors are
#highly correlated with each other. If this is the case, they can bias the
#parameter estimates for the affected predictors. There are several ways of
#testing this but a simple one is to simply look at the pairwise Pearson's
#correlation (remember this test from one of your previous lectures) between all
#variables. This can be done easily using the cor() function. A rough rule of
#thumb is to use a Pearson's correlation coefficient of 0.7 as a threshold, i.e.
#a value higher than this indicates two variables are highly correlated.

#cor returns a matrix with the Pearson's correlation between all variables in
#the table that you give it. Remember in this case, sales is the response
#variable, and as we are only interested in the collinearity between predictors
#(high collinearity between a predictor and the response is good!), you can
#ignore the sales column/row.

cor(marketing)

#QUESTION: are any of the three variables (youtube, facebook, newspaper) highly correlated? youtube/sales = 0.78, facebook/sales = 0.22, newspaper/sales = 0.22

#You can also plot the pairwise relationships between all variables, which should match up
#with the interpretation of the cor() matrix.

plot(marketing)

#Finally, you can calculate the Tolerance metric discussed in Ian's lectures. But
#for this you need to first fit the model so we will return to it below.

#what can you do if there is multicollinearity?

#If two variables are highly correlated, you will need to pick one to
#remove and exclude from your model. 

##Now, lets look at a multiple linear regression model with youtube,
#facebook and newspaper all added in as predictors.

mod2 <- lm(sales ~., data = marketing)

summary(mod2)

#QUESTION: Can you interpret this model? Do the significant coefficients in this
#model match up with what we would have considered to be important predictors
#based on the Pearson's correlations between each individual predictor and
#'sales', that we generated above.
# youtube and facebook highly significant, newspaper is not

#As a final step, lets calculate the Tolerance statistic to do one final 
#check for multicollinearity. For this, we use the full model object,
#and we need to install a new package to use the correct function

# install.packages("olsrr")
library(olsrr)

ols_vif_tol(mod2)

#In the output ignore the VIF column for now, and just focus on the Tolerance
#column. Remember, Tolerance varies from 0-1, with values below ~0.2 indicating
#issues with multicollinearity.

#QUESTION: do the tolerance values here indicate we have any problems with
#multicollinearity? Does this match with the simple cor() test we used above? Yes, no issues


#  **Well done - you can now tests the assumptions of linear regression in R! Now,  
#work your way through the self-test exercise.**
