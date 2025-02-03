## Support Vector Machines
# Supervised learning
# install.packages('e1071')
library(ISLR)
library(e1071)
# Train Test Split
library(caTools)
split <- sample.split(iris$Species, SplitRatio = 0.7)
library(dplyr)
train <- filter(iris, split== T)
test <- filter(iris, split == F)

# Train Model
model <- svm(Species ~ ., data=train) 
summary(model) 
# cost: allowing soft margin(allow some points cross over the margin)
# gamma: (related to non-linear kernel function)
# The smaller the gamma is, the more influence of the support vector


# Prediction
pred.values <- predict(model, test)
table(pred.values, test$Species)


# Tuning parameters in SVM
tune.results <-tune(svm, train.x = train[1:4], train.y = train$Species, kernel='radial', ranges = list(cost=c(0.1, 1, 10), gamma=c(0.5, 1, 2)))
summary(tune.results)
# The current summary shows that cost:1, and gamma:0.5 performs best among given parameter values
# Fine Tune the parameters around the best parameter values from the previous tuning
tune.results <-tune(svm, train.x = train[1:4], train.y = train$Species, kernel='radial', ranges = list(cost=c(0.8, 0.9, 1, 1.1, 1.2), gamma=c(0.3, 0.4 ,0.5, 0.6, 0.7)))
summary(tune.results) # cost: 1.2, gamma: 0.4 //0.03818
# Fine Tune the parameters around the best parameter values from the previous tuning
tune.results <-tune(svm, train.x = train[1:4], train.y = train$Species, kernel='radial', ranges = list(cost=c(1, 1.5, 1.7), gamma=c(0.1, 0.2, 0.5)))
summary(tune.results) # cost: 1.5, gamma: 0.1 // 0.01818

# Now that we know the best parameter values, use the tuned parameter
tuned.svm <- svm(Species ~., data = train, kernel ='radial', cost=1.5, gamma=0.1)
summary(tuned.svm)

# Prediction
pred.values <- predict(model, test)
table(pred.values, test$Species)


