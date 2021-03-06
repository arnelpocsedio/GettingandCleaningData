---
title: "Getting and Cleaning Data Coursera Project"
author: "Arnel"
date: "11/5/2020"
output: html_document
---
&nbsp;
&nbsp;


The goal of this project is to prepare a tidy dataset from a wearable computing data collection. The data can be accessed from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and more information can be found in:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

&nbsp;
&nbsp;

In this repository you will find:

1. __CodeBook.md__ which describes the variables and data, including data processing conducted

2.  __run_analysis.R__ which is the script used to download (i.e. __GETTING__), merge, label, filter and summarize, that is getting the mean, (i.e. __CLEANING__) the data

3. __Tidy_Data.txt__ is the output from run_analysis.R which is a tidy dataset that can be used for analysis. To load the dataset, you can use the read.table() function in R.

&nbsp;
&nbsp;

__For reviewers please consider the following code below to easily check the tidy data in R:__

```
fileURL = "https://coursera-assessments.s3.amazonaws.com/assessments/1604734387982/3e5c2e43-11ac-4dde-9d6d-dad81fbadb1f/TidyData.txt"

download.file(fileURL, destfile = "./TidyData.txt")
data1 = read.table("TidyData.txt", header=TRUE, check.names=FALSE)

head(data1[,1:10])

```
