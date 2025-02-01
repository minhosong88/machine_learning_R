# Tree methods: decision tree, random forest
library(rpart)
str(kyphosis)
head(kyphosis)
# Decision Tree Model
tree <- rpart(Kyphosis ~., method='class', data = kyphosis)

# printcp: the complexity parameter (CP) table 
# for a classification or regression tree built using the rpart package
printcp(tree)

# Plotting with plot function is not very good
plot(tree, uniform = T, main='Kyphosis Tree')
text(tree, use.n = T, all = T)

# Install rpart plot and utilize it
library(rpart.plot)
# rpart.plot(): plot a rpart model => rpart.plot(x=model, type= plot_typr(1~5), extra ='extra'(default) )
# prp(): different default setting of rpart.plot() // raprt.plot provides more customizable options
prp(tree)
# Using Random Forest
library(randomForest)
rf.model <- randomForest(Kyphosis ~., data=kyphosis)
print(rf.model)
