# ============================
# Create Data
# ============================

# Data Frame
df <- data.frame(
  A = c(1, 2, 3),
  B = c(4, 5, 6),
  C = c(7, 8, 9)
)

# List
my_list <- list(
  x = 1:5,
  y = 6:10,
  z = 11:15
)

# ============================
# APPLY (Data Frame)
# ============================

# Column-wise sum
col_sum <- apply(df, 2, sum)

# Row-wise mean
row_mean <- apply(df, 1, mean)

# ============================
# LAPLPLY (List + Data Frame)
# ============================

# On list: square values
list_square <- lapply(my_list, function(x) x^2)

# On data frame: column means
df_mean_list <- lapply(df, mean)

# ============================
# SAPPLY (List + Data Frame)
# ============================

# On list: mean (simplified output)
list_mean <- sapply(my_list, mean)

# On data frame: column means
df_mean_vector <- sapply(df, mean)

# ============================
# PRINT OUTPUTS
# ============================

print("Apply - Column Sum:")
print(col_sum)

print("Apply - Row Mean:")
print(row_mean)

print("lapply - List Square:")
print(list_square)

print("lapply - DataFrame Mean (List):")
print(df_mean_list)

print("sapply - List Mean (Vector):")
print(list_mean)

print("sapply - DataFrame Mean (Vector):")
print(df_mean_vector)