# Create vector
v5 <- c(2,1,2,3,1,2,3,4,1,5,5,3,2,3)

# Function to calculate mode
mode_function <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

mode_v5 <- mode_function(v5)
cat("Mode of the vector:", mode_v5, "\n")