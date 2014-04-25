#R script 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive activity names. 
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Here are the data for the project: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###
library(reshape2) ##run reshape2 package (it is necessary to tide the data later)

##Read column names
col <- read.table("features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))

##Read y_test file
filepath <- file.path("test/y_test.txt")
y_data <- read.table(filepath, header=F, col.names=c("ActivityID"))

##Read subject_test file
filepath <- file.path("test/subject_test.txt")
subject_data <- read.table(filepath, header=F, col.names=c("SubjectID"))

##read X_test file and save it as TestData
filepath <- file.path("test/X_test.txt")
TestData <- read.table(filepath, header=F, col.names=col$MeasureName)

##Name and subset required columns
subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", col$MeasureName)
TestData <- TestData[,subset_data_cols]

##Add data from y_test and subject_test files
TestData$ActivityID <- y_data[,1]
TestData$SubjectID <- subject_data[,1]
rm(subset_data_cols,subject_data,y_data,filepath) ##remove data and values that we don't need any more    


##Repeat for train files
##Read y_train file
filepath <- file.path("train/y_train.txt")
y_data <- read.table(filepath, header=F, col.names=c("ActivityID"))

##Read subject_train file
filepath <- file.path("train/subject_train.txt")
subject_data <- read.table(filepath, header=F, col.names=c("SubjectID"))

##read X_train file and save it as TestData
filepath <- file.path("train/X_train.txt")
TrainData <- read.table(filepath, header=F, col.names=col$MeasureName)

##Name and subset required columns
subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", col$MeasureName)
TrainData <- TrainData[,subset_data_cols]

##Add data from y_train and subject_test diles
TrainData$ActivityID <- y_data[,1]
TrainData$SubjectID <- subject_data[,1]
rm(subset_data_cols,subject_data,y_data,filepath,col) ##remove data and values that we don't need any more 



##Merge TestData and TrainData
data <- rbind(TestData, TrainData)
rm(TestData,TrainData) ##remove data and values that we don't need any more 

##Append new column with activity labels
labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
labels$ActivityName <- as.factor(labels$ActivityName)
data <- merge(data, labels)
rm(labels) ##remove data and values that we don't need any more 


##Using reshape2 package 
##Create tidy data set with the average of each variable for each activity and each subject. 
idvars = c("ActivityID", "ActivityName", "SubjectID")
mvars = setdiff(colnames(data), idvars)
meltdata <- melt(data, id=id_vars, measure.vars=mvars)
data<-dcast(meltdata, ActivityName + SubjectID ~ variable, mean)    

###Fix column names
names <- colnames(data)
names <- gsub("\\.+mean\\.+", names, replacement="Mean")
names <- gsub("\\.+std\\.+",  names, replacement="Std")
colnames(data) <- names


###Save tidy data as tidy_data.txt
write.csv(data, "tidy_data.csv")
rm(meltdata,data,names,idvars,mvars) ##remove data and values that we don't need any more

