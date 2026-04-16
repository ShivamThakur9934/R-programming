# Create initial data frame
df1 <- data.frame(
  name = c("A", "B"),
  age = c(20, 25)
)

# Create another data frame to add rows
df2 <- data.frame(
  name = c("C", "D"),
  age = c(30, 35)
)

# Combine rows using rbind()
df_combined <- rbind(df1, df2)

# Create new columns
salary <- c(5000, 6000, 7000, 8000)
department <- c("HR", "IT", "Finance", "Marketing")

# Combine columns using cbind()
final_df <- cbind(df_combined, salary, department)

# Print final expanded data
print(final_df)

