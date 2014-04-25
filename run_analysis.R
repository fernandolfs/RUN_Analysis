#R script 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Here are the data for the project: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Run reshape2 package (it is necessary to tide the data later)
library(reshape2)

##Read column names
col <- read.table("features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))

##Read y_test file
filepath <- file.path("test/y_test.txt")
y <- read.table(filepath, header=F, col.names=c("ActivityID"))

##Read subject_test file
filepath <- file.path("test/subject_test.txt")
subject <- read.table(filepath, header=F, col.names=c("SubjectID"))

##read X_test file and save it as TestData
filepath <- file.path("test/X_test.txt")
TestData <- read.table(filepath, header=F, col.names=col$MeasureName)

##Name and subset required columns
cols <- grep(".*mean\\(\\)|.*std\\(\\)", col$MeasureName)
TestData <- TestData[,cols]

##Add data from y_test and subject_test files
TestData$ActivityID <- y[,1]
TestData$SubjectID <- subject[,1]



##Repeat for train files
##Read y_train file
filepath <- file.path("train/y_train.txt")
y <- read.table(filepath, header=F, col.names=c("ActivityID"))

##Read subject_train file
filepath <- file.path("train/subject_train.txt")
subject <- read.table(filepath, header=F, col.names=c("SubjectID"))

##read X_train file and save it as TestData
filepath <- file.path("train/X_train.txt")
TrainData <- read.table(filepath, header=F, col.names=col$MeasureName)

##Name and subset required columns
cols <- grep(".*mean\\(\\)|.*std\\(\\)", col$MeasureName)
TrainData <- TrainData[,cols]

##Add data from y_train and subject_test diles
TrainData$ActivityID <- y[,1]
TrainData$SubjectID <- subject[,1]



##Merge TestData and TrainData
data <- rbind(TestData, TrainData)

##Append new column with activity labels
labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
labels$ActivityName <- as.factor(labels$ActivityName)
data <- merge(data, labels)


##Using reshape2 package 
##Create tidy data set with the average of each variable for each activity and each subject. 
meltdata <- melt(data, id=c("ActivityID", "ActivityName", "SubjectID"), 
                 measure.vars=setdiff(colnames(data), c("ActivityID", "ActivityName", "SubjectID")))
newdata<-dcast(meltdata, ActivityName + SubjectID ~ variable, mean)    

###Fix column names
colnames(data) <- gsub("\\.+mean\\.+", colnames(data), replacement=".Mean")
colnames(data) <- gsub("\\.+std\\.+",  colnames(data), replacement=".Std")

colnames(newdata) <- gsub("\\.+mean\\.+", colnames(newdata), replacement=".Mean")
colnames(newdata) <- gsub("\\.+std\\.+",  colnames(newdata), replacement=".Std")


###Save tidy data set as tidy_data.txt
write.table(newdata, "tidy_data.txt")
