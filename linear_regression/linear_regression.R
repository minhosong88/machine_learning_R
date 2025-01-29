# Student performance data
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
# Since the data is separated by ';' , use sep argument
df <- read.csv('student-mat.csv', sep = ';')
head(df)
summary(df)
# Checking if there is any NA value
any(is.na(df)) # False

# Fedu, Medu are the parental education level
# supposedly factor not int like in the current data

############# EXPLORATORY DATA ANALYSIS ###############
# Grab only numeric columns
num.cols <- sapply(df, is.numeric) # Notice no args in the func

# Filter : identify correlation between each column
cor.data = cor(df[, num.cols])
print(cor.data)
# Using corr plot to display correlation heatmap
print(corrplot(cor.data, method = "color"))
# corr plot requires numeric only column (user needs to filter first)

# corr gram directly uses data frame
corrgram(df)
# upper panel becomes pie charts shows how correlated they are
corrgram(df,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

ggplot(df, aes(x =G3)) +geom_histogram(bins=20, alpha=0.5, fill = 'blue')


############# Linear Regression Model ###############

# Split Data into Train and Test Set
library(caTools)
# Set A Seed (Random seed)
set.seed(101)
# Split up sample(Choose Prediction variable(y) for split)
sample <- sample.split(df$G3,SplitRatio = 0.7)
# 70% of data: Train
train <- subset(df, sample == TRUE)
# 30% of data: Test
test <- subset(df, sample == FALSE)

# General Model of Building a Linear Regression Model in R
# model <- lm(y ~ x1 + x2, data) y: predict, x1, x2 are features used for the model
# model <- lm(y ~., data) use all features

# Train and Build Model
model <- lm(G3 ~., train) # using all features

# Summary of the model
print(summary(model))

# You want residual to look more normal distribution
# Estimate:  value of slope   
# Std. Error: Measure of the variability,  Lower means better but this number is relative to the value of the coefficient.
# t value : won't use this value itself, it is used to calculate the p-value
# Pr(>|t|) : Probability the variable is NOT relevant. as small as possible. 
# Significance Legend: Blank=bad, Dots=pretty good, Stars=good, More Stars=very good
# R-squared: Metric for evaluating the goodness of fit of your model.Higher is better with 1 being the best.
# Warning: correlation does not always imply causation.


# Plot Residual
res <- residuals(model)
res <- as.data.frame(res)
head(res)

# ggplot
ggplot(res, aes(res)) + geom_histogram(fill='blue', alpha=0.5)


################### Prediction ######################
# model knows what y is, and is trained on train data
G3.predictions <- predict(model, test)

results <-cbind(G3.predictions, test$G3)
colnames(results) <- c('predicted','actual')
results <- as.data.frame(results)
print(head(results))

# Take care of negative values (since 0 is the lowest score students can get)
to_zero <- function(x) {
  if (x < 0){
    return (0)
  } else {
    return(x)
  }
}

# Apply Zero Function
results$predicted <-sapply(results$predicted, to_zero)

# Mean Squared Error (Measure How far your prediction is away from the actual value)
mse <- mean((results$actual - results$predicted)^2 )
print('MSE')
print(mse)
print('SQRT of MSE')
print(mse^0.5)

##########

SSE <- sum((results$predicted - results$actual)^2 )
SST <- sum ( ( mean( df$G3 ) - results$actual )^2 )
R2 <- 1 - SSE/SST
print('R2')
print(R2)