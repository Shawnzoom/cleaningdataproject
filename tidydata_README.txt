******************************************************************
******************************************************************
Coursera Course Getting and Cleaning Data 


- title:"tidydat_README"
- author: "Shawnzoom"
- date: "October, 2015"

The document forms part of teh accampnying code books for work performed by Shawnzoom for the Coursera course 
Getting and Cleaning Data to produce a tidy dataset with an R script called run_analysis.R.

This code book is based on the following work:


==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The dataset and code books for that work can be downloaded from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This code book describes the dataset resulting from the following operations on the `Human Activity Recognition Using Smartphones Dataset'

Operations:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This code book only describes the data in the tidy dataset. For full details of the orignal dataset please download the dataset and refer to 
its accompanying code books
******************************************************************
******************************************************************




For each record it is provided:
======================================


- A 66-feature vector with time and frequency domain variables. 


The dataset includes the following files:
=========================================

- 'tidydata_README.txt' This file

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'tidydata_features.txt': List of all features.

- 'tidydata.txt': The dataset.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

