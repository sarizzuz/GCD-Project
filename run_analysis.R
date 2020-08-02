# Data Project

# load packages
library(dplyr)
library(data.table)
library(plyr)

# Download Data
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/actData.zip", method = "curl")
unzip(zipfile = "./data/actData.zip")

# Tasks:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Reading activity labels and features
actLabel <- fread(input = "UCI HAR Dataset/activity_labels.txt", 
                  col.names = c("category", "activity"))
features <- fread(input = "UCI HAR Dataset/features.txt", col.names = c("index", "features"))

# Reading training dataset, training labels and subject dataset 
X_train <- fread(input ="UCI HAR Dataset/train/X_train.txt")
Y_train <- fread(input = "UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
subject_train <- fread(input = "UCI HAR Dataset/train/subject_train.txt", col.names = c("subject_id"))

# Reading test dataset, test labels and subject dataset 
X_test <- fread(input ="UCI HAR Dataset/test/X_test.txt")
Y_test <- fread(input = "UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))
subject_test <- fread(input = "UCI HAR Dataset/test/subject_test.txt", col.names = c("subject_id"))

# Merge datasets 
X_data <- rbind(X_train, X_test)
colnames(X_data) <- features$features
Y_data <- rbind(Y_train, Y_test)
subject_data <- rbind(subject_train, subject_test)
dataSet <- cbind(subject_data, Y_data, X_data)

# Extract only the measurements on the mean and standard deviation for each 
# measurement.
newDataSet <- select(dataSet, contains("subject"), contains("activity"),
                     contains("mean"), contains("std"), - contains("freq"), - contains("angle"))
                   
# Use descriptive activity names to name the activities in the data set
newDataSet$activity <- factor(newDataSet$activity, labels=tolower(actLabel$activity))

# Appropriately labels the data set with descriptive variable names
setnames(newDataSet, colnames(newDataSet), gsub("\\(\\)", "", colnames(newDataSet)))
setnames(newDataSet, colnames(newDataSet), gsub("-", "_", colnames(newDataSet)))
setnames(newDataSet, colnames(newDataSet), gsub("BodyBody", "Body", colnames(newDataSet)))

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
newDataSet_Summary <- ddply(newDataSet, .(subject_id, activity), numcolwise(mean))
data.table::fwrite(x = newDataSet_Summary, file = "ActivityDataSummary.txt", quote = FALSE)

                   
                   
                   