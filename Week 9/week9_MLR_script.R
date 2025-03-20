#Ignore
#.libPaths("U:/")

##MULTIPLE LINEAR REGRESSION

#' ---
#' title: "Week9"
#' author: "Tom Matthews"
#' date: "01/09/2022"
#' output: html_document
#' ---
#' 

# WEEK 9: Multiple linear regression

#NB: BEFORE YOU RUN THIS CODE, YOU MUST HAVE:

#  1. Completed the lecture material by Dr Ian Phillips
#  2. Completed the compulsory reading and additional exercises


##Multiple Linear Regression (MLR)
#MLR is an extension of the simple linear regression approach we explored in the
#last week's practical. There we had a response variable (e.g. Crime rate) and a
#single predictor variable (e.g. crime rate ten years ago). However, in many
#real world scenarios we have a number of different predictor variables we
#believe may affect our response variable. This is where MLR is used. It is
#simply an extension of simple linear regression and all of the concepts we went
#over last week still apply, e.g. regression coefficients, p-values, R2 values
#etc.

#lets start by loading in the dataset we will use in today's practical, and
#having a look at it. The dataset is called 'health' and contains the death rate
#per 1000 residents (our response) for a number of different cities, as well as
#a selection of different predictor variables, including:
#* doctor = doctor availability per 100,000 residents
#* hospital = hospital availability per 100,000 residents
#* income = annual per capita income in thousands of dollars
#* popn = population density people per square mile
#* random = a completely random variable (i.e. I just chose a set of random numbers - we expect this to have no effect)

#NB - I have simulated these data, so they don't relate to any real country or
#situation.

dat <- read.csv(file.choose())

head(dat)

str(dat)


#Normally when using multiple predictors in a regression model like this you
#would test for what is called 'multi-collinearity', as MLR does not work well
#if the different predictor variables are highly correlated. But today we will
#ignore this issue - we will look at it next week.


#To fit a MLR, we use the lm() function as we did last week. But whereas before
#we just had our response variable, the tilda (~) and then our predictor
#variable, here we have multiple predictors, separated by the + sign

mod1 <- lm(death_rate ~ doctor + hospital + income + popn + random, data = dat)

#a shortcut, if you are going to use every column (other than the response) as a predictor, is to do

mod2 <- lm(death_rate ~ ., data = dat)

#these will give you the same model. Now we can use the summary() function to
#take a look inside our MLR. The only thing that differs between an MLR and a
#simple linear regression is our interpretation of the regression coefficients
#(remember, these are called 'Estimates' in the summary output table; also
#called the Slopes). Here, the coefficient is the change in the response
#variable given a 1-unit change in that predictor, WHILE HOLDING ALL OTHER
#VARIABLES CONSTANT. This holding other variables constant did not concern us
#last week as we only had the one predictor. Other than that, you can interpret
#it the same.

summary(mod1)

#QUESTION: What is the model summary telling us about which variables might be
#important, and how much of the overall variation is explained by our predictors
#(Hint: remember the interpretation of R2)? doctor, hospital and income are all statistically significant

#REMEMBER: A positive coefficient means that when the predictor increases, the
#response increases and vice versa

#REMEMBER: often the p-values, when they are very small, are given in this form,
#e.g 6.61e-04. This is done when the number is very small and so there are a lot
#of decimal places. For example, 6.61e-04 = 0.000661. If in doubt, use the star
#symbol significance codes next to all significant p-values to help your
#interpretation.

##Interpreting coefficients - a primer
#The regression coefficients are interpreted on the scale of the predictor.
#Remember, the coefficient tells us how much the response changes given a 1 unit
#change in the predictor (holding the other predictors constant). As our
#predictors have different scales / ranges, we need to take this into account
#when interpreting them. For example, a 1 unit change in a predictor that ranges
#from 0-3 will mean a big shift, whereas a 1 unit change in a predictor that
#ranges from 0-10000 is only a small shift. As such, a bigger coefficient value
#does not necessarily mean the variable is more important than one with a smaller
#coefficient value.

