### Getting the data

## Cleaning Environment
rm(list=ls())

## 1. Loading required packages
library(dplyr)
library(data.table)
library(Hmisc)

## 2. Getting de raw dataset

# Creating directory
if(!file.exists("data")) {
  dir.create("data")
  rawdatafilename <- "human_activity_tracking.zip"
  rawdatafileloc <- paste0("./data/",rawdatafilename)
  rawdataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(rawdataurl, rawdatafileloc, method = "curl")
}
# Decompressing the zip file
unzip(rawdatafileloc, exdir = "./data") 

# 3. Assigning all data frames
feature_labels <- read.table("./data/UCI HAR Dataset/features.txt") # feature labels
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt") #  Links the class labels with their activity name

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = feature_labels[[2]]) # Training set
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c("activity")) # Training labels
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject")) # Training subjects

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = feature_labels[[2]]) # Test set
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c("activity")) # Test labels
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject")) # Training subjects

## Cleaning the data

# Step 1. Merges the training and the test sets to create one data set.
train_dataset <- cbind(subject_train,y_train, x_train)
test_dataset <- cbind(subject_test,y_test, x_test)
raw_dataset <- rbind(train_dataset,test_dataset)

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_stdpositions <- grep("[Mm]ean|[Ss]td", colnames(raw_dataset))
tidydata <- select(raw_dataset, c("subject","activity",all_of(mean_stdpositions)))

# Step 3. Uses descriptive activity names to name the activities in the data set
tidydata$activity <- activity_labels[tidydata$activity, 2]
tidydata <- data.frame(tidydata)

# Step 4. Appropriately labels the data set with descriptive variable names.
# Eliminating points
names(tidydata) <- gsub(".", "", names(tidydata), fixed = TRUE)
colnames(tidydata) <- gsub("subject","Subject", colnames(tidydata))
colnames(tidydata) <- gsub("activity","Activity", colnames(tidydata))
colnames(tidydata) <- gsub("^t","Time", colnames(tidydata))
colnames(tidydata) <- gsub("^f","Frequency", colnames(tidydata))
colnames(tidydata) <- gsub("Acc","Accelerometer", colnames(tidydata))
colnames(tidydata) <- gsub("mean","Mean", colnames(tidydata))
colnames(tidydata) <- gsub("std","Std", colnames(tidydata))
colnames(tidydata) <- gsub("Mag","Magnitude", colnames(tidydata))
colnames(tidydata) <- gsub("Gyro","Gyroscope", colnames(tidydata))
colnames(tidydata) <- gsub("BodyBody","Body", colnames(tidydata))
colnames(tidydata) <- gsub("gravity","Gravity", colnames(tidydata))
colnames(tidydata) <- gsub("angle","Angle", colnames(tidydata))
colnames(tidydata) <- gsub("tBody","TimeBody", colnames(tidydata))
colnames(tidydata) <- gsub("freq","Frequency", colnames(tidydata))
View(names(tidydata))

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydatastep5 <- tidydata %>% group_by(Subject, Activity) %>%
                 summarize_all(mean)
write.table(tidydatastep5, "TidyDataStep5.txt", row.name=FALSE)


