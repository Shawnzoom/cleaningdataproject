
# The purpose of this task is to create one R script called run_analysis.R that does the following tasks:
#   
#   1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# on the following dataset:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# The dataset has been downloaded and expanded into the following directory e:/rcode/GettingDataProject
# 


# load libraries
library(stringr)
library(plyr)
library(reshape2)


# set the working directory to the root of the expanded dataset
setwd("e:/rcode/GettingDataProject/UCI HAR Dataset")
project_dir <- getwd()
project_dir


# list directory structure of the dataset
list.dirs()

# list files in  "./test"  dir

test_files1 <- list.files("./test")
test_files1

# list files in  "./test/Inertial Signals" dir
test_files2 <- list.files("./test/Inertial Signals")
test_files2


# list files in  "./train"  dir
train_files1 <- list.files("./train")
train_files1

# list files in  "./train/Inertial Signals" dir
train_files2 <- list.files("./train/Inertial Signals")
train_files2


### 1. Merges the training and the test sets to create one combined dataset.  ###

# The follwing algorithm will be used to create a combined dataset:
#   
# 1. copy the files from the train dataset to the respective combined directories
# 2. append to these files, the files from the test dataset
# 3. rename the files in the combined dir. That is, replace 'train' in all the file names with 'combined'

# create the 'top-level' combined directory
if (!file.exists("./combined")) {
  dir.create("./combined")
}
list.dirs()


# create the 'Inertial Signals' direcoty for the  combined directory
if (!file.exists("./combined/Inertial Signals")) {
  dir.create("./combined/Inertial Signals")
}
list.dirs()

# copy the files from the train dataset the respective combined directory

tmp_workdir <- paste(project_dir, "/train", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir) 

file.copy(train_files1,"../combined", overwrite = FALSE, recursive = FALSE )

# reset project working dir
setwd(project_dir) 

combined_files1 <- list.files("./combined")
combined_files1


# copy the files from the train/Inertial Signals dataset the respective combined directory

tmp_workdir <- paste(project_dir, "/train/Inertial Signals", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)

file.copy(train_files2,"../../combined/Inertial Signals", overwrite = FALSE, recursive = FALSE )

# reset project working dir
setwd(project_dir)

combined_files2 <- list.files("./combined/Inertial Signals")
combined_files2



# **Append files /UCI HAR Dataset/combined**


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



#**Append files /UCI HAR Dataset/combined/Inertial Signals**


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



# **Rename files /UCI HAR Dataset/combined**

tmp_workdir <- paste(project_dir, "/combined", sep ="" ) 

# set temporary working dir
setwd(tmp_workdir)

file.rename("subject_train.txt", "subject_combined.txt" )
file.rename("X_train.txt", "X_combined.txt")
file.rename("y_train.txt", "y_combined.txt")

list.files()

# reset project working dir
setwd(project_dir)



#*Rename files /UCI HAR Dataset/combined/Inertial Signals**
  


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



# 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###




# Set the working dir to the location with the expanded dataset

#list files in project_dir
list.files(project_dir)


# The following will be the algorithm used to extract only the measurements on the mean and standard deviation for each measurement.


#1. Create a file called features_mean_std.txt that is a subset of features.txt and only contains the features for the measuresments described above.
#2. Create an index file called index_mean_std.txt 
#3. Use index file to create subset of the combined dataset


#read the features file into a data frame called features
features <- read.table("features.txt",  sep = " ")

#subset the features data frame                 
features_mean_std <- subset(features, grepl("std()", V2, fixed = TRUE) | grepl("mean()", V2, fixed = TRUE) )
nrow(features_mean_std)

#Create features-mean_std.txt by writing the features_mean_std data frame to a file
write.table(features_mean_std, file = "features_mean_std.txt", sep = ",", row.names = FALSE, col.names = FALSE)
list.files()


# create the index file index_mean_std.txt by subsetting features_mean_std
index_mean_std <- subset(features_mean_std, V1 == V1, select = c(V1))
write.table(index_mean_std, file = "index_mean_std.txt", sep = ",", row.names = FALSE, col.names = FALSE)
list.files()



# create a 'cleaingdata' directory 
if (!file.exists("cleaningdata")) {
  dir.create("cleaningdata")
}

# read the combined dataset into a data frame
X_combined <- read.table("./combined/X_combined.txt",  sep = "")
ncol(X_combined)
nrow(X_combined)


# use index_mean_std to subset the combined dataset
# first, transpose index_mean_std. This is so it can be used as vector for subsettung operations
t_index_mean_std <- t(index_mean_std)

# create subset data frame
X_cleaningdata <- X_combined[,t_index_mean_std]

#check numbers of rows and cols
ncol(X_cleaningdata)
nrow(X_cleaningdata)



#Save the subset data frame to the cleaningdata directory

