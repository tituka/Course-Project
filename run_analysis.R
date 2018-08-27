library(dplyr)

## Load data
s_test <- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
s_train <- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
X_train<- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", encoding = "UTF-8")
X_test<- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", encoding = "UTF-8")
y_train<- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", encoding = "UTF-8")
y_test<- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", encoding = "UTF-8")
activity_labels <- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features <- read.table("getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt")  

##Analysis
## 1.Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Use s descriptive activity names to name the activities in the data set
##4. Appropriately labels the data set with descriptive variable names.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Merge training and data set
dataSet<-rbind(X_test, X_train)

#Get only the columns with mean or standard deviation
meanSd <- grep("mean()|std()", features[, 2]) 

#Select only the columsn specified above from the dataSet
dataSet <- dataSet[,meanSd]

#Merge training and test acivities and subject data
activity <- rbind(y_train, y_test)
subject<-rbind(s_test, s_train)

#Add these the to dataSet
dataSet <- cbind(subject, activity, dataSet)

#Add descripive variable names and clear out some iunnecessary characters
names(dataSet) <- append(grep("mean()|std()", features[, 2], value=TRUE), 
                         c("subject", "activity"), after=0)
names(dataSet) <- gsub("\\(|\\)", "", names(dataSet))

#Change characer vectos to factor variables
dataSet$activity <- factor(dataSet$activity, labels = activity_labels$V2)
dataSet$subject <- factor(dataSet$subject)

#Groups data by acivity and subject, so as to provide means summarizes for both
#factor variables
tidyData1 <- dataSet %>%
    group_by(activity) %>%
    summarise_all(funs(mean))

tidyData2 <- dataSet %>%
    group_by(subject) %>%
    summarise_all(funs(mean))

tidyData3 <- dataSet %>%
    group_by(activity, subject) %>%
    summarise_all(funs(mean))

#Appends summary means in the least messy way I can think of:
write.table(tidyData1, "tinydata_better.txt", row.names = FALSE, quote = FALSE,
            col.names = TRUE)
write.table(tidyData2, "tinydata_better.txt",row.names=F,col.names=T,append=TRUE) 

#And this is likelier the answer they want, but it's just such and ugly 
#arrangement of data, I wanted to do something that was cleaner than that
write.table(tidyData3, "tinydata.txt",row.names=F,col.names=T,append=TRUE) 

