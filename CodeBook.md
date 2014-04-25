Source of the original data: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

CODEBOOK

15- Read column names and save it as "col"
"col" data set counts 561 observations and 2 variables. First column-"MeasureID" is a sequence of numbers from 1 to 561, and second column-"MeasureName" describes names of variables.

18-36 The script reads test files from "test" file located in the working directory ("UCI HAR Dataset" file)
{
18- Set filepath for y_test file ("test/y_test.txt")
19- Read y_test file and save it as "y"
"y" data set counts 2947 observations and 1 variable(ActivityID).

22- Set filepath for subject_test file ("test/subject_test.txt")
23- Read subject_test file and save it as "subject"
"subject" data set counts 2947 observations and 1 variable(SubjectID).

26- Set filepath for subject_test file ("test/X_test.txt")
27- Read subject_test file and save it as "TestData"
"TestData" data set counts  2947 observations and 561 variables("MeasureName" from "col" data set)

30- Select column names with "mean" and "std" suffixes
31- Change "TestData" data set to select only variables with "mean" and "std" suffixes

34-35 Add to "TestData" data set observations from y_test file and subject_test file 
}
TestData has 2947 observations and 68 variables.


41-59 The script reads train files from "train" file located in the working directory ("UCI HAR Dataset" file)
{
41- Set filepath for y_train file ("train/y_train.txt")
42- Read y_train file and save it as "y"
"y" data set counts 7352 observations and 1 variable(ActivityID).

45- Set filepath for subject_train file ("train/subject_train.txt")
46- Read subject_train file and save it as "subject"
"subject" data set counts 7352 observations and 1 variable(SubjectID).

49- Set filepath for subject_train file ("train/X_train.txt")
50- Read subject_train file and save it as "TrainData"
"TrainData" data set counts  7352 observations and 561 variables("MeasureName" from "col" data set)

53- Select column names with "mean" and "std" suffixes
54- Change "TrainData" data set to select only variables with "mean" and "std" suffixes
57-58 Add to "TrainData" data set observations from y_train file and subject_train file 
}
TrainData has 7352 observations and 68 variables


63- Merge TestData and TrainData into "data" data set
66-68 Add new column with activity names from "activity_labels.txt" file

Finally "data" has 10299 observations of 69 variables. Variables have "mean" or "std" suffixes and last 3 columns are "ActivityID", "SubjectID", "ActivityName".


73-75 Create tidy data set with the average of each variable for each activity and each subject.
To create tidy data we use "reshape2" package
{
73-74 Create "meltdata" data set by "melt" function. 
75 Create new tidy data set- "newdata"
}

78-86 Change column names to make data look nicer (both for data and newdata)
change ".mean..." into ".Mean"
change ".std..." into ".Std"

"newdata" is a data set with the average of each variable for each activity and each subject. It has 180 observations of 68 variables. 
First variable is Activity Name arranged in order: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
Second variable is SubjectID-repeating seqence of numbers from 1 to 30 for each Activity Name.
Varaibles 3-68 are: 
tBodyAcc.MeanX; tBodyAcc.MeanY; tBodyAcc.MeanZ; tBodyAcc.StdX; tBodyAcc.StdY; tBodyAcc.StdZ; tGravityAcc.MeanX; tGravityAcc.MeanY; tGravityAcc.MeanZ; tGravityAcc.StdX; tGravityAcc.StdY; tGravityAcc.StdZ; tBodyAccJerk.MeanX; tBodyAccJerk.MeanY; tBodyAccJerk.MeanZ; tBodyAccJerk.StdX; tBodyAccJerk.StdY; tBodyAccJerk.StdZ; tBodyGyro.MeanX; tBodyGyro.MeanY; tBodyGyro.MeanZ; tBodyGyro.StdX; tBodyGyro.StdY; tBodyGyro.StdZ; tBodyGyroJerk.MeanX; tBodyGyroJerk.MeanY; tBodyGyroJerk.MeanZ; tBodyGyroJerk.StdX; tBodyGyroJerk.StdY; tBodyGyroJerk.StdZ; tBodyAccMag.Mean; tBodyAccMag.Std; tGravityAccMag.Mean; tGravityAccMag.Std; tBodyAccJerkMag.Mean; tBodyAccJerkMag.Std; tBodyGyroMag.Mean; tBodyGyroMag.Std; tBodyGyroJerkMag.Mean; tBodyGyroJerkMag.Std; fBodyAcc.MeanX; fBodyAcc.MeanY; fBodyAcc.MeanZ; fBodyAcc.StdX; fBodyAcc.StdY; fBodyAcc.StdZ; fBodyAccJerk.MeanX; fBodyAccJerk.MeanY; fBodyAccJerk.MeanZ; fBodyAccJerk.StdX; fBodyAccJerk.StdY; fBodyAccJerk.StdZ; fBodyGyro.MeanX; fBodyGyro.MeanY; fBodyGyro.MeanZ; fBodyGyro.StdX; fBodyGyro.StdY; fBodyGyro.StdZ; fBodyAccMag.Mean; fBodyAccMag.Std; fBodyBodyAccJerkMag.Mean; fBodyBodyAccJerkMag.Std; fBodyBodyGyroMag.Mean; fBodyBodyGyroMag.Std; fBodyBodyGyroJerkMag.Mean; fBodyBodyGyroJerkMag.Std

86- Save "newdata" as "tidy_data.txt" in the working directory
