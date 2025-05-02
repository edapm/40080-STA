library(tidyverse)
library(car)
library(mctest)
library(olsrr)
library(tseries)

rm(list=ls())

data <- read.csv("Assessment/data.csv", header=T, sep=",")

# initial stepwise
mod <- lm(rainfall~., data = data)
mod_step <- step(mod, direction = "both")

# summary
summary(mod_step)

# assumptions
plot(mod_step) # diagnostic plots
ols_vif_tol(mod_step) # multicollinearity

# new model (multicollinearity assumption violated)
mod_step_2 <- update(mod_step, ~.-w)

# summary (model #2)
summary(mod_step_2)

# assumptions (model #2)
plot(mod_step_2) # diagnostic plots
ols_vif_tol(mod_step_2) # multicollinearity
hist(mod_step_2$residuals) # normality of residuals
shapiro.test(mod_step_2$residuals) # normality of residuals
plot(mod_step_2$residuals, data$mslp) # homoscedasticity
plot(mod_step_2$residuals, data$brestzon) # homoscedasticity
plot(mod_step_2$residuals, data$naoi) # homoscedasticity
durbinWatsonTest(mod_step_2) # autocorrelation