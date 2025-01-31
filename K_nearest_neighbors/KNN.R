# KNN
# Choose the number of neighbors K (a hyperparameter).
# Calculate the distance (e.g., Euclidean, Manhattan) between the input and all points in the dataset.
# Select the K nearest neighbors.
# Classification: Assign the most common class among neighbors.
# Regression: Take the average of neighbors' values.
# No training phase; stores all data and computes predictions on demand.
# Non-parametric: Makes no assumptions about data distribution.
# Sensitive to K and distance metric: A small K can lead to noise sensitivity, while a large K may cause over-smoothing.


# Get Data and check missing values
library(ISLR)

any(is.na(Caravan)) # False

# Need to standardize the data due to difference variance among colums

var(Caravan[,1]) # 165.0378
var(Caravan[,2]) # 0.1647078

# Separate target from other attributes
library(dplyr)
target_col <- which(colnames(Caravan) == 'Purchase')
purchase <- Caravan[,target_col]

# Standatdize

standardized.Caravan <- scale(Caravan[,-target_col])
print(var(standardized.Caravan[,1:2]))
#              MOSTYPE    MAANTHUI
# MOSTYPE   1.00000000 -0.03872126
# MAANTHUI -0.03872126  1.00000000 # Diagonal values are the variance
# The variance became 1, meaning standardized

# Train-Test Split
library(caTools)
split <- sample.split(subset_Y, SplitRatio = 0.2)
train.data <- standardized.Caravan[split,]
test.data <- standardized.Caravan[!split,]
train.target <- purchase[split]
test.target <- purchase[!split]

##################
##################
# KNN Model

library(class)
set.seed(101)
predicted.purchase <- knn(train.data, test.data, train.target, k=1)
print(head(predicted.purchase))

# Evaluate
missclass.error <- mean(test.target != predicted.purchase)
print(missclass.error)


######## Choose a K value

predicted.target <- NULL
error.rate <- NULL

for (i in 1:20){
  set.seed(101)
  predicted.target <- knn(train.data, test.data, train.target, k=i)
  error.rate[i] <- mean(test.target != predicted.target)
}
print(error.rate)


######## Visualize K Elbow Method

library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate, k.values)

pl <- ggplot(error.df, aes(x=k.values, y=error.rate)) + geom_point() + geom_line(lty='dotted',color='red') 

print(pl)
