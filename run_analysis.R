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

## Cleaning the data

# Step 1. Merges the training and the test sets to create one data set.

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Step 3. Uses descriptive activity names to name the activities in the data set

# Step 4. Appropriately labels the data set with descriptive variable names.

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
