# cleaningdataproject
Coursera getting and cleaning data 

---
title: "run_analysis"
author: "Shawnzoom"
date: "October 17, 2015"
output: html_document
---

The purpose of this task is to create one R script called run_analysis.R that does the following tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

on the following dataset:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset has been downloaded and expanded into the following directory e:/rcode/GettingDataProject

```{r eval=FALSE}
# load libraries
library(stringr)
library(plyr)
library(reshape2)


```


```{r eval= FALSE}
# Set the working dir to the location with the expanded dataset
setwd("e:/rcode/GettingDataProject/UCI HAR Dataset")
project_dir <- getwd()
project_dir

```

```{r eval= FALSE}
# list directory structure of the dataset
list.dirs()

```


```
[1] "."                        "./test"                   "./test/Inertial Signals" 
[4] "./train"                  "./train/Inertial Signals"

```
```{r eval= FALSE}
# list files in  "./test"  dir

test_files1 <- list.files("./test")
test_files1

```
```
[1] "Inertial Signals" "subject_test.txt" "X_test.txt"       "y_test.txt" 
```

```{r eval= FALSE}
# list files in  "./test/Inertial Signals" dir
test_files2 <- list.files("./test/Inertial Signals")
test_files2
```
```
[1] "body_acc_x_test.txt"  "body_acc_y_test.txt"  "body_acc_z_test.txt"  "body_gyro_x_test.txt"
[5] "body_gyro_y_test.txt" "body_gyro_z_test.txt" "total_acc_x_test.txt" "total_acc_y_test.txt"
[9] "total_acc_z_test.txt"
```

```{r eval= FALSE}
# list files in  "./train"  dir
train_files1 <- list.files("./train")
train_files1
```
```
[1] "Inertial Signals"  "subject_train.txt" "X_train.txt"       "y_train.txt"    
```


```{r eval= FALSE}
# list files in  "./train/Inertial Signals" dir
train_files2 <- list.files("./train/Inertial Signals")
train_files2

```
```
[1] "body_acc_x_train.txt"  "body_acc_y_train.txt"  "body_acc_z_train.txt"  "body_gyro_x_train.txt"
[5] "body_gyro_y_train.txt" "body_gyro_z_train.txt" "total_acc_x_train.txt" "total_acc_y_train.txt"
[9] "total_acc_z_train.txt"
```

### 1. Merges the training and the test sets to create one combined dataset.  ###

```{r eval= FALSE}
# create the 'top-level' combined directory
if (!file.exists("./combined")) {
  dir.create("./combined")
}
list.dirs()

```
```

```
[1] "."                        "./combined"               "./test"                  
[4] "./test/Inertial Signals"  "./train"                  "./train/Inertial Signals"
```

```{r eval= FALSE}
# create the 'Inertial Signals' direcoty for the  combined directory
if (!file.exists("./combined/Inertial Signals")) {
  dir.create("./combined/Inertial Signals")
}
list.dirs()
```
```
[1] "."                           "./combined"                  "./combined/Inertial Signals"
[4] "./test"                      "./test/Inertial Signals"     "./train"                    
[7] "./train/Inertial Signals" 

```


The follwing algorithm will be used to create a combined dataset:

1. copy the files from the train dataset to the respective combined directories
2. append to these files, the files from the test dataset
3. rename the files in the combined dir. That is, replace 'train' in all the file names with 'combined'

**Copy files**

```{r eval= FALSE}
# copy the files from the train dataset the respective combined directory

tmp_workdir <- paste(project_dir, "/train", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir) 

file.copy(train_files1,"../combined", overwrite = FALSE, recursive = FALSE )

# reset project working dir
setwd(project_dir) 

combined_files1 <- list.files("./combined")
combined_files1

```

```
[1] "Inertial Signals"  "subject_train.txt" "X_train.txt"       "y_train.txt"  
```

```{r eval= FALSE}
# copy the files from the train/Inertial Signals dataset the respective combined directory

