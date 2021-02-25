### Code for the GAM modelling explanation in R ###

## 1 Motorcycle crash data: linear approach

# Use the mycle data as example
mcycle <- MASS::mcycle

# Examine the mcycle data frame
head(mcycle)
plot(mcycle) # non-linear replationship

# Fit a linear model
lm_mod <- lm(accel ~ times, data = mcycle)

# Visualize the model
termplot(lm_mod, partial.resid = TRUE, se = TRUE)

# The model is a bad fit