##Adjusted R2
#Last week we ignored the adjusted R2 and only looked at the standard (here
#called Multiple) R-squared. However, when you add more predictors to your
#model, the standard R2 always increases, even if the predictor does not really
#improve the model. Adjusted R2 accounts for this. The adjusted R-squared
#increases only if the predictor improves the model more than would be expected
#by chance. It decreases when a predictor improves the model by less than
#expected by chance. Normally, if using MLR you would report the adjusted R2.
#Both values are reported in the model summary output, but you can also extract
#them if you want

s <- summary(mod1)

s #both are reported on the penultimate row

s$r.squared

s$adj.r.squared


##Categorical predictors
#So far all of our predictors have been continuous. You will remember when we
#had a single categorical variable we used ANOVA, implemented using the aov()
#function. As previously mentioned, linear regression and ANOVA are similar
#concepts and in MLR we can actually include both continuous and categorical
#predictors. The categorical variables are treated within the model using the
#ANOVA framework you have learnt about.

#Let us first create a categorical variable for our main dataset to test. You
#don't need to understand how this line of code works, but it is just creating a
#new variable for our dataset called 'party' and then for each city (row in our
#table) it is giving this a letter (A, B or C) which we can interpret as whether
#that city elected party A, B or C as their local government.

dat$party <- sample(LETTERS[1:3], nrow(dat), replace = TRUE)

#Have a look at the dataset and you will see our new variable

head(dat)

#Now if we re-run our MLR we will now get information for this party variable.
#NB. our creation of this variable is random, so each time you do it you will
#get different output in the MLR table (and your output will differ from what I
#present in the example output)


mod4 <- lm(death_rate ~ doctor + hospital + income + 
             popn + random + party,
           data = dat)

summary(mod4)

#You will have noticed that the party variable has two rows in the summary
#output table (partyB and partyC). This is how categorical variables are dealt
#with in MLR. A base level is chosen (here Party A) and then your coefficient
#compares each other level to this base level. So here, our coefficient for
#partyB is telling us how the average death_rate for cities that elected partyB
#differs to those that elected partyA, and then the same for partyC - both are
#compared to partyA

#QUESTION: it is very likely that the p-values for these two terms (partyB and
#partyC) in your output are NOT significant. Does this make sense, given how we
#generated the party variable?

#QUESTION: Now that we have added in the party variable, see that the
#coefficients and p-values for the other terms in the model have changed. Does
#this make sense given the explanation for MLR coefficients given above?

#You can use the anova() function on your model to just get a single p-value for
#your categorical variable. Note that the p-values in this table are based on
#the F-statistic rather than the t-statistic, and so the p-values for you
#continuous variables will also differ from the mod4 summary output.

anova(mod4)


##Parsimony and model selection
#Generally speaking, it is wise to avoid just adding in as many predictors as
#you can. This will lead to overfitting your sample. You instead want to find
#the smallest set of predictors possible that accurately explains your data -
#this is called parsimony. One way of achieving this is by using what is called
#model selection. There are many different model selection techniques, and you
#would have gone over many of these in Ian Phillips' lecture.

#NB - it is important to remember that no model selection technique is a
#substitute for sound scientific logic. Any predictor variable that is to be
#considered should be chosen because the investigator believes there is a
#theoretical reason / hypothesis for how that variable affects the response.

#One simple way of doing it is to use the drop1() and add1() functions to
#manually add and drop variables from your model and look at what happens. For
#these functions, and the step() described below, instead of using the adjusted
#R2 as a measure of model goodness of fit, they use something called AIC
#(Akaike's information criterion). We wont go into this metric in detail here,
#but AIC is just a measure of model fit that penalizes (takes into account) the
#number of parameters / terms / variables in the model. The lower the AIC the
#better the model fits the data (after taking into account the no. of terms).

#If we take our full model (mod4) we can see what happens to the AIC when we drop
#one of the variables, e.g. doctor. To interpret, our full model is on the top
#row and the model AIC is in the right column. The second row then shows us what happens
#when we remove our variable (doctor). We can see the AIC goes up from 36 to 52.

drop1(mod1, "doctor")

#QUESTION: As AIC goes up when we take it out, does this mean doctor is a
#potentially important variable?

