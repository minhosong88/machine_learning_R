# Bike Share Demand with Linear Regression
## Explorative Analysis
# Load necessary packages
library(ggplot2)
library(ggthemes)
library(caTools)
library(dplyr)
# Load the data
df <- read.csv('bikeshare.csv')
head(df)
# Target Identification
target <- df$count

# Scatter Plot Count vs.temp
pl <- ggplot(df, aes(x=temp, y=count)) + geom_point(aes(fill=temp,color=temp), alpha=0.3)
print(pl)

# Scatter Plot count vs. datetime
# Convert character to POSIXct
df$datetime <- as.POSIXct(df$datetime)
head(df$datetime)
# temp as a color
pl2 <- ggplot(df,aes(x=datetime, y=count)) + geom_point(aes(color=temp), alpha=0.3) +scale_color_gradient(high = 'red', low='turquoise')
print(pl2)

# Correlation between temp and count
cor.data = cor(df[,c("temp", "count")])
print(cor.data)
#           temp     count
#temp  1.0000000 0.3944536
#count 0.3944536 1.0000000

# Season data with BoxPlot. Y: count, X: Season
pl3 <- ggplot(df, aes(x=factor(season), y=count)) + geom_boxplot(aes(color=factor(season)))

# Growth of count show that the growth is not just due to the season

print(pl3)

############# Feature Engineering ###############
# Create an 'hour' column from datetime
df$hour <- sapply(df$datetime, function(x){format(x, "%H")})
print(head(df))

# Create a scatter plot count vs. hour with color based on temp
# Plotting for working days
pl4 <- ggplot(filter(df, workingday ==1), aes(x=hour, y=count)) + geom_point(position=position_jitter(w=1, h=0),aes(color=temp), alpha=0.5) +
  scale_color_gradientn(colours=c('dark blue','blue','light blue','light green','yellow','orange','red'))

print(pl4)
# Plotting for non-working days
pl5 <- ggplot(filter(df, workingday ==0), aes(x=hour, y=count)) + geom_point(position=position_jitter(w=1, h=0),aes(color=temp), alpha=0.5) +
  scale_color_gradientn(colours=c('dark blue','blue','light blue','light green','yellow','orange','red'))

print(pl5)

################## Model ###################

# Modeling and summary analysis
model <- lm(target ~ temp, data = df )
summary(model)
# Analysis of coefficient:
# Intercept (6.0462): The expected value of the dependent variable when temp = 0. Since temperature is unlikely to be zero, this may not be meaningful.
# temp (9.1705): For every 1-unit increase in temperature, the dependent variable increases by 9.17 on average.
# Std. Error (0.2048): Measures the uncertainty in the coefficient estimate.
# p-value (<2e-16): Very low. temp is highly significant in predicting the outcome.

# If Temperature is 25 degrees, what is the predict value?
# temp: 9.1705 -> 6.0462(intercept) + 25* 9.1705 = 235.3087
temp25<- filter(df, temp >=25, temp < 26)
result <- predict(model, temp25)
print(mean(result))


df$hour <- as.numeric(df$hour)
df_selected <- df %>% select(count, season, holiday, workingday, weather, temp, humidity, windspeed, hour)
model <- lm(count ~ ., data=df_selected)

summary(model)

# Your dataset likely shows recurring seasonal patterns (e.g., bike demand is higher in summer, lower in winter).
# Since OLS treats all variables linearly, it might incorrectly assume that demand increases or decreases due to the season itself, 
# rather than recognizing that demand is generally increasing over time.
# It does not inherently account for cyclic (seasonal) trends or time-based growth.
