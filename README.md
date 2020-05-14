# human_activity_recognition
Getting and Cleaning Data Course Project

Dataset
Human Activity Recognition Using Smartphones

The dataset from the project can be downloaded from the next link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files
CodeBook.md it is a codebook where the variables, data, and transformations are described according to the process of getting and cleaning the raw data.

gettin_cleaning_data.R: it is a script that performs all the stages of the data cleaning process, including the download steps and creation of directories. Following transformation steps are performed according to the project definition:
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata.txt: is the output data file from the previously described process
