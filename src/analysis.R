#load packages
library(tidyverse)
library(randomForest)

#load, tidy, and output data
heart_raw<-read.csv("data/raw_data/Heart.csv")
heart_clean <-select(heart_raw, -X)
heart_clean<-drop_na(heart_clean)
write.csv(heart_clean, "data/clean_data/heart_clean.csv")

#split cohort in two: train and test
train <- sample(1:nrow(heart_clean), nrow(heart_clean)*0.7)
test <- -train

#Train radom forest model
fit <- randomForest(AHD ~ ., data=heart_clean, subset=train, importance =TRUE, keep.forest=TRUE, xtest= heart_clean[test, -ncol(heart_clean)], ytest=heart_clean[test, "AHD"])

saveRDS(fit, "results/random_forest_fit.rds")

print(fit)

plot(fit)

