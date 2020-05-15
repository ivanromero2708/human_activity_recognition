# Code Book

## 1. Dataset Authors
Jorge L. Reyes-Ortiz<sup>(1,2)</sup>, Davide Anguita<sup>(1)</sup>, Alessandro Ghio<sup>(1)</sup>, Luca Oneto<sup>(1)</sup> and Xavier Parra<sup>(2)</sup>

(1) Smartlab - Non-Linear Complex Systems Laboratory. DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.
(2) CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

## 2. Experimental Design
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.he experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


## 3. Raw data description
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).These signals can be found in [the path for test data](./data/UCI HAR Dataset/test/Inertial Signals) and [the path for training data](./data/UCI HAR Dataset/training/Inertial Signals) embeeded in the [UCI HAR Dataset](./data/UCI HAR Dataset). These signals are pre-processed for generating the raw data set used for this project as follows: The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The dataset includes the following files:

- "README.txt""

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

## 4. Data Transformations

The run_analysis.R script creates a directory called **data**, download the UCI HAR Dataset and decompressed in the created **data** directory. Then executes the required 5 steps from the assignment.

### 4.1. Loading required packages
This initial section of the script cleans the Global Environment and loads the package **dplyr**

### 4.2. Directory creation and dataset downloading
In case of non-existing, this section creates the data directory and downloads the raw dataset directories in the "human_activity_tracking.zip" file located in the recently created data directory.

### 4.3. Dataframe assignation

```unzip(rawdatafileloc, exdir = "./data")``` decompressed the "human_activity_tracking.zip" to the **UCI HAR Dataset** into the previously created data directory.

```feature_labels <- read.table("./data/UCI HAR Dataset/features.txt")``` reads the features.txt file into a 561 rowns, 2 columns data frame in which the feature labels for the variables. The feature vector includes treated accelerometer and gyroscope 3-axial raw data from Smartphone sensors.

```activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")``` read the activity_labels.txt file into a 6 rows, 2 columns data frame in which numeric classification labels and their activity names are linked.

```x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = feature_labels[[2]])``` read the X_train.txt file into a 7352 rows, 561 columns in which the training set features for subjects and activitys are shown.

```y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))``` read the y_train.txt file into a 7352 rows, 1 column data frame in which the activities for different experimental conditions are shown.

```subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))``` read the subject_train.txt into a 7352 rows, 1 column data frame that shows the subjects for the different experimental train conditions

```x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = feature_labels[[2]])``` read the X_test.txt file into a 2947 rows, 561 columns in which the testing set features for subjects and activitys are shown.

```y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))``` read the y_test.txt file into a 2947 rows, 1 column data frame in which the activities for different experimental conditions are shown.

```subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))``` read the subject_train.txt into a 2947 rows, 1 column data frame that shows the subjects for the different experimental test conditions

### 4.4. Training and test dataset merging

```train_dataset <- cbind(subject_train,y_train, x_train)
test_dataset <- cbind(subject_test,y_test, x_test)``` In first instance, the train "tidy" dataset and the "train" dataset are created by column binding the subject, y and x data frames. These operations creates the train_dataset a data frame with 7352 rows, 563 columns and the test_dataset a data frame with 2947 rows, 563 columns.

```raw_dataset <- rbind(train_dataset,test_dataset)``` The raw data set is a row binding between the train tidy dataset and the test tidy data set. The raw_dataset is a data frame with 10299 rows, 563 columns.

### 4.5. Standard deviation and mean measurement extraction

```mean_stdpositions <- grep("[Mm]ean|[Ss]td", colnames(raw_dataset))``` this line of command extracts the position in which the strings ***mean*** or ***std*** appeared, including capital letters.

```tidydata <- select(raw_dataset, c("subject","activity",all_of(mean_stdpositions)))``` the command selects the column positions according to the mean_std positions vector. The tidydata data frame has 10299 rows and 88 columns.

### 4.6 Descriptive activity name assignation

```tidydata$activity <- activity_labels[tidydata$activity, 2]``` this line of command replace the values in the column "activity" from the tidydata data frame with the values of the second column of the activity labels data frame previously reported.

These next line of commands assign appropiate names for the mean and std features:

```names(tidydata) <- gsub(".", "", names(tidydata), fixed = TRUE)```

```colnames(tidydata) <- gsub("subject","Subject", colnames(tidydata))```

```colnames(tidydata) <- gsub("activity","Activity", colnames(tidydata))```

```colnames(tidydata) <- gsub("^t","Time", colnames(tidydata))```

```colnames(tidydata) <- gsub("^f","Frequency", colnames(tidydata))```

```colnames(tidydata) <- gsub("Acc","Accelerometer", colnames(tidydata))```

```colnames(tidydata) <- gsub("mean","Mean", colnames(tidydata))```

```colnames(tidydata) <- gsub("std","Std", colnames(tidydata))```

```colnames(tidydata) <- gsub("Mag","Magnitude", colnames(tidydata))```

```colnames(tidydata) <- gsub("Gyro","Gyroscope", colnames(tidydata))```

```colnames(tidydata) <- gsub("BodyBody","Body", colnames(tidydata))```

```colnames(tidydata) <- gsub("gravity","Gravity", colnames(tidydata))```

```colnames(tidydata) <- gsub("angle","Angle", colnames(tidydata))```

```colnames(tidydata) <- gsub("tBody","TimeBody", colnames(tidydata))```

```colnames(tidydata) <- gsub("freq","Frequency", colnames(tidydata))```

### 4.7 Creation of an independent tidy dataset for the average of each variable for each activity and each subject

```tidydatastep5 <- tidydata %>% group_by(Subject, Activity) %>%
                 summarize_all(mean)``` The group_by and summarize_all functions are applied to the tidydata data frame to obtain average values for all the 563 variables by activity and by subject, creating the data frame tidydatastep5 with 180 rows and 88 columns. 
                 
```write.table(tidydatastep5, "TidyDataStep5.txt", row.name=FALSE)``` This final line of command write the previously created tidydatastep5 into the archive TidyDataStep5.txt according to specifications exposed in the assignment.