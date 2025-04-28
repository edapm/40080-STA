library(tidyverse)
library(car)
library(mctest)
library(olsrr)

data <- read.csv("data.csv", header=T, sep=",")

mod <- lm(rainfall~., data = data)
mod_step <- step(mod, direction = "both")

summary(mod_step)
plot(mod_step)

hist(mod_step$residuals)
ols_vif_tol(mod_step)
mod_step <- update(mod_step, ~.-w)

summary(mod_step)
