---
title: "CodeBook"
author: "Wei Ken Len"
date: "6/28/2020"
output:
  html_document:
    df_print: paged
---
## 1. Project Description
Getting & Cleaning Data - Week 4 course project

## 2. Study design and data collection

### 2.1 Summary of original data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For more information on how the data was collected, visit [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

### 2.2 Notes on the original (raw) data 
Original data includes the following files: 
- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## 3. Creating the tidy datafile

### 3.1 Guide to create the tidy data file

#### 1. Initial Setup  
- Download data into local R project folder from: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
- Unzip folder in R via *unzip* command
- Load requried libraries (dplyr)
- Load the features data into R via *read.table* command ("features.txt")
- **Data output** = "features_total"

#### 2. Consolidating "X" datasets  
- **File inputs** = "x_train.txt" & "x_test.txt"
- Load the x datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "x_compiled"

#### 3. Consolidating "Y" datasets  

- **File inputs** = "y_train.txt" & "y_test.txt"
- Load the y datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "y_compiled"

#### 4. Consolidating "subject" datasets  

- **File inputs** = "subject_train.txt" & "subject_test.txt"
- Load the subject datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "subject_compiled"

#### 5. Consolidating "subject", "x" and "y" datasets : Course assignment #1 - Merges the training and the test sets to create one data set.  

- **Data inputs** = "x_compiled" & "y_compiled" & "subject_compiled"
- Consolidate data from #2 - #4 via *cbind* command  
- **Data output** = "merged_subject_x_y"

#### 6. Extract columns with "mean" and "std" : Course assignment #2 - Extracts only the measurements on the mean and standard deviation for each measurement.  

- **Data input** = "merged_subject_x_y"
- Extract using *select* and*contains* commands  
- **Data output** = "merged_extracted"

#### 7. Load activity labels  

- **File input** = "activity_labels.txt"
- Load "activity_labels" data into R via *read.table* command (activity_labels.txt)  
- **Data output** = "activity_labels"

#### 8. Added activity labels to main data ("merged_extracted") : Course assignment #3 - Uses descriptive activity names to name the activities in the data set.  

- **Data input** = "merged_extracted" & "activity_labels"
- Merge both data using *merge* command by the activity id 
- **Data output** = "merged_extracted_activityname"


#### 9. Create a table grouped by both activity and subejct  

- **Data input** = "merged_extracted_activityname"
- Create "grouped" data via the *group_by* command  
- **Data output** = "data_groupby"

#### 10. Create a table with averages grouped by both activity and subject : Course assignment #5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

- **Data input** = "data_groupby"
- Create averages for all variable measured columns via the *summarise_all* and *list* commands
- **Data output** = "data_cleaned_final"

#### 11. Create a txt file with the final output  

- **Data input** = "data_cleaned_final"
- Create txt table file via the *write.table* command
- **File output** = "data_cleaned_final.txt"  

#### Note: Course assignment 4 - Appropriately labels the data set with descriptive variable names is already performed by virtue of step #2 above (Variables are now named)


## 4. Description of the variables in the "data_cleaned_final" data frame

These signals were used to estimate variables of the feature vector for each pattern ()
1. tBodyAcc-XYZ  
2. tGravityAcc-XYZ  
3. tBodyAccJerk-XYZ  
4. tBodyGyro-XYZ  
5. tBodyGyroJerk-XYZ  
6. tBodyAccMag  
7. tGravityAccMag  
8. tBodyAccJerkMag  
9. tBodyGyroMag  
10. tBodyGyroJerkMag  
11. fBodyAcc-XYZ  
12. fBodyAccJerk-XYZ  
13. fBodyGyro-XYZ  
14. fBodyAccMag  
15. fBodyAccJerkMag  
16. fBodyGyroMag  
17. fBodyGyroJerkMag  

where, t = time, f = frequency, Acc = Accelerometer, Gyro = Gyroscope, Mag = Magnitude  
and '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are:  
1. mean(): Mean value  
2. std(): Standard deviation  
3. meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
4. angle(): Angle between two vectors.


### 4.1 Columns & variables  
Column 1 = Activity name  
- 6 values: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying  

Column 2 = Subject ID  
- 30 subjects (1-30) : Numbered subjects who underwent test/train experiment  

Column 3 = Activity ID  
- 6 values (1-6), Ties numerically with column 1 above (i.e., 1 = Walking, 2 = Walking Upstairs, 3 = Walking Downstairs, 4 = Sitting, 5= Standing, 6= Laying  )  

