# Coursera-Data-Science-Course-3-Assignment
Preparer: Wei Ken Len

## Key files:
### 1. run_analysis.R 
- Script for running the analysis required from the assignment (The script is discussed in further detail at the bottom of this document)

### 2. CodeBook.md
- File that provides overview of the data used & data transformation steps in order to acheive the final outcome

### 3. data_cleaned_final.txt
- Txt file that contains the final outcome of the steps listed in the coure assignment requirements




## Key points about the run_analysis.R (Exerpt from the CodeBook.md) :

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
