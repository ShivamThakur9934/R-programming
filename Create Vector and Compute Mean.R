# Create vector
v1 <- c(12,7,3,4,2,18,2,54,-21,8,-5)

# a) Mean of the vector
mean_v1 <- mean(v1)
cat("Mean of v1:", mean_v1, "\n")

# b) Mean by trimming 3 values from each end
trimmed_mean <- mean(v1, trim = 3/length(v1))
cat("Trimmed Mean (3 values from each end):", trimmed_mean, "\n")

# c) Mean with NA value
v2 <- c(12,7,3,4,2,18,2,54,-21,8,-5, NA)

mean_with_na <- mean(v2, na.rm = TRUE)
cat("Mean with NA removed:", mean_with_na, "\n")
