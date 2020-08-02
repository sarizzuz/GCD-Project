# Data Project

# load packages
library(data.table)
library(reshape2)
library(dplyr)

# Download Data
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/actData.zip", method = "curl")
unzip(zipfile = "./data/actData.zip")

# Tasks:
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Load activity labels and features
actLabel <- fread(input = "UCI HAR Dataset/activity_labels.txt", 
                  col.names = c("category", "activity"))
features <- fread(input = "UCI HAR Dataset/features.txt", 
                  col.names = c("index", "featureNames"))

# Read in features and measurements 
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load training set and subset for required measurements 
X_train <- fread(input ="UCI HAR Dataset/train/X_train.txt")[, featuresWanted, with = FALSE]
data.table::setnames(X_train, colnames(X_train), measurements)
Y_train <- fread(input = "UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
subject_train <- fread(input = "UCI HAR Dataset/train/subject_train.txt")
trainSet <- cbind(subject_train, Y_train, X_train)

# Load test set and subset for required measurements 
X_test <- fread(input ="UCI HAR Dataset/test/X_test.txt")[, featuresWanted, with = FALSE]
data.table::setnames(X_test, colnames(X_test), measurements)
Y_test <- fread(input = "UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))
subject_test <- fread(input = "UCI HAR Dataset/test/subject_test.txt")
testSet <- cbind(subject_test, Y_test, X_test)

# Merge the training and the test sets to create one data set, with only 
# the measurements on the mean and standard deviation for each.
dataSet <- rbind(trainSet, testSet)

# Convert classLabels to activityName basically. More explicit. 
combined[["Activity"]] <- factor(combined[, Activity]
                                 , levels = actLabels[["category"]]
                                 , labels = actLabels[["activity"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)