Column 4:89 = Averaged measurement (by subject and activity) for each column. Each column represents a combination of:  
(i) Measured "variables" (e.g.mean, standard deviation)  
(ii) "feature vector" (e.g, TimeBodyAccelerometer, TimeBodyGyroscope, FrequencyBodyAccelerometer, etc)  
(iii) "axis signal" (e.g., X , Y or Z)  
- Values are numerical

Below is a summary of the columns within the data frame (data_cleaned_final)
 [1] "activity"                             "subject_id"                           "activity_id"                         
 [4] "tBodyAcc.mean...X"                    "tBodyAcc.mean...Y"                    "tBodyAcc.mean...Z"                   
 [7] "tGravityAcc.mean...X"                 "tGravityAcc.mean...Y"                 "tGravityAcc.mean...Z"                
[10] "tBodyAccJerk.mean...X"                "tBodyAccJerk.mean...Y"                "tBodyAccJerk.mean...Z"               
[13] "tBodyGyro.mean...X"                   "tBodyGyro.mean...Y"                   "tBodyGyro.mean...Z"                  
[16] "tBodyGyroJerk.mean...X"               "tBodyGyroJerk.mean...Y"               "tBodyGyroJerk.mean...Z"              
[19] "tBodyAccMag.mean.."                   "tGravityAccMag.mean.."                "tBodyAccJerkMag.mean.."              
[22] "tBodyGyroMag.mean.."                  "tBodyGyroJerkMag.mean.."              "fBodyAcc.mean...X"                   
[25] "fBodyAcc.mean...Y"                    "fBodyAcc.mean...Z"                    "fBodyAcc.meanFreq...X"               
[28] "fBodyAcc.meanFreq...Y"                "fBodyAcc.meanFreq...Z"                "fBodyAccJerk.mean...X"               
[31] "fBodyAccJerk.mean...Y"                "fBodyAccJerk.mean...Z"                "fBodyAccJerk.meanFreq...X"           
[34] "fBodyAccJerk.meanFreq...Y"            "fBodyAccJerk.meanFreq...Z"            "fBodyGyro.mean...X"                  
[37] "fBodyGyro.mean...Y"                   "fBodyGyro.mean...Z"                   "fBodyGyro.meanFreq...X"              
[40] "fBodyGyro.meanFreq...Y"               "fBodyGyro.meanFreq...Z"               "fBodyAccMag.mean.."                  
[43] "fBodyAccMag.meanFreq.."               "fBodyBodyAccJerkMag.mean.."           "fBodyBodyAccJerkMag.meanFreq.."      
[46] "fBodyBodyGyroMag.mean.."              "fBodyBodyGyroMag.meanFreq.."          "fBodyBodyGyroJerkMag.mean.."         
[49] "fBodyBodyGyroJerkMag.meanFreq.."      "angle.tBodyAccMean.gravity."          "angle.tBodyAccJerkMean..gravityMean."
[52] "angle.tBodyGyroMean.gravityMean."     "angle.tBodyGyroJerkMean.gravityMean." "angle.X.gravityMean."                
[55] "angle.Y.gravityMean."                 "angle.Z.gravityMean."                 "tBodyAcc.std...X"                    
[58] "tBodyAcc.std...Y"                     "tBodyAcc.std...Z"                     "tGravityAcc.std...X"                 
[61] "tGravityAcc.std...Y"                  "tGravityAcc.std...Z"                  "tBodyAccJerk.std...X"                
[64] "tBodyAccJerk.std...Y"                 "tBodyAccJerk.std...Z"                 "tBodyGyro.std...X"                   
[67] "tBodyGyro.std...Y"                    "tBodyGyro.std...Z"                    "tBodyGyroJerk.std...X"               
[70] "tBodyGyroJerk.std...Y"                "tBodyGyroJerk.std...Z"                "tBodyAccMag.std.."                   
[73] "tGravityAccMag.std.."                 "tBodyAccJerkMag.std.."                "tBodyGyroMag.std.."                  
[76] "tBodyGyroJerkMag.std.."               "fBodyAcc.std...X"                     "fBodyAcc.std...Y"                    
[79] "fBodyAcc.std...Z"                     "fBodyAccJerk.std...X"                 "fBodyAccJerk.std...Y"                
[82] "fBodyAccJerk.std...Z"                 "fBodyGyro.std...X"                    "fBodyGyro.std...Y"                   
[85] "fBodyGyro.std...Z"                    "fBodyAccMag.std.."                    "fBodyBodyAccJerkMag.std.."           
[88] "fBodyBodyGyroMag.std.."               "fBodyBodyGyroJerkMag.std.."   


## 5. Sources
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## 6. License
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

No responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.