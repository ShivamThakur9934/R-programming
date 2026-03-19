# Create sample data
data <- rnorm(100)   # 100 random numbers

# Basic Plot
plot(data, 
     main = "Basic plotting with plot()", 
     xlab = "Index", 
     ylab = "Values", 
     col = "blue", 
     pch = 19)

# Histogram
hist(data, 
     main = "Basic plotting with hist()", 
     xlab = "Values", 
     col = "lightgreen", 
     border = "black")