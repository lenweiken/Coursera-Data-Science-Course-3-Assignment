---
title: "CodeBook"
author: "Wei Ken Len"
date: "6/28/2020"
output: pdf_document
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

### 3. 1 Guide to create the tidy data file

#### 3.1.1. Initial Setup  
- Download data into local R project folder from: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
- Unzip folder in R via *unzip* command
- Load requried libraries (dplyr)
- Load the features data into R via *read.table* command ("features.txt")
- **Data output** = "features_total"

#### 3.1.2. Consolidating "X" datasets  
- **File inputs** = "x_train.txt" & "x_test.txt"
- Load the x datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "x_compiled"

#### 3.1.3. Consolidating "Y" datasets  

- **File inputs** = "y_train.txt" & "y_test.txt"
- Load the y datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "y_compiled"

#### 3.1.4. Consolidating "subject" datasets  

- **File inputs** = "subject_train.txt" & "subject_test.txt"
- Load the subject datasets into R via *read.table* command (see inputs)
- Consolidate test and train data via *rbind* command
- Added column names  
- **Data output** = "subject_compiled"

#### 3.1.5. Consolidating "subject", "x" and "y" datasets : Course assignment #1 - Merges the training and the test sets to create one data set.  

- **Data inputs** = "x_compiled" & "y_compiled" & "subject_compiled"
- Consolidate data from #2 - #4 via *cbind* command  
- **Data output** = "merged_subject_x_y"

#### 3.1.6. Extract columns with "mean" and "std" : Course assignment #2 - Extracts only the measurements on the mean and standard deviation for each measurement.  

- **Data input** = "merged_subject_x_y"
- Extract using *select* and*contains* commands  
- **Data output** = "merged_extracted"

#### 3.1.7. Load activity labels  

- **File input** = "activity_labels.txt"
- Load "activity_labels" data into R via *read.table* command (activity_labels.txt)  
- **Data output** = "activity_labels"

#### 3.1.7. Added activity labels to main data ("merged_extracted") : Course assignment #3 - Uses descriptive activity names to name the activities in the data set.  

- **Data input** = "merged_extracted" & "activity_labels"
- Merge both data using *merge* command by the activity code  
- **Data output** = "merged_extracted_activityname"

#### 3.1.8. Cleaned column names to make it descriptive : Course assignment #4 - Appropriately labels the data set with descriptive variable names.  

- **Data input** = "merged_extracted_activityname"
- Converted shorthand terminology in variable names into full description (e.g., freq = frequency ; t = time) via the *gsub* command  
- **Data output** = "merged_extracted_activityname"

#### 3.1.9. Create a table grouped by both activity and subejct  

- **Data input** = "merged_extracted_activityname"
- Create "grouped" data via the *group_by* command  
- **Data output** = "data_groupby"

#### 3.1.10. Create a table with averages grouped by both activity and subject : Course assignment #5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

- **Data input** = "data_groupby"
- Create averages for all variable measured columns via the *summarise_all* and *list* commands
- **Data output** = "data_cleaned_final"

#### 3.1.11. Create a txt file with the final output  

- **Data input** = "data_cleaned_final"
- Create txt table file via the *write.table* command
- **File output** = "data_cleaned_final.txt"

## 4. Description of the variables in the "data_cleaned_final" data frame

These signals were used to estimate variables of the feature vector for each pattern  
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


### 4.1 Table columns  
Column 1 = Activity name  
Column 2 = Subject ID  
Column 3 = Activity ID (Ties with column 1)  
Column 4:89 = Averaged measurement (by subject and activity) for each column. Each column represents a combination of:  
(i) Measured "variables" (e.g.mean, standard deviation)  
(ii) "feature vector" (e.g, TimeBodyAccelerometer)  
(iii) "axis signal" (e.g., X , Y or Z)


Below is a summary of the columns within the data frame (data_cleaned_final)

 [1] "Activity"                                                "Subject_ID"                                             
 [3] "Activity_ID"                                             "TimeBodyAccelerometer.Mean...X"                         
 [5] "TimeBodyAccelerometer.Mean...Y"                          "TimeBodyAccelerometer.Mean...Z"                         
 [7] "TimeGravityAccelerometer.Mean...X"                       "TimeGravityAccelerometer.Mean...Y"                      
 [9] "TimeGravityAccelerometer.Mean...Z"                       "TimeBodyAccelerometerJerk.Mean...X"                     
