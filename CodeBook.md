# Cleaning and Getting Data course project code book

## Analysis process
The R script, run_analysis.R begins by loading the libraries that are used for this analysis:

1. data.table)
2. dplyr
3. plyr

It then downloads the zip file containing the data, reads in the processed experiment data and performs a number of steps to get it into summary form.

### Steps:
1. The features and activity labels for the dataset are loaded.
2. The training, test and subject datasets are read in and merged into one data frame.
3. The data columns are then given names based on the features.txt file.
4. Columns that hold mean or standard deviation measurements are selected from the dataset, while the other measurement columns are excluded from the rest of the analysis.
5. The activity identifiers are replaced with the activity labels based on the activity_labels.txt file.
6. Invalid characters (() and - in this case) are removed from the column names. Also, duplicate phrase BodyBody in some columns names is replaced with Body.
7. The data is then grouped by subject and activity, and the mean is calculated for every measurement column.
8. The summarized dataset is written to a file, ActivityDataSummary.txt.

## Columns in output file
The columns included in the output file are listed below:

* subject_id - The id of the subject
* activity - The name of the activity 

Followed by feature vectors that represent the average of each variable for each activity and each subject. The detailed description of the different measurement types can be found in the features_info.txt file included in the data zip file.

* tBodyAcc_mean_X
* tBodyAcc_mean_Y
* tBodyAcc_mean_Z
* tGravityAcc_mean_X
* tGravityAcc_mean_Y
* tGravityAcc_mean_Z
* tBodyAccJerk_mean_X
* tBodyAccJerk_mean_Y
* tBodyAccJerk_mean_Z
* tBodyGyro_mean_X
* tBodyGyro_mean_Y
* tBodyGyro_mean_Z
* tBodyGyroJerk_mean_X
* tBodyGyroJerk_mean_Y
* tBodyGyroJerk_mean_Z
* tBodyAccMag_mean
* tGravityAccMag_mean
* tBodyAccJerkMag_mean
* tBodyGyroMag_mean
* tBodyGyroJerkMag_mean
* fBodyAcc_mean_X
* fBodyAcc_mean_Y
* fBodyAcc_mean_Z
* fBodyAccJerk_mean_X
* fBodyAccJerk_mean_Y
* fBodyAccJerk_mean_Z
* fBodyGyro_mean_X
* fBodyGyro_mean_Y
* fBodyGyro_mean_Z
* fBodyAccMag_mean
* fBodyAccJerkMag_mean
* fBodyGyroMag_mean
* fBodyGyroJerkMag_mean
* tBodyAcc_std_X
* tBodyAcc_std_Y
* tBodyAcc_std_Z
* tGravityAcc_std_X
* tGravityAcc_std_Y
* tGravityAcc_std_Z
* tBodyAccJerk_std_X
* tBodyAccJerk_std_Y
* tBodyAccJerk_std_Z
* tBodyGyro_std_X
* tBodyGyro_std_Y
* tBodyGyro_std_Z
* tBodyGyroJerk_std_X
* tBodyGyroJerk_std_Y
* tBodyGyroJerk_std_Z
* tBodyAccMag_std
* tGravityAccMag_std
* tBodyAccJerkMag_std
* tBodyGyroMag_std
* tBodyGyroJerkMag_std
* fBodyAcc_std_X
* fBodyAcc_std_Y
* fBodyAcc_std_Z
* fBodyAccJerk_std_X
* fBodyAccJerk_std_Y
* fBodyAccJerk_std_Z
* fBodyGyro_std_X
* fBodyGyro_std_Y
* fBodyGyro_std_Z
* fBodyAccMag_std
* fBodyAccJerkMag_std
* fBodyGyroMag_std
* fBodyGyroJerkMag_std

## Additional Information

A full description of the data set is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

