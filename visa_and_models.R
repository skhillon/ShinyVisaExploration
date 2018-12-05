library(tools)  # Only used for toTitleCase()
library(class)  # KNN

load("visa_info.RData")

# Convert all SOC, and Job Title fields to Title Case.
# We leave Employers as all-caps because Company names vary greatly.
visas$SOC_NAME <- toTitleCase(tolower(visas$SOC_NAME))
visas$JOB_TITLE <- toTitleCase(tolower(visas$JOB_TITLE))

# KNN model to predict categorical Case Status given user input.
# Since KNNs do not continuously "learn" and dimensionality is low, it is a useful choice.
# Source: https://dzone.com/refcardz/machine-learning-predictive?chapter=9
train_input <- as.matrix(iristrain[,-5])
train_output <- as.vector(iristrain[,5])

predict_case <- function(user_info) {
    knn(train_input, user_info, train_output, k = 5)
}

# Linear regression model for predicted wage.
wage_model <- lm()