# create file cleaningdata.txt in the cleaningdata directory
write.table(X_cleaningdata, file = "./cleaningdata/X_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = FALSE, append = FALSE)
list.files("./cleaningdata")


             
#**"X_cleaningdata.txt" contains the subset ofthe combined dataset as requested.**

### 3. Uses descriptive activity names to name the activities in the data set ###

# read the original that codes activity labels into a data frame
activity_labels <- read.table("activity_labels.txt",  sep = "")
ncol(activity_labels)
nrow(activity_labels)


# read the  activities from the combined dataset into a data frame
y_combined <- read.table("./combined/y_combined.txt",  sep = "")
ncol(y_combined)
nrow(y_combined)


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

# Add a colname called 'testActivity'
colnames(y_cleaningdata) <- c('testActivity')
head(y_cleaningdata)

# write the file y_cleaningdata.txt in the cleaningdata directory
write.table(y_cleaningdata, file = "./cleaningdata/y_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = TRUE)
list.files("./cleaningdata")



# 4. Appropriately label the data set with descriptive variable names. ###

#**Part 1: Handling X_cleaningdata.txt**

#The subset dataset X\_cleaningdata.txt currently has no variable names associated with the columns. The variable names that should be added to this dataset are contained in the file **features_mean_std.txt** (only contains the variable names with **mean()** or **std()** in the name ) which is derived the **features.txt** in the combined dataset.


#The steps complete this task are as follows

# 1. Copy features_mean_std.txt from the combined directory to the cleaning data directory
# 2. Read the file into a data frame and drop the first column
# 3. Transpose the data frame to a vector
# 4. Read the file X_cleaningdata.txt into a data
# 5. Add the vector from step 4 as the first row X_cleaningdata data frame
# 6. Write the X_cleaningdata data frame to a file





# Copy features_mean_std.txt from the combined directory to the cleaning data directory
file.copy("features_mean_std.txt"    ,"./cleaningdata/features_mean_std.txt", overwrite = FALSE, recursive = FALSE )
list.files("./cleaningdata")


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

# Read the file X_cleaningdata.txt into a data
X_cleaningdata <- read.table("./cleaningdata/X_cleaningdata.txt",  sep = ",")
ncol(X_cleaningdata)

# Preview teh head of X_cleaningdata
head(X_cleaningdata)


# Add the vector from step 4 as the first row X_cleaningdata data frame
colnames(X_cleaningdata) <- t_features_mean_std.df

# preview head of cleaning data
head(X_cleaningdata)


#Save the subset data frame to the cleaningdata directory

# Write the X_cleaningdata data frame to a file, Overwrite existing file and write column names

write.table(X_cleaningdata, file = "./cleaningdata/X_cleaningdata.txt", sep = ",", row.names = FALSE, col.names = TRUE, append = FALSE)


# **Part 2: Creating subject_cleaningdata.txt from subject_combined.txt**

# Steps
# 
# 1. Copy file from combined directory to cleaningdata directory
# 2. Read file into data frame
# 3. Add a colname called 'testSubject'
# 4. Write the file back out again



# Copy subject_combined.txt from the combined directory to the cleaning data directory

file.copy("./combined/subject_combined.txt" , "./cleaningdata/subject_cleaningdata.txt", overwrite = FALSE, recursive = FALSE )

list.files("./cleaningdata")

# Read the file subject_cleaningdata.txt into a data
subject_cleaningdata <- read.table("./cleaningdata/subject_cleaningdata.txt",  sep = "")

# Add a colname called 'testSubject'
colnames(subject_cleaningdata) <- c('testSubject')

head(subject_cleaningdata)

#Save the subset data frame to the cleaningdata directory

# Write the subject_cleaningdata data frame to a file, Overwrite existing file and write column names
write.table(subject_cleaningdata, file = "./cleaningdata/subject_cleaningdata.txt", sep = "", row.names = FALSE, col.names = TRUE, append = FALSE)



### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###


# Set the working dir to the location with the expanded dataset
setwd(project_dir)

#list files in project_dir
list.dirs(project_dir)


#Make a directory called tidydata, to store the data that will be created from the cleadingdata


# create a 'cleaingdata' directory 
if (!file.exists("tidydata")) {
dir.create("tidydata")
}
list.dirs()

# Check the dimensions of the data frames that will be used for this exercise

dim(y_cleaningdata)
# [1] 10299     1
dim(subject_cleaningdata)
# [1] 10299     1
dim(X_cleaningdata)
#[1] 10299    66

#merge data frames by creating an index and then doing a join
y_cleaningdata <- cbind(id=c(1:10299), y_cleaningdata)

X_cleaningdata <- cbind(id=c(1:10299), X_cleaningdata)

subject_cleaningdata <- cbind(id=c(1:10299), subject_cleaningdata)

# Join data frames
dflist <- list(subject_cleaningdata, y_cleaningdata, X_cleaningdata)
tidydata <- join_all(dflist)

#id is no longer needed and it can be dropper
tidydata <- subset(tidydata, select=-c(id))

#There are 30 test subjects and 6 activities and 66 variables per observation. Therefor the final dimesions of the tidydata dataset should be 180 (30 x 6) rows, by 66 columns

#Use testSubject and testActivity as the id
meltedTidyData<- melt(tidydata, id=c("testSubject", "testActivity"), na.rm = TRUE)

dim(meltedTidyData)
# [1] 679734      4

tidydata <- acast(meltedTidyData, testSubject + testActivity ~ variable, mean)
dim(tidydata)
# [1] 180  66

head(tidydata)
tail(tidydata)

#Save the tidydata data frame to the tidydata directory without row names. Note: This required to submit the assignment

# Write the tidy data frame to a file, Overwrite existing file and write column names and not row names
write.table(tidydata, file = "./tidydata/tidydata.txt", sep = ",", row.names = FALSE, col.names = TRUE, append = FALSE)

#Read the tidydata.txt back to confirm rows are gone

tidydata_minus_rownames <- read.table("./tidydata/tidydata.txt",  header = TRUE, sep = ",")

head(tidydata_minus_rownames)


