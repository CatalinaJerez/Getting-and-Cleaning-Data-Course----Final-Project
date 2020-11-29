# Getting and Cleaning Data -- Final Project

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Contents

This repo contains 4 following files.

* run_analysis.R - R scrip to perform analysis
* CodeBook.md - document that describes the variables, data, and transformations
* CodeBook.pdf - document that describes the variables, data, and transformations
* Final.TidyData.txt - final data of the assignment

## About this code 

If the data files for this project is not in your working directory, the script will automatically donwnload it to your working directory, then will unzip it.

For creating tidy data, this script uses dplyr and data.table package, if it is not installed in your system, will automaticaly install.
