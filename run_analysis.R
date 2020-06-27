# 1. Initial Setup  
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
library(dplyr)
features_total <- read.table("UCI HAR Dataset/features.txt", col.names = c("no","features"))

#2. Consolidating "X" dataset
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features_total$features)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features_total$features)
x_compiled <- rbind(x_train, x_test)

#3. Consolidating "Y" datasets 
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
y_compiled <- rbind(y_train, y_test)


#4. Consolidating "subject" datasets  
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
subject_compiled <- rbind(subject_train, subject_test)

#5. Consolidating "subject", "x" and "y" datasets : Course assignment #1 - Merges the training and the test sets to create one data set.  
merged_subject_x_y <- cbind(subject_compiled, x_compiled, y_compiled)

#6. Extract columns with "mean" and "std" : Course assignment #2 - Extracts only the measurements on the mean and standard deviation for each measurement.
merged_extracted <- select(merged_subject_x_y, subject_id, activity_id, contains("mean"), contains("std"))

#7. Load activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity"))

#8. Added activity labels to main data ("merged_extracted") : Course assignment #3 - Uses descriptive activity names to name the activities in the data set.
merged_extracted_activityname <- merge(activity_labels, merged_extracted, by = "activity_id")

#9. Create a table grouped by both activity and subejct
data_groupby <- group_by(merged_extracted_activityname, activity , subject_id)

#10. Create a table with averages grouped by both activity and subject : Course assignment #5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_cleaned_final <- summarise_all(data_groupby, list(mean))

#11. Create a txt file with the final output
write.table(data_cleaned_final, "data_cleaned_final.txt", row.name=FALSE)

#Note: Course assignment 4 - Appropriately labels the data set with descriptive variable names is already performed by virtue of step #2 above



