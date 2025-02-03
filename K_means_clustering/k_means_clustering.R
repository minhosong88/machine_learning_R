# K-Means Clustering
# Unsupervised, Unlabeled data
# Choosing K (one method): elbow method
# compute sum of squared error for some values for k
# when plot k vs.SSE, SSE abruptly slows down its trend(elbow point)
library(ISLR)
library(ggplot2)
print(head(iris))
# plot out a scatter plot to check its distribution
pl <- ggplot(iris, aes(x=Petal.Length, y= Petal.Width, color=Species)) + geom_point(size=4)
print(pl)

# set random seed
set.seed(101)
# Build a cluster: Notice you don't usually have luxury of knowing k values, or labels
irisCluster <- kmeans(iris[,1:4], centers=3,nstart=20)
print(irisCluster)

table(irisCluster$cluster, iris$Species)

# Plotting cluster
library(cluster)
pl2<-clusplot(iris, irisCluster$cluster, color=T, shade=T, labels=0, lines=0)
print(pl2)
