---
title: "Getting and Cleaning Data Coursera Project"
author: "Arnel"
date: "11/5/2020"
output: html_document
---
&nbsp;
&nbsp;

# The Dataset
The data was collected from accelerometers of the Samsung Galaxy S smartphone worn by 30 subjects while performing six different activities. The subjects were labeled 1 to 30 and their activities include __walking, walking upstairs, walking downstairs, sitting, standing and laying.__ The subjects were assigned to training data and testing data randomly.
&nbsp;

# The Files
* __subject_train.txt__ and __subject_test.txt__ contains the identifier of subjects in the training and testing groups respectively.
* __Y_train.txt__ and __Y_test.text__ notes the activities of training and testing subjects respectively. Activity codes 1 to 6 correspond to activity labels found in __activity_labels.txt__.  
* __X_train.txt__ and __X_test.txt__ are the different measurements obtained from the smartphone worn by the subjects.
* More information about the experiment and how the data was collected can be found in the __README.txt_ included in the dataset.

# Getting and cleaning the data
The script __run_analysis.R__ contains the codes used to get and clean the data. Briefly the steps include:

1. Download the zip file from the web and unzip it. This is accomplished using the __getdata()__ function which was defined in the the script.

2. Load the data into R and merge the relevant files into data subset such as the subject files for both trainig and testing. Make sure to include labels.

3. Create the full dataset by combining the different subsets using the __cbind()__ function. 

4. Extract only the measurements on the mean and standard deviation for each measurement. Using the __grep()__ function, we look for variables with names that include "mean()" or "std()" and include only those.

5. Rename the measurements into more descriptive labels such as completing "Accelerometer" instead of just "Acc"

6. Using means or averages, summarize the different measurements for each subject and for activity. We use the __aggregate()__ function for this step.  

7. Finally write the tidy data using the __write.table()__ function
&nbsp;

# The Tidy Data
The final data in run_analysis.R is named "UCIData_summary" which was written into file as __TidyData.txt__. The R object UCIDataSummary is a dataframe with 180 rows and 68 columns. The first to columns are the subject identifier and their activities respectively. The remaining columns are mean or standard deviation of different measurements. The 180 rows refers to the different combination of 30 subject and six activities.You can try reading the tidy data using the code  below.

```
data1 = read.table("TidyData.txt", header=TRUE, check.names=FALSE)

#Data dimensions
dim(data1)

#First two columns
unique(data1$subject)
levels(data1$activity)

#The different column names
names(data1)[3:12]

head(data1[,1:6])

```

Consistent with: Wickham, H. (2014). Tidy Data. Journal of Statistical Software, 59(10), 1 - 23. doi:http://dx.doi.org/10.18637/jss.v059.i10,

__TidyData.txt__ or __UCIData_summary__ is a tidy data. Each columns are labelled variables with the first two columns being subject identifiers and activities respectively while the remaining columns are avergage measurements from the different subjects while they conducted different activities. Every row represent one observation. Every subject and activitiy combination is one observational unit and has a corresponding observations in the measurements columns.






