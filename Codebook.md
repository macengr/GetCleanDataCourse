CodeBook for Getting and Cleaning Data

tidyData file - Source of Data

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Information
Activity - each subject did each of the following  wearing a smartphone (Samsung Galaxy S II) on the waist.
WALKING
WALKING UPSTAIRS
WALKING DOWNSTAIRS
SITTING
STANDING
LYING)

The second Column, subject, is for each of the 30 participants

The rest of the columns in the dataset are the means of various orientations
as the subject performed the above activities.

Transformation details

There were five steps to the solution.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How run_analysis.R implements the above steps:

readme.md is the file that exlains the steps taken to tidy the data.  It was
created in tinn-R and also contains the code used.

run_analysis.R is the same, but since the hashtag is in front
of all non-code statements, it will function as the script as well.