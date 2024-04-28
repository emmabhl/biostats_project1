#EMMA: partir du cours de la semaine 4, elle parle de forward et backward selection et AIC
#Je ne suis pas très sure de mes explications avec le AIC

library(MASS)
load("projectData.RData")

#backward
model1 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k +
              attendants_public_worship_per_2k, data =data)
summary(model1) #R^2 adjusted = 0.2619 
stepAIC(model1, direction='both') #we want to add or remove variables to adjust our model
#The model with criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k gives us an
#AIC = 288.53, better to remove attendants_public_worship_per_2k (only result not significant)

model2 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k
              , data =data)
summary(model2) #R^2 adjusted = 0.2638 

#!!!!!!!!!!! j'obtiens pas du tout le même AIC avec AIC(model) qu'avec stepAIC(model) ??????
AIC(model1, model2) #AIC = 405.0494. AIC = 404.0409

#forward
model3 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k, data =data)
summary(model3) #R^2 adjusted = 0.1936
AIC(model3) #AIC = 406.7524

model4 <- lm(formula = criminals_per_100k ~ attendants_public_school_per_10k, data =data)
summary(model4) #R^2 adjusted = 0.1533
AIC(model4) #AIC = 414.2217

model5 <- lm(formula = criminals_per_100k ~ attendants_public_worship_per_2k, data =data)
summary(model5) #R^2 adjusted = -0.0263
AIC(model5) #AIC = 416.3961

model6 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_worship_per_2k, data =data)
summary(model6) #R^2 adjusted = 0.1767
AIC(model6) #AIC = 408.5154


# Before accepting a model, we should review its diagnostics. This provides
# insight into how well the model fits, and where any lack of fit comes from.

par(mfrow=c(1,2))
plot(model2, which = 1, col=factor_colors[region_code]) # Mean of the residuals slightly below 0, not perfectly homeoscedastic with 3 points with a high residual : points 23, 24 and 34
plot(model2, which = 2, col=factor_colors[region_code]) # The residuals are approximately normally distributed with a slight long tail on the right and 3 serious under-predictions 
#(same points which impact the homeoscedasticity )
#No major violations of the hypothesis

#Let's study those specific points. Do they belong to a peculiar region ?
# Most of the points of the right long tail including points 23 and 24 belong to the region West Midland (region code 4) which has particular high number of criminals (see EDA), which might not be explained by our model.

# To study influential points
plot(model2, which = 4) # No points with Cook's distance above one
plot(model2, which = 5) #Points whose standardized residuals are larger than 2 or 3 can be considered as ouliers
# Point 24 is the most influential although might not be considered as an outlier






