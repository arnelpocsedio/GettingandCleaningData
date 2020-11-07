##Getting and Cleaning Data Coursera Project
#This script produces a tidy data of the UCI dataset. Please refer to the README and CodeBook files.

#Step 1: Merge the training and the test sets to create one data set.
#Get the data
#. The function below downloads a data from given URL and unzip it.
getdata = function(fileURL) {
        if(!file.exists("./data")){dir.create("./data")}
        
        fileURL = fileURL
        if(!file.exists("./data/dataset.zip")){
                download.file(fileURL, destfile = "./data/dataset.zip")
                unzip("./data/dataset.zip", exdir = "./data")
        }
}

#Running the function
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
getdata(fileURL)

#Reading and merging relevant files
#1. Subject identifiers
SubjectTrainDF = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
SubjectTestDF = read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjectDF = rbind(SubjectTrainDF, SubjectTestDF)
names(SubjectDF) = "subject" #labelling 

#2. Activity identifiers
ActivityTrainDF = read.table("./data/UCI HAR Dataset/train/Y_train.txt")
ActivityTestDF = read.table("./data/UCI HAR Dataset/test/Y_test.txt")
ActivityDF = rbind(ActivityTrainDF, ActivityTestDF)
names(ActivityDF) = "activity"

#.3. The different features or measurements
FeaturesTrainDF = read.table("./data/UCI HAR Dataset/train/X_train.txt")
FeaturesTestDF = read.table("./data/UCI HAR Dataset/test/X_test.txt")
FeatureNames = read.table("./data/UCI HAR Dataset/features.txt")
FeaturesDF = rbind(FeaturesTrainDF, FeaturesTestDF)
names(FeaturesDF) = FeatureNames$V2


#Creating full dataset by merging the three data subsets
UCIData = cbind(SubjectDF, ActivityDF, FeaturesDF)

#data overview
head(UCIData[,1:6])
tail(UCIData[,1:6])

#Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
#Identifying mean and standard deviation measurements
FeatureNames_meansd = grep("mean\\(\\)|std\\(\\)", FeatureNames$V2, value = TRUE)

#Subsetting the relevant measurements only
UCIData_subset = UCIData[,c("subject", "activity", FeatureNames_meansd)]

#Step 3: Use descriptive activity names to name the activities in the data set
#Including activity labels
ActivityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
UCIData_subset$activity = as.factor(UCIData_subset$activity)
UCIData_subset$activity = factor(UCIData_subset$activity, labels = ActivityLabels$V2)

#Step 4: Appropriately label the data set with descriptive variable names.
#Renaming columns to more descriptive labels
names(UCIData_subset)<-gsub("^t", "time", names(UCIData_subset))
names(UCIData_subset)<-gsub("^f", "frequency", names(UCIData_subset))
names(UCIData_subset)<-gsub("Acc", "Accelerometer", names(UCIData_subset))
names(UCIData_subset)<-gsub("Gyro", "Gyroscope", names(UCIData_subset))
names(UCIData_subset)<-gsub("Mag", "Magnitude", names(UCIData_subset))
names(UCIData_subset)<-gsub("BodyBody", "Body", names(UCIData_subset))


#Step 5: From the data set in step 4, create a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
#Averaging the different measurements per subject per activity
UCIData_summary = aggregate(.~subject + activity, UCIData_subset, mean)
head(UCIData_summary[,1:10])

#Writing the tidy data
write.table(UCIData_summary, "TidyData.txt", row.names = FALSE)

