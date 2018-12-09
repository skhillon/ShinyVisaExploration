library(tidyverse)  # Misc tidy data wrapper package.
library(tools)  # Only used for toTitleCase()
library(caret)  # KNN model
library(ggplot2)  # Plotting

# 1 ===== DATA CLEANING =====
load("visa_info.RData")

# Convert all SOC, and Job Title fields to Title Case.
# We leave Employers as all-caps because Company names vary greatly.
visas$SOC_NAME <- toTitleCase(tolower(visas$SOC_NAME))
visas$JOB_TITLE <- toTitleCase(tolower(visas$JOB_TITLE))

# 2 ===== CASE STATUS CLASSIFIER =====

# KNN model to predict categorical Case Status given user input.
# Since KNNs do not continuously "learn" and dimensionality is low, it is a useful choice.
# Source: http://dataaspirant.com/2017/01/09/knn-implementation-r-using-caret-package/

# Functions
encode_numeric <- function(df) {
    df$emp_encoding <- as.numeric(as.factor(df$EMPLOYER_NAME))
    df$soc_encoding <- as.numeric(as.factor(df$SOC_NAME))
    df$job_title_encoding <- as.numeric(as.factor(df$JOB_TITLE))
    df$ft_encoding <- as.numeric(as.factor(df$FULL_TIME_POSITION))
    df$worksite_encoding <- as.numeric(as.factor(df$WORKSITE))
    #df$year_encoding <- as.numeric(df$YEAR)

    return(df)
}

# Setup
num_cases <- length(unique(visas$CASE_STATUS))
set.seed(37)
visa_colnames <- colnames(visas)[3:11]
cluster_eval_cols <- setdiff(visa_colnames, "PREVAILING_WAGE")
visas <- encode_numeric(visas)

# Train-test split
in.train.rows <- createDataPartition(visas$CASE_STATUS, p = 0.7, list = FALSE)
in.train.cols <- union(2, 10:16)
v.train <- visas[in.train.rows, in.train.cols]
v.test <- visas[-in.train.rows, in.train.cols]
v.train$CASE_STATUS <- factor(v.train$CASE_STATUS)

# Build classifier
train_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
classifier <- train(CASE_STATUS ~., data = v.train, method = "knn",
                    trControl = train_control,
                    preProcess = c("center", "scale"),
                    tuneLength = 10)

# External Interface.
predict_case_status <- function(user_df) {
    user_numeric_df <- encode_numeric(user_df)
    predict(classifier, newdata = user_numeric_df)
}

# 3 ===== PREDICTED WAGE REGRESSOR =====
wage_regressor <- lm(PREVAILING_WAGE ~ lon + lat + emp_encoding + soc_encoding
                     + job_title_encoding + ft_encoding + worksite_encoding,
                     data = visas)

# External interface
predict_wage <- function(user_df) {
    user_numeric_df <- encode_numeric(user_df)
    predict(wage_regressor, newdata = user_numeric_df)
}

save.image(file = "visas_and_models.RData")
