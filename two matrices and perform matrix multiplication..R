# Create first matrix (2 x 3)
A <- matrix(c(7, 2,
              9, 4,
              12, 13),
            nrow = 2,
            ncol = 3)

# Display first matrix
cat("Matrix A:\n")
print(A)

# Create second matrix (3 x 4)
B <- matrix(c(1, 2, 3,
              7, 8, 9,
              12, 13, 14,
              19, 20, 21),
            nrow = 3,
            ncol = 4)

# Display second matrix
cat("\nMatrix B:\n")
print(B)

# Matrix Multiplication
C <- A %*% B

# Display result
cat("\nResult of A %*% B:\n")
print(C)