tmp_workdir <- paste(project_dir, "/train/Inertial Signals", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)

file.copy(train_files2,"../../combined/Inertial Signals", overwrite = FALSE, recursive = FALSE )

# reset project working dir
setwd(project_dir)

combined_files2 <- list.files("./combined/Inertial Signals")
combined_files2

```
```
[1] "body_acc_x_train.txt"  "body_acc_y_train.txt"  "body_acc_z_train.txt" 
[4] "body_gyro_x_train.txt" "body_gyro_y_train.txt" "body_gyro_z_train.txt"
[7] "total_acc_x_train.txt" "total_acc_y_train.txt" "total_acc_z_train.txt"
```

**Append files /UCI HAR Dataset/combined**
```{r eval=FALSE}

tmp_workdir <- paste(project_dir, "/combined", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)
  
file_to_append <- paste(project_dir,"/test", "/","subject_test.txt" ,sep="" )
file.append("subject_train.txt", file_to_append)

file_to_append <- paste(project_dir,"/test", "/","X_test.txt" ,sep="" )
file.append("X_train.txt", file_to_append)

file_to_append <- paste(project_dir,"/test", "/","y_test.txt" ,sep="" )
file.append("y_train.txt", file_to_append)

# reset project working dir
setwd(project_dir)

```

**Append files /UCI HAR Dataset/combined/Inertial Signals**
```{r eval=FALSE}

tmp_workdir <- paste(project_dir, "/combined/Inertial Signals", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)
  

#
# body_acc files
#
file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_acc_x_test.txt" ,sep="")
file.append("body_acc_x_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_acc_y_test.txt" ,sep="")
file.append("body_acc_y_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_acc_z_test.txt" ,sep="")
file.append("body_acc_z_train.txt"  , file_to_append)

#
# body_gyro files
#
file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_gyro_x_test.txt" ,sep="")
file.append("body_gyro_x_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_gyro_y_test.txt" ,sep="")
file.append("body_gyro_y_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","body_gyro_z_test.txt" ,sep="")
file.append("body_gyro_z_train.txt" , file_to_append)

#
# total_acc files
#

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","total_acc_x_test.txt" ,sep="")
file.append("total_acc_x_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","total_acc_y_test.txt" ,sep="")
file.append("total_acc_y_train.txt" , file_to_append)

file_to_append <- paste(project_dir,"/test/Inertial Signals", "/","total_acc_z_test.txt" ,sep="")
file.append("total_acc_z_train.txt" , file_to_append)

# reset project working dir
setwd(project_dir)

```

**Rename files /UCI HAR Dataset/combined**
```{r eval=FALSE}
tmp_workdir <- paste(project_dir, "/combined", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)

file.rename("subject_train.txt", "subject_combined.txt" )
file.rename("X_train.txt", "X_combined.txt")
file.rename("y_train.txt", "y_combined.txt")

list.files()

# reset project working dir
setwd(project_dir)

```

**Rename files /UCI HAR Dataset/combined/Inertial Signals**

```{r eval= FALSE}

tmp_workdir <- paste(project_dir, "/combined/Inertial Signals", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)
  

#
# body_acc files
#

file.rename("body_acc_x_train.txt" , "body_acc_x_combined.txt")
file.rename("body_acc_y_train.txt" , "body_acc_y_combined.txt")
file.rename("body_acc_z_train.txt"  , "body_acc_z_combined.txt")

#
# body_gyro files
#

file.rename("body_gyro_x_train.txt" , "body_gyro_x_combined.txt")
file.rename("body_gyro_y_train.txt" , "body_gyro_y_combined.txt")
file.rename("body_gyro_z_train.txt" , "body_gyro_z_combined.txt")

#
# total_acc files
#

file.rename("total_acc_x_train.txt" , "total_acc_x_combined.txt")
file.rename("total_acc_y_train.txt" , "total_acc_y_combined.txt")
file.rename("total_acc_z_train.txt" , "total_acc_z_combined.txt")

# reset project working dir
setwd(project_dir)