[11] "TimeBodyAccelerometerJerk.Mean...Y"                      "TimeBodyAccelerometerJerk.Mean...Z"                     
[13] "TimeBodyGyroscope.Mean...X"                              "TimeBodyGyroscope.Mean...Y"                             
[15] "TimeBodyGyroscope.Mean...Z"                              "TimeBodyGyroscopeJerk.Mean...X"                         
[17] "TimeBodyGyroscopeJerk.Mean...Y"                          "TimeBodyGyroscopeJerk.Mean...Z"                         
[19] "TimeBodyAccelerometerMagnitude.Mean.."                   "TimeGravityAccelerometerMagnitude.Mean.."               
[21] "TimeBodyAccelerometerJerkMagnitude.Mean.."               "TimeBodyGyroscopeMagnitude.Mean.."                      
[23] "TimeBodyGyroscopeJerkMagnitude.Mean.."                   "FrequencyBodyAccelerometer.Mean...X"                    
[25] "FrequencyBodyAccelerometer.Mean...Y"                     "FrequencyBodyAccelerometer.Mean...Z"                    
[27] "FrequencyBodyAccelerometer.MeanFrequency...X"            "FrequencyBodyAccelerometer.MeanFrequency...Y"           
[29] "FrequencyBodyAccelerometer.MeanFrequency...Z"            "FrequencyBodyAccelerometerJerk.Mean...X"                
[31] "FrequencyBodyAccelerometerJerk.Mean...Y"                 "FrequencyBodyAccelerometerJerk.Mean...Z"                
[33] "FrequencyBodyAccelerometerJerk.MeanFrequency...X"        "FrequencyBodyAccelerometerJerk.MeanFrequency...Y"       
[35] "FrequencyBodyAccelerometerJerk.MeanFrequency...Z"        "FrequencyBodyGyroscope.Mean...X"                        
[37] "FrequencyBodyGyroscope.Mean...Y"                         "FrequencyBodyGyroscope.Mean...Z"                        
[39] "FrequencyBodyGyroscope.MeanFrequency...X"                "FrequencyBodyGyroscope.MeanFrequency...Y"               
[41] "FrequencyBodyGyroscope.MeanFrequency...Z"                "FrequencyBodyAccelerometerMagnitude.Mean.."             
[43] "FrequencyBodyAccelerometerMagnitude.MeanFrequency.."     "FrequencyBodyAccelerometerJerkMagnitude.Mean.."         
[45] "FrequencyBodyAccelerometerJerkMagnitude.MeanFrequency.." "FrequencyBodyGyroscopeMagnitude.Mean.."                 
[47] "FrequencyBodyGyroscopeMagnitude.MeanFrequency.."         "FrequencyBodyGyroscopeJerkMagnitude.Mean.."             
[49] "FrequencyBodyGyroscopeJerkMagnitude.MeanFrequency.."     "Angle.TimeBodyAccelerometerMean.Gravity."               
[51] "Angle.TimeBodyAccelerometerJerkMean..GravityMean."       "Angle.TimeBodyGyroscopeMean.GravityMean."               
[53] "Angle.TimeBodyGyroscopeJerkMean.GravityMean."            "Angle.X.GravityMean."                                   
[55] "Angle.Y.GravityMean."                                    "Angle.Z.GravityMean."                                   
[57] "TimeBodyAccelerometer.Std...X"                           "TimeBodyAccelerometer.Std...Y"                          
[59] "TimeBodyAccelerometer.Std...Z"                           "TimeGravityAccelerometer.Std...X"                       
[61] "TimeGravityAccelerometer.Std...Y"                        "TimeGravityAccelerometer.Std...Z"                       
[63] "TimeBodyAccelerometerJerk.Std...X"                       "TimeBodyAccelerometerJerk.Std...Y"                      
[65] "TimeBodyAccelerometerJerk.Std...Z"                       "TimeBodyGyroscope.Std...X"                              
[67] "TimeBodyGyroscope.Std...Y"                               "TimeBodyGyroscope.Std...Z"                              
[69] "TimeBodyGyroscopeJerk.Std...X"                           "TimeBodyGyroscopeJerk.Std...Y"                          
[71] "TimeBodyGyroscopeJerk.Std...Z"                           "TimeBodyAccelerometerMagnitude.Std.."                   
[73] "TimeGravityAccelerometerMagnitude.Std.."                 "TimeBodyAccelerometerJerkMagnitude.Std.."               
[75] "TimeBodyGyroscopeMagnitude.Std.."                        "TimeBodyGyroscopeJerkMagnitude.Std.."                   
[77] "FrequencyBodyAccelerometer.Std...X"                      "FrequencyBodyAccelerometer.Std...Y"                     
[79] "FrequencyBodyAccelerometer.Std...Z"                      "FrequencyBodyAccelerometerJerk.Std...X"                 
[81] "FrequencyBodyAccelerometerJerk.Std...Y"                  "FrequencyBodyAccelerometerJerk.Std...Z"                 
[83] "FrequencyBodyGyroscope.Std...X"                          "FrequencyBodyGyroscope.Std...Y"                         
[85] "FrequencyBodyGyroscope.Std...Z"                          "FrequencyBodyAccelerometerMagnitude.Std.."              
[87] "FrequencyBodyAccelerometerJerkMagnitude.Std.."           "FrequencyBodyGyroscopeMagnitude.Std.."                  
[89] "FrequencyBodyGyroscopeJerkMagnitude.Std.."   

## 5. Sources
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## 6. License
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

No responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.