#Instead of using drop1() and add1() to drop / add individual terms, we can
#automate the process. Here we will look at one way of doing this using stepwise
#model selection (see your lecture notes for an explanation of stepwise
#selection)

#To run stepwise selection in R, we can use the step() function. step() works by
#adding and removing terms and looking at what happens to the model AIC, and
#then returning to you an "optimal" model.

step(mod1, direction = "both") # direction = both means it does stepwise (rather than backwards selection etc)

#The output is showing us the whole process. At the top we have our full model
#(i.e. mod4) and the model's AIC, and then R shows us what happens when we
#remove each variable (the - sign) from this model and what happens to the AIC.
#You'll see that when some variables are removed the AIC goes down (this is
#good) and others it goes up (this is bad). R then picks the variable from this
#list which causes the largest drop in AIC (in this case: random), removes this
#and then re-fits the model and starts the process again, testing how the AIC
#changes if variables are added and removed. This goes on until nothing can be
#added or removed that improves (lowers) the AIC. This is the model that is
#provided at the bottom.

#QUESTION: what two variables are left in our simplified / optimal model? Does
#this match with the coefficients and p-values you saw in our full model, i.e.
#when we ran summary(mod1) doctor, income (but not hospital)

#N.B., if you store the step function output as an object, it only saves the
#final / optimal model

x <- step(mod1, direction = "both", trace = FALSE) # trace = FALSE stops it printing the full process

x

summary(x) #we can access this like a normal regression model object

#TASK: compare the standard (multiple) and adjusted R2 values of the simplified
#optimal model with that of the full model (summary(mod1)). One increases and
#one decreases. Do you understand why this has happened? Re-read the description
#of adjusted R2 above if not.


####Predicting with MLR
#Finally, lets look at using our MLR model to predict new response variable values,
#given a set of predictor values. This a key part of one of the assessment choices.
#Hopefully you remember from last week that we use the 'predict()' function for this.
#Lets take our stepwise simplified model (x) from above and use this to predict.

#If we look inside x we see it has two predictors: doctor & income.

x

#So, if we want to predict using this model, we need to provide the function
#with some new values for these two variables. We can do this by creating a new
#data frame (table) with these values in. This is the same as last week, but here
#we are creating new values for two predictor variables rather than one.

new_dat <- data.frame("doctor" = c(7, 3), "income" = c(8, 2))
new_dat

#Feeding these new values for doctor and income into our model means our model will
#predict two new values of death rate: one for the situation where a city
#has a doctor value (i.e. number of doctors per 100,000 residents) of 7 and
#an income value (i.e. income per capita in 1000s of dollars) of 8, and then for
#a city that has a doctor value of 3 and an income value of 2.

predict(x, newdata = new_dat)

#We then see that, based on the first set of values, the model predicts a death
#rate of 8.92, and for the second set a higher death rate of 14.69. Given we know
#from our model output that doctor and income are negatively related to death rate,
#do these values make sense to you (answer - they should!). 

#That's all there is to it, but it can be useful to see how that is working by
#looking at how to do it by hand. So, lets use the model (x) with just doctor
#and income in

summary(x)

#We then build the regression equation using our coefficients (Estimates) for
#this model, and for this we also need to use the intercept. Lets use the
#regression equation by hand to predict using our first set of new data
#values (7 for doctor and 8 for income) above:

#get the model coefficients
x$coefficients

#and paste them into the equation: intercept + (doctor * new value) + (income *new value). 
#The Intercept goes first and then we just multiply each predictor variable
#coefficient by the new data value for that predictor

17.9479702 + (-0.7991483 * 7) + (-0.4280801 * 8)

#match this with the predict function (we only predicted the first value here remember)
predict(x, newdata = new_dat)

#Do they match up? Hopefully they do, and this means if you need to do this for your
#assignment but can't get the predict function to work, you can just do it by hand.

#**Well done - you can now run, simplify and interpret a multiple linear
#regression model in R! Now, complete the compulsory work your way through the
#self-test exercise.**

# Next week we will look at testing the assumptions of regression models,
# including MLR, and whether our models meet these assumptions and can be
# trusted!