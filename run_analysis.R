# Course Project - Getting and Cleaning Data
# Scott McWilliams
# February 2015

#The purpose of this project is to demonstrate your ability to collect, work
#with, and clean a data set. The goal is to prepare tidy data that can be used
#for later analysis. You will be graded by your peers on a series of yes/no
#questions related to the project. You will be required to submit: 1) a tidy
#data set as described below, 2) a link to a Github repository with your script
#for performing the analysis, and 3) a code book that describes the variables,
#the data, and any transformations or work that you performed to clean up the
#data called CodeBook.md. You should also include a README.md in the repo with
#your scripts. This repo explains how all of the scripts work and how they
#are connected.  

#One of the most exciting areas in all of data science right now is wearable
#computing - see for example this article . Companies like Fitbit, Nike, and
#Jawbone Up are racing to develop the most advanced algorithms to attract new
#users. The data linked to from the course website represent data collected
#from the accelerometers from the Samsung Galaxy S smartphone. A full
#description is available at the site where the data was obtained: 

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Here are the data for the project: 

#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following. 
#  1.   Merges the training and the test sets to create one data set.
#  2.   Extracts only the measurements on the mean and standard deviation for each
#        measurement. 
#  3.   Uses descriptive activity names to name the activities in the data set
#  4.   Appropriately labels the data set with descriptive variable names. 
#  5.   From the data set in step 4, creates a second, independent tidy data set
#        with the average of each variable for each activity and each subject.

#Good luck!

#Set my working directory - change to yours as necessary
setwd("C:/Users/Scott Mcwilliams/Desktop/Getting and Cleaning Data")

# Data source - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/smartphones.zip", mode="wb")

#trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#Content type 'application/zip' length 62556944 bytes (59.7 Mb)
#opened URL
#downloaded 59.7 Mb

# unzip the file in my working directory, creating new folder called
# UCI HAR Dataset with same subdirectories as zip file.
unzip("./data/smartphones.zip")

#Step 1 - Merges the training and the test sets to create one data set.

# Need the training and test sets, so I can merge them all
subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep="\t")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",sep="")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt",sep="")

subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",sep="\t")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt",sep="")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt",sep="")

# Let's take a look at the dim of each of these
dim(subjTrain)
#[1] 7352    1
dim(xtrain)
#[1] 7352  561
dim(ytrain)
#[1] 7352    1
dim(subjTest)
#[1] 2947    1
dim(xtest)
#[1] 2947  561
dim(ytest)
#[1] 2947    1

#Let's create one data set, based on the diagram here
#https://class.coursera.org/getdata-011/forum/thread?thread_id=181#comment-510

xcombined <- rbind(xtrain, xtest)
dim(xcombined)
#[1] 10299   561                

subjCombined <- rbind(subjTrain, subjTest)
dim(subjCombined)
#[1] 10299     1

ycombined <- rbind(ytrain, ytest)
dim(ycombined)
#[1] 10299     1

#Hey, look - they all have the same number of rows, 10299
#Let's hook them together
allData <- cbind(xcombined, subjCombined, ycombined)
dim(allData)
#[1] 10299   563


#Load the features vector
features <- read.table("./UCI HAR Dataset/features.txt",sep="")
#[1] 561   2

# Just need second column (used View() to check it out
featuresLabels <- as.vector(features$V2)
#This created a character vector
#need to add 2 more labels to make it same size as rows in my combined data set,
#where I added the subject and labels data
addOns <- c("Subject", "Activity")
newLabels <- append(featuresLabels, addOns)

# And there they are at the end
tail(newLabels, 5)
#[1] "angle(X,gravityMean)" "angle(Y,gravityMean)" "angle(Z,gravityMean)"
#[4] "Subject"              "Activity" 

#Just to be sure -
length(newLabels)
#[1] 563

#Combine them with my merged data set
colnames(allData) <- newLabels
head(allData, 5)
#      tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X 
#1     0.2885845         -0.02029417       -0.1329051        -0.9952786       
#2     0.2784188         -0.01641057       -0.1235202        -0.9982453       
# and so on...

#This completes step 1

#Step 2
#Extracts only the measurements on the mean and standard deviation for each
#measurement.

# I have chosen to use the columns that end in mean() as opposed to the ones
# that have mean followed by a letter.  I believe the former are vectors
# combining the x, y, and z scalars.

grep("mean..$", featuresLabels)
[1] 201 214 227 240 253 503 516 529 542

# I have chosen to use the columns that end in std() as opposed to the ones
# that have std followed by a letter.  I believe the former are vectors
# combining the x, y, and z scalars.

grep("std..$", featuresLabels)
[1] 202 215 228 241 254 504 517 530 543

# Let's extract the mean and Std Deviation columns to a new data frame
# and also the columns for Subject and Activity!
meanandstd <- allData[,c(201,214,227,240, 253,53,516,529,542,
                        202, 215, 228, 241, 254, 504, 517, 530, 543,
                        562, 563)]
dim(meanandstd)
#[1] 10299    20
# and there we go

# This completes Step 2

#Step 3- Uses descriptive activity names to name the activities in the data set

#Done, above, when I added the variable names to the top of the columns.
#The TA states that this can be done before Step 2 here -
#https://class.coursera.org/getdata-011/forum/thread?thread_id=212

#This completes Step 3

#Step 4 - Appropriately labels the data set with descriptive variable names.

# Write a function
changeNames2 <- function(x){

for (n in 1:nrow(x)) {

    if(x[n,20] == 1) {
      x[n,20] <- "walking"
    } else if(x[n,20] == 2)  {
      x[n,20] <- "walkingustairs"
    } else if(x[n,20] == 3)  {
      x[n,20] <- "walkingdownstairs"
    } else if(x[n,20] == 4)  {
      x[n,20] <- "sitting"
    } else if(x[n,20] == 5)  {
      x[n,20] <- "standing"
    } else {
      x[n,20] <- "lying"
  }

}
x
}


meanandstd2 <- changeNames2(meanandstd)
View(meanandstd2)

head(meanandstd2$Activity, 5)
[1] "standing" "standing" "standing" "standing" "standing"

#This completes Step 4

#Step 5 - From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.


meanandstd2$Subject <- as.factor(meanandstd2$Subject)
meanandstd2$Activity <- as.factor(meanandstd2$Activity)

tidyData = aggregate(meanandstd2, by=list(Activity = meanandstd2$Activity,
          Subject=meanandstd2$Subject), mean)
# Ignore warnings which are for last two columns (activity and subject
# Speaking of which, we can remove those two columns
tidyData[,21] = NULL
tidyData[,22] = NULL

#And now, write it to a text file for uploading to Github
write.table(tidyData, "tidydata.txt", sep="\t", rowname = "false")

#And there you have it!