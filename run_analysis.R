#getting the data
getdata = function(fileURL) {
        if(!file.exists("./data")){dir.create("./data")}
        
        fileURL = fileURL
        if(!file.exists("./data/dataset.zip")){
                download.file(fileURL, destfile = "./data/dataset.zip")
                unzip("./data/dataset.zip", exdir = "./data")
        }
}

fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
getdata(fileURL)

#'reading and merging relevant data

SubjectTrainDF = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
SubjectTestDF = read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjectDF = rbind(SubjectTrainDF, SubjectTestDF)
names(SubjectDF) = "subject"

ActivityTrainDF = read.table("./data/UCI HAR Dataset/train/Y_train.txt")
ActivityTestDF = read.table("./data/UCI HAR Dataset/test/Y_test.txt")
ActivityDF = rbind(ActivityTrainDF, ActivityTestDF)
names(ActivityDF) = "activity"



FeaturesTrainDF = read.table("./data/UCI HAR Dataset/train/X_train.txt")
FeaturesTestDF = read.table("./data/UCI HAR Dataset/test/X_test.txt")
FeatureNames = read.table("./data/UCI HAR Dataset/features.txt")
FeaturesDF = rbind(FeaturesTrainDF, FeaturesTestDF)
names(FeaturesDF) = FeatureNames$V2



#creating full dataset
SportsData = cbind(SubjectDF, ActivityDF, FeaturesDF)

head(SportsData[,1:10])
tail(SportsData[,1:10])

#mean and sd variables
FeatureNames_meansd = grep("mean\\(\\)|std\\(\\)", FeatureNames$V2, value = TRUE)
SportsData_subset = SportsData[,c("subject", "activity", FeatureNames_meansd)]

#
ActivityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
SportsData_subset$activity = as.factor(SportsData_subset$activity)
SportsData_subset$activity = factor(SportsData_subset$activity, labels = ActivityLabels$V2)

#
names(SportsData_subset)<-gsub("^t", "time", names(SportsData_subset))
names(SportsData_subset)<-gsub("^f", "frequency", names(SportsData_subset))
names(SportsData_subset)<-gsub("Acc", "Accelerometer", names(SportsData_subset))
names(SportsData_subset)<-gsub("Gyro", "Gyroscope", names(SportsData_subset))
names(SportsData_subset)<-gsub("Mag", "Magnitude", names(SportsData_subset))
names(SportsData_subset)<-gsub("BodyBody", "Body", names(SportsData_subset))

#
SportsData2 = aggregate(.~subject + activity, SportsData_subset, mean)
head(SportsData2[,1:10])
