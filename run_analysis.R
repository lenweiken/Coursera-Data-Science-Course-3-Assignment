unzip("getdata_projectfiles_UCI HAR Dataset.zip")

library(dplyr)

features_total <- read.table("UCI HAR Dataset/features.txt", col.names = c("no","features"))


x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features_total$features)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features_total$features)
x_compiled <- rbind(x_train, x_test)


y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
y_compiled <- rbind(y_train, y_test)


subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
subject_compiled <- rbind(subject_train, subject_test)


merged_subject_x_y <- cbind(subject_compiled, x_compiled, y_compiled)


merged_extracted <- select(merged_subject_x_y, subject_id, activity_id, contains("mean"), contains("std"))


activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity"))
merged_extracted_activityname <- merge(activity_labels, merged_extracted, by = "activity_id")


names(merged_extracted_activityname)[1] = "Activity_ID"
names(merged_extracted_activityname)[2] = "Activity"
names(merged_extracted_activityname)[3] = "Subject_ID"
names(merged_extracted_activityname) <- gsub("BodyBody", "Body", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("^t", "Time", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("Gyro", "Gyroscope", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("Mag", "Magnitude", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("Acc", "Accelerometer", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("Freq", "Frequency", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("^f", "Frequency", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("angle", "Angle", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("gravity", "Gravity", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("tBody", "TimeBody", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("mean", "Mean", names(merged_extracted_activityname))
names(merged_extracted_activityname) <- gsub("std", "Std", names(merged_extracted_activityname))

data_groupby <- group_by(merged_extracted_activityname, Activity , Subject_ID )
data_cleaned_final <- summarise_all(data_groupby, list(mean))

write.table(data_cleaned_final, "data_cleaned_final.txt", row.name=FALSE)
