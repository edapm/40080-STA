library(tidyverse)

data <- read.csv("data.csv", header=T, sep=",")

mod <- lm(rainfall~., data = data)
mod_step <- step(mod, direction = "both")

summary(mod_step)
plot(mod_step)

hist(mod_step$residuals)
