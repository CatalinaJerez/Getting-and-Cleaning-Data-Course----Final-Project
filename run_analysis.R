## ----setup, include=FALSE-------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'asis')


## -------------------------------------------------------------------------------------
# Install and load required packages
if (!require('dplyr'))      {install.packages('dplyr')}
if (!require('data.table')) {install.packages('data.table')}

library(dplyr)
library(data.table)


## -------------------------------------------------------------------------------------
# name for zip file
file.zip <- 'GCD_Final.zip' 

# Cheking if zip file exists
if (!file.exists(file.zip)){
 file.URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles...
 %2FUCI%20HAR%20Dataset.zip'
 download.file(file.URL, file.zip, method = 'curl')} 

# Checking if study folder exists
if (!file.exists("UCI HAR Dataset")) {unzip(file.zip)}


## -------------------------------------------------------------------------------------
# In the folder UCI HAR Dataset
act.lab   <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features  <- read.table("UCI HAR Dataset/features.txt",        col.names = c("n","functions"))

# In the sub-folder test of UCI HAR Dataset
subj.test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x.test    <- read.table("UCI HAR Dataset/test/X_test.txt",       col.names = features$functions)
y.test    <- read.table("UCI HAR Dataset/test/y_test.txt",       col.names = "code")

# In the sub-folder train of UCI HAR Dataset
subj.train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x.train    <- read.table("UCI HAR Dataset/train/X_train.txt",       col.names = features$functions)
y.train    <- read.table("UCI HAR Dataset/train/y_train.txt",       col.names = "code")


## -------------------------------------------------------------------------------------
# We use the functions rbind & cbind

subj.data <- rbind(subj.train, subj.test)
x.data    <- rbind(x.train, x.test)
y.data    <- rbind(y.train, y.test)
merge.data<- cbind(subj.data, x.data, y.data)

#str(merge.data)
#head(merge.data)


## -------------------------------------------------------------------------------------
# We use select function and save the data like TidyData
# Also select the code of each subject (we use for the next part).

TidyData <- merge.data %>% select(subject, code, contains('mean'), contains('std'))
#head(TidyData)


## -------------------------------------------------------------------------------------
# The code of each subject is a number, we change for the activities who represent the number. 
TidyData$code[1:50] # example
print(act.lab[,2])

TidyData$code <- act.lab[TidyData$code, 2]


## -------------------------------------------------------------------------------------
names(TidyData)

names(TidyData)[2] = 'Activity'

names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body",     names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope",    names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude",     names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity",   names(TidyData))
names(TidyData) <- gsub("angle", "Angle",       names(TidyData))
names(TidyData) <- gsub("^t", "Time",           names(TidyData))
names(TidyData) <- gsub("^f", "Frequency",      names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody",    names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean",      names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD",        names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)

#head(TidyData)
names(TidyData)


## -------------------------------------------------------------------------------------
Final.TidyData <- TidyData %>%
    group_by(subject, Activity) %>%
    summarise_all(funs(mean))

# Export the final data
write.table(Final.TidyData, "Final.TidyData.txt", row.name = FALSE)

# Cheking the data

str(Final.TidyData)
head(Final.TidyData)



## -------------------------------------------------------------------------------------
knitr::purl('CodeBook.Rmd')

# By default its create a code whit the same name of CodeBook, in the folder you can change. 

