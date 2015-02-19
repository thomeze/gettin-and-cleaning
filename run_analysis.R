#We set the Work Directory
setwd("./UCI")

#We load some libraries
library(data.table)
library(dplyr)

#We list the files in the Working Directory
list.files()
options(scipen=999) 

#We read all the files
activityTest <- read.table("./UCI/test/y_test.txt", header = FALSE)
activityTrain <- read.table("./UCI/train/y_train.txt", header = FALSE)
subjectTest <- read.table("./UCI/test/subject_test.txt", header = FALSE)
subjectTrain <- read.table("./UCI/train/subject_train.txt", header = FALSE)
resultsTest <- read.table("./UCI/test/X_test.txt", header = FALSE)
resultsTrain <- read.table("./UCI/train/X_train.txt", header = FALSE)
featuresFile <- read.table("./UCI/features.txt", header = FALSE)
activityLabelFile <- read.table("./UCI/activity_labels.txt", header = FALSE)

# We combine both train and test from the files (result, subject, activity)
combinedResult <- rbind(resultsTest, resultsTrain)
combinedSubject <- rbind(subjectTest, subjectTrain)
combinedActivity <- rbind(activityTest, activityTrain)

# We name the columns and combine subject and activity
names(combinedSubject) <-c("subject")
names(combinedActivity) <- c("activity")
combineSubAct <- cbind(combinedSubject, combinedActivity)

# We name the columns of "combineResult" giving as names "featuredFiles$V2" and we combine it 
names(combinedResult) <- featuresFile$V2
dataCombined <- cbind(combineSubAct, combinedResult)

# We search for the asked pattern
grepData <- featuresFile$V2[grep("mean\\(\\)|std\\(\\)", featuresFile$V2)]
selection <-c(as.character(grepData), "subject", "activity")
dataCombined <- subset(dataCombined, select=selection)

# We clean the columns names and make it more readable
names(dataCombined) <- gsub("\\(\\)", "", names(dataCombined)) 
names(dataCombined) <- gsub("mean", "Mean", names(dataCombined))
names(dataCombined) <- gsub("std", "Std", names(dataCombined)) 
names(dataCombined) <- gsub("-", " ", names(dataCombined)) 
names(dataCombined) <- gsub("Acc", "Accelerometer ", names(dataCombined))
names(dataCombined) <- gsub("Body", "Body ", names(dataCombined))
names(dataCombined) <- gsub("Gravity", "Gravity ", names(dataCombined))
names(dataCombined) <- gsub("Gyro", "Gyro ", names(dataCombined))
names(dataCombined) <- gsub("^t", "time", names(dataCombined))
names(dataCombined) <- gsub("^f", "frequency", names(dataCombined))

# We specify all the other variables no present in the formula and we get the mean
TidyData <-aggregate(. ~subject + activity, dataCombined, mean)

# We order it by subject and activity
TidyData <- TidyData[order(TidyData$subject,TidyData$activity), ]

# We write the result to a file
write.table(TidyData, file = "result_tidy.txt",row.name=FALSE)

#END
