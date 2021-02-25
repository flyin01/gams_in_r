###################################################
### Code for the GAM modelling explanation in R ###
###################################################

### Chapter 1

## 2 Motorcycle crash data: linear approach

# -Use the head() and plot() functions to look at the data frame named mcycle.
# -Use the lm() function to fit a model to the mcycle data where the accel variable is a linear function of times.
# -Visualize the model fit using the provided call to termplot().

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


## 3-4 Motorcycle crash data: non-linear approach

# fit a non-linear model to the same mcycle data using the gam() function from the mgcv package.

# -Load the mgcv package.
# -Fit a model to the mcycle data where accel has a smooth, nonlinear relation to times using the gam() function.
# -Visualize the model fit using the provided call to plot().

mcycle <- MASS::mcycle

# Load mgcv
library(mgcv)
library(nlme)

# Fit the model
gam_mod <- gam(accel ~ s(times), data = mcycle)

# Plot the results
plot(gam_mod, residuals = TRUE, pch = 1)

# GAMs are made up of basis functions that together compose the smooth terms in models. The coef() function extracts the coefficients of these 
# basis functions the GAM model object.
coef(gam_mod)

# The smooth is made up of 9 basis functions, each with their own coefficient. A GAM with just two variables can have many coefficients, which 
# means they require a bit more data than linear models.

# GAMs are powerful because of their ability to take on many shapes, but this is also what makes them challenging. Their flexibility makes it 
# easy to over-fit your data. Here we'll learn how smoothing helps us deal with this issue.

# How well the GAM captures patterns in the data is measured by a term called likelihood. Its complexity, or how much the curve changes shape, 
# is measured by wiggliness. The key to a good fit is the trade-off between the two. This trade-off is expressed by this simple equation, with 
# a smoothing parameter, or lambda value, controlling the balance. This smoothing parameter is optimized when R fits a GAM to data:
# Fit = Likelihood - lambda * Wiggliness

## 5 Basis function and smoothing

# Setting a fixed smoothing parameter

# Quasi code dont run!
 gam(y ~ s(x), data = dat, sp = 0.1)
 gam(y ~ s(x, sp = 0.1), data = dat)
# Smoothing via restricted maximum likelihood
 gam(y ~ s(x), data = dat, method = "REML")
# End of Quasi code

# Normally when we fit a model with mgcv's gam() function, we let the package do the work of selecting a smoothing parameter. However, we can fix 
 # the smoothing parameter to a value of our choosing via the sp argument. The sp argument can be set for the whole model via an argument to the gam() 
 # function, as in the first line of code. We can also set the sp argument for a specific term in the GAM formula, as shown in the second line of code.
 
 # Instead if we allow R to do this work for us, the mgcv package offers several different methods for selecting smoothing parameters. I, and most 
 # GAM experts, strongly recommend that you fit models with the REML, or "Restricted Maximum Likelihood" method. While different methods have their 
 # advantages, REML is most likely to give you reliable, stable results.


## 6 Setting number of basis functions

# Quasi code dont run! 
 gam(y ~ s(x, k = 3), data = dat, method = "REML")
 
 gam(y ~ s(x, k = 10), data = dat, method = "REML")
 Use the defaults
 
 gam(y ~ s(x), data = dat, method = "REML")
# End of Quasi code

# The number of basis functions in a smooth has a great impact on the shapes a model can take. Here, you’ll practice modifying the number of basis functions in a model and examining the results.
 
# -Fit a GAM with 3 basis functions to the mcycle data, with accel as a smooth function of times.
# -Fit the same GAM again, but this time with 20 basis functions.
# -Use the provided plot() functions to visualize both models.
 
mcycle <- MASS::mcycle
 
library(mgcv)
 
# Fit a GAM with 3 basis functions
gam_mod_k3 <- gam(accel ~ s(times, k = 3), data = mcycle)
 
# Fit with 20 basis functions
gam_mod_k20 <- gam(accel ~ s(times, k = 20), data = mcycle)
 
# Visualize the GAMs
par(mfrow = c(1, 2))
plot(gam_mod_k3, residuals = TRUE, pch = 1)
plot(gam_mod_k20, residuals = TRUE, pch = 1)

# One is underfit and the other is overfit

#....continue from here
