summarize_columns <- function(df) {
  
  result <- do.call(rbind, lapply(names(df), function(name) {
    
    col <- df[[name]]
    
    if (is.numeric(col)) {
      data.frame(
        Column = name,
        Type = "Numeric",
        Mean = mean(col, na.rm = TRUE),
        Median = median(col, na.rm = TRUE),
        SD = sd(col, na.rm = TRUE),
        Min = min(col, na.rm = TRUE),
        Max = max(col, na.rm = TRUE),
        Unique = NA,
        Mode = NA
      )
    } else {
      data.frame(
        Column = name,
        Type = "Categorical",
        Mean = NA,
        Median = NA,
        SD = NA,
        Min = NA,
        Max = NA,
        Unique = length(unique(col)),
        Mode = names(sort(table(col), decreasing = TRUE))[1]
      )
    }
    
  }))
  
  return(result)
}

# Example usage
df <- data.frame(
  Age = c(21, 22, 23, 24, NA),
  Salary = c(20000, 25000, 30000, 35000, 40000),
  Gender = c("M", "F", "M", "F", "M")
)

summarize_columns(df)

