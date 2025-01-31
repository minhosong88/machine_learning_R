# Logistic regression
# For classification
# Linear regression model on binary group is not a good fit.
# sigmoid function to classify between 0 and 1
# z in sigmoid function can be any value so put linear function in z turns linear to logistic
# cut-off point: 0.5
# confusion matrix to evaluate matrix: accuracy(TP+TN), 
library(Amelia)
################# Titanic dataset
df.train <-read.csv('titanic_train.csv')
head(df.train)
str(df.train)
# Check missing information with Amelia package
missmap(df.train, main='Missing Map', col = c('yellow','black'), legend = FALSE)

################### Exploratory Data Analysis
library(ggplot2)
# Survival Status
survived <- ggplot(df.train, aes(Survived)) + geom_bar()
# Number of people by class
class <- ggplot(df.train, aes(Pclass)) + geom_bar(aes(fill = factor(Pclass)))
print(class)

# Number of each gender
sex <- ggplot(df.train, aes(Sex)) + geom_bar(aes(fill=Sex))
print(sex)

# Age distribution
age <- ggplot(df.train, aes(Age)) + geom_histogram(bins=20, alpha=0.5, fill='blue')
print(age)

# sibling status
siblings <- ggplot(df.train, aes(SibSp)) + geom_bar()
print(siblings)

# Fares
fare <- ggplot(df.train, aes(Fare)) + geom_histogram(fill='green',color='black',alpha=0.5)
print(fare)


############### Deal with missing data
# 177 rows out of 891 are too many to comfortably throw away.
# Fill the age by mean age per each class
pl <- ggplot(df.train, aes(Pclass, Age)) +
  geom_boxplot(aes(group=Pclass, fill=factor(Pclass), alpha=0.4)) +
  scale_y_continuous(breaks = seq(min(0), max(80), by=2)) +
  theme_bw()
print(pl)

# Imputation Age function based on class
impute_age <- function(age, class){
  out <- age
  for (i in 1:length(age)){
    if(is.na(age[i])){
      if(class[i] == 1){
        out[i] <- 37
      } else if(class[i] == 2){
        out[i] <- 29
      } else {
        out[i] <- 24
      }
    }else{
      out[i] <- age[i]
    }
  }
  return(out)
}

fixed.ages <- impute_age(df.train$Age, df.train$Pclass)
df.train$Age <- fixed.ages
# Check missing values for validation
missmap(df.train, main='Imputation check', col = c('yellow','black'), legend = F)

################# Feature Engineering
library(dplyr)
# Remove unnecessary data columns
df.train <- select(df.train,-PassengerId, -Name, -Ticket, -Cabin)
head(df.train)

# check the data's discrete or continuous status: reassign the column as factor
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$SibSp <- factor(df.train$SibSp)


################ Modeling
# generalized linear model: family = binomial(link = 'logit') for logistic model
log.model <- glm( Survived ~., family = binomial(link = 'logit'), data=df.train)

summary(log.model)


############### Split data and Make Prediction
library(caTools)
set.seed(101)
split <- sample.split(df.train$Survived, SplitRatio = 0.7)
final.train <- subset(df.train,split == T)
final.test <- subset(df.train,split == F)

final.log.model <- glm(Survived ~. ,family = binomial(link='logit'), data=final.train)

summary(final.log.model)

# Prediction based on split test data

fitted.probabilities <- predict(final.log.model, final.test, type = 'response')
# Since the result returns probability, classification is manual like this
fitted.results <- ifelse(fitted.probabilities > 0.5, 1,0) 
misClassError <- mean(fitted.results != final.test$Survived)
print(1-misClassError) # Accuracy

# Draw Confusion Matrix
table(final.test$Survived, fitted.probabilities>0.5)

#     FALSE TRUE
#   0   140   25
#   1    29   74


############### Prediction
df.test <- read.csv('titanic_test.csv')
log.model <- glm(Survived ~., family = binomial(link = 'logit'), data=df.train,contrasts = list(Parch = "contr.treatment"))
head(df.test)
summary(df.test)
# Summary shows that there is an NA value in Fare column, and 86 Missing values in Age
# Imputate Age
fixed.age.test <- impute_age(df.test$Age, df.test$Pclass)
df.test$Age <- fixed.age.test
df.test <- select(df.test, -PassengerId, -Name, -Ticket, -Cabin)
# Imputate Fare
# Find the NA row 
df.test[is.na(df.test$Fare),] # Pclass 3
pc3 <- df.test[df.test$Pclass == 3,]
mean.fare.p3 <- mean(pc3$Fare, na.rm = T)

df.test$Fare[which(is.na(df.test$Fare))] <- mean.fare.p3
df.test$Pclass <- factor(df.test$Pclass)
# Parch col has a new level that train data does not have, leading to an error: force the level to fit the train data.
df.test$Parch[is.na(df.test$Parch)] <- 0
df.test$Parch <- factor(df.test$Parch, levels = levels(df.train$Parch))
df.test$SibSp <- factor(df.test$SibSp)

df.test$Survived <- NA  # Create an empty column for predictions
df.test$Survived <- factor(df.test$Survived)
missmap(df.test, main='Imputation check',col= c('yellow','black'), legend=F)
# make prediction
Survived.prediction <- predict.glm(log.model, df.test, type = "response")


summary(Survived.prediction)
fitted_prediction <- ifelse(Survived.prediction > 0.5 ,1, 0)

table(fitted_prediction)
prop.table(table(fitted_prediction)) * 100