```

```
> list.files("./combined")
[1] "Inertial Signals"     "subject_combined.txt" "X_combined.txt"      
[4] "y_combined.txt" 

> list.files("./combined/Inertial Signals")
[1] "body_acc_x_combined.txt"  "body_acc_y_combined.txt"  "body_acc_z_combined.txt" 
[4] "body_gyro_x_combined.txt" "body_gyro_y_combined.txt" "body_gyro_z_combined.txt"
[7] "total_acc_x_combined.txt" "total_acc_y_combined.txt" "total_acc_z_combined.txt"
```


### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###


```{r eval=FALSE}

# Set the working dir to the location with the expanded dataset

#list files in project_dir
list.files(project_dir)

```
```
# Before any processing, the dataset directory looks like...

[1] "activity_labels.txt" "combined"            "features.txt"        "features_info.txt"  
[5] "README.txt"          "test"                "train" 
```
```
From the README.txt
The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
```

By examining Readme.txt, features_info.txt and features.txt, all the measurements on the mean and standard deviation have mean() or std(), in their feature titles, respectively. Additionally, the features.txt file contains an index for the feature. For this execise, the additional vectors with **mean** in their titles will be ignored.


```
For example, the first 8 rows of features.txt have the following values. Rows 1-3, contain mean measurements and rows 4-6, contain standard deviation measurements. So, by reading the features.txt file it is possible to get the indexes for all the measurements on mean and standard deviation.

1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
7 tBodyAcc-mad()-X
8 tBodyAcc-mad()-Y

And... as an example, the following will be ignored
294 fBodyAcc-meanFreq()-X
295 fBodyAcc-meanFreq()-Y
296 fBodyAcc-meanFreq()-Z
```
The following will be the algorithm used to extract only the measurements on the mean and standard deviation for each measurement.

```
1. Create a file called features_mean_std.txt that is a subset of features.txt and only contains the features for the measuresments described above.
2. Create an index file called index_mean_std.txt 
3. Use index file to create subset of the combined dataset

```

```{r eval=FALSE}
#read the features file into a data frame called features
features <- read.table("features.txt",  sep = " ")

#subset the features data frame                 
features_mean_std <- subset(features, grepl("std()", V2, fixed = TRUE) | grepl("mean()", V2, fixed = TRUE) )
nrow(features_mean_std)
```
```
[1] 66
This is the expected result after verifaction using search, in a simple text editor
```
```{r eval=FALSE}
#Create features-mean_std.txt by writing the features_mean_std data frame to a file
write.table(features_mean_std, file = "features_mean_std.txt", sep = ",", row.names = FALSE, col.names = FALSE)
list.files()

```

```
[1] "activity_labels.txt"   "combined"              "features.txt"         
[4] "features_info.txt"     "features_mean_std.txt" "README.txt"           
[7] "test"                  "train"
```

```{r eval=FALSE}
# create the index file index_mean_std.txt by subsetting features_mean_std
index_mean_std <- subset(features_mean_std, V1 == V1, select = c(V1))
write.table(index_mean_std, file = "index_mean_std.txt", sep = ",", row.names = FALSE, col.names = FALSE)
list.files()
```

```
# The dataset directory now looks like...

[1] "activity_labels.txt"   "combined"              "features.txt"         
[4] "features_info.txt"     "features_mean_std.txt" "index_mean_std.txt"   
[7] "README.txt"            "test"                  "train"   
```

Make a directory called cleaningdata, to store the data that will subsetted from the combined data

```{r eval= FALSE}
# create a 'cleaingdata' directory 
if (!file.exists("cleaningdata")) {
  dir.create("cleaningdata")
}
list.dirs()
```

```
[1] "."                           "./cleaningdata"              "./combined"                 
[4] "./combined/Inertial Signals" "./test"                      "./test/Inertial Signals"    
[7] "./train"                     "./train/Inertial Signals" 
```


```{r eval=FALSE}
# read the combined dataset into a data frame
X_combined <- read.table("./combined/X_combined.txt",  sep = "")
ncol(X_combined)
nrow(X_combined)
```


As expected this gives the following results
```
> ncol(X_combined)
[1] 561
> nrow(X_combined)
[1] 10299
```
```{r eval= FALSE}

