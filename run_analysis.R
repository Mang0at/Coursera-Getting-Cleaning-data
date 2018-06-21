## Load Packages ##

library(plyr)

## Set Working Directory, download then unzip dataset ##

setwd("C:/Users/skinl/Documents/Coursera/Getting & Cleaning Data/Week 4")

#filepath <- getwd()
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download.file(url, file.path(filepath, "dataFiles.zip"))
#unzip(zipfile = "dataFiles.zip")

## Update working directory to unzipped filepath ##

setwd("C:/Users/skinl/Documents/Coursera/Getting & Cleaning Data/Week 4/UCI HAR Dataset")

filepath <- getwd()

## 1. Merges the training and the test sets to create one data set. ##

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

## Create data set for X data ##

x_data <- rbind(x_train, x_test)

## Create data set for Y data ##

y_data <- rbind(y_train, y_test)

## Create data set for subject data ##

subject_data <- rbind(subject_train, subject_test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. ##

features <- read.table("features.txt")

## Find columns with mean() or std() in their names ##

mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])

## subset x_data using above columns ##

x_data <- x_data[, mean_and_std]

# Update column names with correct details ##

names(x_data) <- features[mean_and_std, 2]

## 3. Uses descriptive activity names to name the activities in the data set ##

activities <- read.table("activity_labels.txt")

## Update values with activity names ##

y_data[, 1] <- activities[y_data[, 1], 2]

## Update activity column name ''

names(y_data) <- "activity"

## 4. Appropriately labels the data set with descriptive variable names. ##

## Add column name to Subject data ##

names(subject_data) <- "subject"

# Bind all the data in a single data set using column bind ##

all_data <- cbind(x_data, y_data, subject_data)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##

# Tidy up the data set & write to file ##

final_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(final_data, "final_data.txt", row.name=FALSE)
