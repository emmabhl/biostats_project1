#EMMA: partir du cours de la semaine 4, elle parle de forward et backward selection et AIC
#Je ne suis pas très sure de mes explications avec le AIC

library(MASS)
load("projectData.RData")

#backward
#Model 1 de report
model1 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k +
              attendants_public_worship_per_2k, data =data)
summary(model1) #R^2 adjusted = 0.2619 
stepAIC(model1, direction='both') #we want to add or remove variables to adjust our model
#The model with criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k gives us an
#AIC = 288.53, better to remove attendants_public_worship_per_2k (only result not significant)

#Model 2 de report
model2 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_school_per_10k
              , data =data)
summary(model2) #R^2 adjusted = 0.2638 

#!!!!!!!!!!! j'obtiens pas du tout le même AIC avec AIC(model) qu'avec stepAIC(model) ??????
AIC(model1, model2) #AIC = 405.0494. AIC = 404.0409

#Model 3 de report
model2b <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k +
               attendants_public_worship_per_2k, data =data)
summary(model2b) #R~2 adjusted 0.1767
AIC(model2b) #AIC = 408.5154

#forward
#Model 4 de report
model3 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k, data =data)
summary(model3) #R^2 adjusted = 0.1936
AIC(model3) #AIC = 406.7524

#Model 5 de report
model4 <- lm(formula = criminals_per_100k ~ attendants_public_school_per_10k, data =data)
summary(model4) #R^2 adjusted = 0.1533
AIC(model4) #AIC = 414.2217

model5 <- lm(formula = criminals_per_100k ~ attendants_public_worship_per_2k, data =data)
summary(model5) #R^2 adjusted = -0.0263
AIC(model5) #AIC = 416.3961

model6 <- lm(formula = criminals_per_100k ~ ale_beer_houses_per_100k + attendants_public_worship_per_2k, data =data)
summary(model6) #R^2 adjusted = 0.1767
AIC(model6) #AIC = 408.5154