# use index_mean_std to subset the combined dataset
# first, transpose index_mean_std. This is so it can be used as vector for subsettung operations
t_index_mean_std <- t(index_mean_std)

# create subset data frame
X_cleaningdata <- X_combined[,t_index_mean_std]

#check numbers of rows and cols
ncol(X_cleaningdata)
nrow(X_cleaningdata)

```

As expected this gives the following results
```
> ncol(X_cleaningdata)
[1] 66
> nrow(X_cleaningdata)
[1] 10299
```

Save the subset data frame to the cleaningdata directory
```{r eval=FALSE}
# create file cleaningdata.txt in the cleaningdata directory
write.table(X_cleaningdata, file = "./cleaningdata/X_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = FALSE, append = FALSE)
list.files("./cleaningdata")

```
As expected
```
> list.files(./cleaningdata")
[1] "X_cleaningdata.txt"
```

**"X_cleaningdata.txt" contains the subset ofthe combined dataset as requested.**

### 3. Uses descriptive activity names to name the activities in the data set ###

```
From the README.txt it states "Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)". These activties are coded in the file y_combined.txt , in the combined dataset, as follows. That is, the numbers 1-6 are used in place of the descriptive names of the activity. The coding is located in the file "./UCI HAR Dataset/activity_labels"
```

```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```


The steps that follow are to create a file called y_cleaningdata.txt that has descriptive activity names, and saves it in the cleaningdata directory

```{r eval=FALSE}
# read the original that codes activity labels into a data frame
activity_labels <- read.table("activity_labels.txt",  sep = "")
ncol(activity_labels)
nrow(activity_labels)

```
```
> ncol(activity_labels)
[1] 2
> nrow(activity_labels)
[1] 6
```

```{r eval=FALSE}
# read the  activities from the combined dataset into a data frame
y_combined <- read.table("./combined/y_combined.txt",  sep = "")
ncol(y_combined)
nrow(y_combined)

```
```
> ncol(y_combined)
[1] 1
> nrow(y_combined)
[1] 10299
```


```{r eval=FALSE}
# make a copy of the data frame of coded activity levels 

y_cleaningdata <- y_combined

#Recode this data frame using the following function recoderFunc. 
#
# https://susanejohnston.wordpress.com/2012/10/01/find-and-replace-in-r-part-2-how-to-recode-many-value# s-simultaneously/
# Credit: Susan Johnston
#

recoderFunc <- function(data, oldvalue, newvalue) {

    # convert any factors to characters

    if (is.factor(data))     data     <- as.character(data)
    if (is.factor(oldvalue)) oldvalue <- as.character(oldvalue)
    if (is.factor(newvalue)) newvalue <- as.character(newvalue)

    # create the return vector

    newvec <- data

    # put recoded values into the correct position in the return vector

    for (i in unique(oldvalue)) newvec[data == i] <- newvalue[oldvalue == i]

    newvec

}

y_cleaningdata <- recoderFunc(y_cleaningdata, activity_labels$V1, activity_labels$V2)

head(y_cleaningdata)
```

```

        V1
1 STANDING
2 STANDING
3 STANDING
4 STANDING
5 STANDING
6 STANDING
```

```{r eval=FALSE}
# Add a colname called 'testActivity'
colnames(y_cleaningdata) <- c('testActivity')
head(y_cleaningdata)

```
```
> head(y_cleaningdata)
  testActivity
1     STANDING
2     STANDING
3     STANDING
4     STANDING
5     STANDING
6     STANDING
```


```{r eval=FALSE}
# write the file y_cleaningdata.txt in the cleaningdata directory
write.table(y_cleaningdata, file = "./cleaningdata/y_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = TRUE)
list.files("./cleaningdata")

```


### 4. Appropriately label the data set with descriptive variable names. ###

**Part 1: Handling X_cleaningdata.txt**

The subset dataset X\_cleaningdata.txt currently has no variable names associated with the columns. The variable names that should be added to this dataset are contained in the file **features_mean_std.txt** (only contains the variable names with **mean()** or **std()** in the name ) which is derived the **features.txt** in the combined dataset.


The steps complete this task are as follows

1. Copy features_mean_std.txt from the combined directory to the cleaning data directory
2. Read the file into a data frame and drop the first column
3. Transpose the data frame to a vector
4. Read the file X_cleaningdata.txt into a data
5. Add the vector from step 4 as the first row X_cleaningdata data frame
6. Write the X_cleaningdata data frame to a file




```{r eval=FALSE}
# Copy features_mean_std.txt from the combined directory to the cleaning data directory
file.copy("features_mean_std.txt"    ,"./cleaningdata/features_mean_std.txt", overwrite = FALSE, recursive = FALSE )
list.files("./cleaningdata")

```

```
[1] "features_mean_std.txt" "X_cleaningdata.txt"    "y_cleaningdata.txt"   
```

```{r eval=FALSE}
# Read the file into a data frame and drop the first column
features_mean_std.df <- read.table("./cleaningdata/features_mean_std.txt",  sep = ",")

ncol(features_mean_std.df)
nrow(features_mean_std.df)

#Result:
#
#> ncol(features_mean_std.df)
#[1] 2
#> nrow(features_mean_std.df)
#[1] 66

# drop the first column
dropped.feature_mean_std <- subset(features_mean_std.df, select=-c(V1))

# Transpose the data frame to a vector
t_features_mean_std.df <- as.vector(t(dropped.feature_mean_std))

# remove special punctuation characters
t_features_mean_std.df <-str_replace_all(t_features_mean_std.df, "[[:punct:]]", "")

str(t_features_mean_std.df)
```
```
> str(t_features_mean_std.df)
 chr [1:66] "tBodyAccmeanX" "tBodyAccmeanY" "tBodyAccmeanZ" "tBodyAccstdX" ...

```

```{r eval=FALSE}
# Read the file X_cleaningdata.txt into a data
X_cleaningdata <- read.table("./cleaningdata/X_cleaningdata.txt",  sep = ",")
ncol(X_cleaningdata)
```
```
The number of columns in X_cleaningdata matches the number of columns in t_features_mean_std.df
> ncol(X_cleaningdata)
[1] 66
```
```{r eval=FALSE}
# Preview teh head of X_cleaningdata
head(X_cleaningdata)

```
```
A snippet
> head(X_cleaningdata)
         V1          V2         V3         V4         V5         V6        V7
1 0.2885845 -0.02029417 -0.1329051 -0.9952786 -0.9831106 -0.9135264 0.9633961
2 0.2784188 -0.01641057 -0.1235202 -0.9982453 -0.9753002 -0.9603220 0.9665611
3 0.2796531 -0.01946716 -0.1134617 -0.9953796 -0.9671870 -0.9789440 0.9668781
4 0.2791739 -0.02620065 -0.1232826 -0.9960915 -0.9834027 -0.9906751 0.9676152
5 0.2766288 -0.01656965 -0.1153619 -0.9981386 -0.9808173 -0.9904816 0.9682244
6 0.2771988 -0.01009785 -0.1051373 -0.9973350 -0.9904868 -0.9954200 0.9679482
```



```{r eval=FALSE}
# Add the vector from step 4 as the first row X_cleaningdata data frame
colnames(X_cleaningdata) <- t_features_mean_std.df

# preview head of cleaning data
head(X_cleaningdata)
```

```
Here is a snippet of the head()
> head(X_cleaningdata)

  tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ
1     0.2885845   -0.02029417    -0.1329051   -0.9952786   -0.9831106   -0.9135264
2     0.2784188   -0.01641057    -0.1235202   -0.9982453   -0.9753002   -0.9603220
3     0.2796531   -0.01946716    -0.1134617   -0.9953796   -0.9671870   -0.9789440
4     0.2791739   -0.02620065    -0.1232826   -0.9960915   -0.9834027   -0.9906751
5     0.2766288   -0.01656965    -0.1153619   -0.9981386   -0.9808173   -0.9904816
6     0.2771988   -0.01009785    -0.1051373   -0.9973350   -0.9904868   -0.9954200
```

Save the subset data frame to the cleaningdata directory
```{r eval=FALSE}

# Write the X_cleaningdata data frame to a file, Overwrite existing file and write column names

write.table(X_cleaningdata, file = "./cleaningdata/X_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = TRUE, append = FALSE)

```
**Part 2: Creating subject_cleaningdata.txt from subject_combined.txt**

Steps

1. Copy file from combined directory to cleaningdata directory
2. Read file into data frame
3. Add a colname called 'testSubject'
4. Write the file back out again

```{r eval=FALSE}

# Copy subject_combined.txt from the combined directory to the cleaning data directory

file.copy("./combined/subject_combined.txt" , "./cleaningdata/subject_cleaningdata.txt", overwrite = FALSE, recursive = FALSE )

list.files("./cleaningdata")
```
```
> list.files("./cleaningdata")
[1] "features_mean_std.txt"    "subject_cleaningdata.txt" "X_cleaningdata.txt"      
[4] "y_cleaningdata.txt"
```


```{r eval=FALSE}
# Read the file subject_cleaningdata.txt into a data
subject_cleaningdata <- read.table("./cleaningdata/subject_cleaningdata.txt",  sep = "")

# Add a colname called 'testSubject'
colnames(subject_cleaningdata) <- c('testSubject')

head(subject_cleaningdata)
```
```
> head(subject_cleaningdata)
  testSubject
1           1
2           1
3           1
4           1
5           1
6           1
```
Save the subset data frame to the cleaningdata directory
```{r eval=FALSE}
# Write the subject_cleaningdata data frame to a file, Overwrite existing file and write column names
write.table(subject_cleaningdata, file = "./cleaningdata/subject_cleaningdata.txt", sep = "", row.names = FALSE, col.names = TRUE, append = FALSE)

```
 
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###


```{r eval=FALSE}

# Set the working dir to the location with the expanded dataset
setwd(project_dir)

#list files in project_dir
list.dirs(project_dir)

```
```
[1] "e:/rcode/GettingDataProject/UCI HAR Dataset"                          
[2] "e:/rcode/GettingDataProject/UCI HAR Dataset/cleaningdata"             
[3] "e:/rcode/GettingDataProject/UCI HAR Dataset/combined"                 
[4] "e:/rcode/GettingDataProject/UCI HAR Dataset/combined/Inertial Signals"
[5] "e:/rcode/GettingDataProject/UCI HAR Dataset/test"                     
[6] "e:/rcode/GettingDataProject/UCI HAR Dataset/test/Inertial Signals"    
[7] "e:/rcode/GettingDataProject/UCI HAR Dataset/train"                    
[8] "e:/rcode/GettingDataProject/UCI HAR Dataset/train/Inertial Signals"   
```

Make a directory called tidydata, to store the data that will be created from the cleadingdata

```{r eval= FALSE}
# create a 'cleaingdata' directory 
if (!file.exists("tidydata")) {
  dir.create("tidydata")
}
list.dirs()
```
```
> list.dirs()
[1] "."                           "./cleaningdata"             
[3] "./combined"                  "./combined/Inertial Signals"
[5] "./test"                      "./test/Inertial Signals"    
[7] "./tidydata"                  "./train"                    
[9] "./train/Inertial Signals" 
```
```{r eval=FALSE}
# Check the dimensions of the data frames that will be used for this exercise

dim(y_cleaningdata)
# [1] 10299     1
dim(subject_cleaningdata)
# [1] 10299     1
dim(X_cleaningdata)
#[1] 10299    66
```



```{r eval= FALSE}
#merge data frames by creating an index and then doing a join
y_cleaningdata <- cbind(id=c(1:10299), y_cleaningdata)

X_cleaningdata <- cbind(id=c(1:10299), X_cleaningdata)

subject_cleaningdata <- cbind(id=c(1:10299), subject_cleaningdata)

# Join data frames
dflist <- list(subject_cleaningdata, y_cleaningdata, X_cleaningdata)
tidydata <- join_all(dflist)

#id is no longer needed and it can be dropper
tidydata <- subset(tidydata, select=-c(id))

```

```
There are 30 test subjects and 6 activities and 66 variables per observation. Therefor the final dimesions of the tidydata dataset should be 180 (30 x 6) rows, by 66 columns
```

```{r eval=FALSE}

#Use testSubject and testActivity as the id
meltedTidyData<- melt(tidydata, id=c("testSubject", "testActivity"), na.rm = TRUE)


dim(meltedTidyData)
# [1] 679734      4


tidydata <- acast(meltedTidyData, testSubject + testActivity ~ variable, mean)
dim(tidydata)
# [1] 180  66

head(tidydata)
tail(tidydata)


```


```
Snippet (of head)
                     tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ
1_LAYING                 0.2215982  -0.040513953    -0.1132036  -0.92805647 -0.836827406  -0.82606140
1_SITTING                0.2612376  -0.001308288    -0.1045442  -0.97722901 -0.922618642  -0.93958629
1_STANDING               0.2789176  -0.016137590    -0.1106018  -0.99575990 -0.973190056  -0.97977588
1_WALKING                0.2773308  -0.017383819    -0.1111481  -0.28374026  0.114461337  -0.26002790
1_WALKING_DOWNSTAIRS     0.2891883  -0.009918505    -0.1075662   0.03003534 -0.031935943  -0.23043421
1_WALKING_UPSTAIRS       0.2554617  -0.023953149    -0.0973020  -0.35470803 -0.002320265  -0.01947924


Snippet (of tail)
                     tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX
30_LAYING                 0.2810339  -0.019449410   -0.10365815  -0.97636252
30_SITTING                0.2683361  -0.008047313   -0.09951545  -0.98362274
30_STANDING               0.2771127  -0.017016389   -0.10875621  -0.97755943
30_WALKING                0.2764068  -0.017588039   -0.09862471  -0.34639428
30_WALKING_DOWNSTAIRS     0.2831906  -0.017438390   -0.09997814  -0.05777032
30_WALKING_UPSTAIRS       0.2714156  -0.025331170   -0.12469749  -0.35050448

```

Save the tidydata data frame to the tidydata directory without row names. Note: This required to submit the assignment
```{r eval=FALSE}
# Write the tidy data frame to a file, Overwrite existing file and write column names and not row names
write.table(tidydata, file = "./tidydata/tidydata.txt", sep = ",", row.names = FALSE, col.names = TRUE, append = FALSE)

```

Read the tidydata.txt back to confirm rows are gone
```{r eval= FALSE}

# 
tidydata_minus_rownames <- read.table("./tidydata/tidydata.txt",  header = TRUE, sep = ",")

head(tidydata_minus_rownames)

```

```

Snippet of head(tidydata_minus_rownames)
  tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ tBodyAccstdX tBodyAccstdY tBodyAccstdZ
1     0.2215982  -0.040513953    -0.1132036  -0.92805647 -0.836827406  -0.82606140
2     0.2612376  -0.001308288    -0.1045442  -0.97722901 -0.922618642  -0.93958629
3     0.2789176  -0.016137590    -0.1106018  -0.99575990 -0.973190056  -0.97977588
4     0.2773308  -0.017383819    -0.1111481  -0.28374026  0.114461337  -0.26002790
5     0.2891883  -0.009918505    -0.1075662   0.03003534 -0.031935943  -0.23043421
6     0.2554617  -0.023953149    -0.0973020  -0.35470803 -0.002320265  -0.01947924
```



