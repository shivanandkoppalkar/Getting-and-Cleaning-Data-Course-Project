# Program Name: run_analysis.R
# March 22, 2016

library(dplyr)

# set working directory
setwd("C:/Work")

# Read features.txt and capture the complete list of variables
# of each vector
# Column V1: Count
# Column V2: Feature
# 561 entries: These are the column names of the text data files.
features<-read.table("features.txt")
class(features)

# Read the data files and capture the information
# in a R data frame:
# act_labels: activity_labels.txt (Values are from 1 to 6, indicates activity name)
# y_train: y_train.txt (Values are 1 to 6 = activity labels, 7,352 entries)
# y_test: y_test.txt (Values are 1 to 6 = activity labels, 2947 entries)

act_labels<-read.table("activity_labels.txt")
y_train<-read.table("y_train.txt")
y_test<-read.table("y_test.txt")

### TRAIN GROUP Information data ###
# Number of records and columns checked using dim.data.frame() 
# Range of values for subject_* checked using unique() 
# head() function used for each TR_* variables to check if the way read.table() captured
# the information from the text data files makes sense

# subject_train: subject_train.txt: identifies the subject who performed the activity, 7,352 entries
#                values are 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23 25, 26, 27, 28, 29, 30
#
# TR_body_acc_x: body_acc_x_train.txt; 7352R x 128C records
#                body acceleration signal from smartphone X-axis
#                obtained by subtracting the gravity from total acceleration 
#                7352R x 128C records
# TR_body_acc_y: body_acc_y_train.txt; 7352R x 128C records
#                body acceleration signal from smartphone Y-axis 
#                obtained by subtracting the gravity from total acceleration
#                7352R x 128C records
# TR_body_acc_z: body_acc_z_train.txt; 7352R x 128C records
#                body acceleration signal from smartphone Z-axis 
#                obtained by subtracting the gravity from total acceleration 
#                7352R x 128C records

# TR_body_gyro_x: body_gyro_x_train.txt; 7352R x 128C records
#                 angular velocity vector measured by gyroscope for each sample 
#                 in radians/second for the X-axis   
# TR_body_gyro_y: body_gyro_y_train.txt; 7352R x 128C records
#                 angular velocity vector measured by gyroscope for each sample in radians/second   
#                 in radians/second for the X-axis
# TR_body_gyro_z: body_gyro_z_train.txt; 7352R x 128C records
#                 angular velocity vector measured by gyroscope for each sample in radians/second   
#                 in radians/second for the X-axis

# TR_tot_acc_x: total_acc_x_train.txt; 7352R x 128C records
#               acceleration signal from smartphone accelerometer X axis in std gravity units 
# TR_tot_acc_y: total_acc_y_train.txt; 7352R x 128C records
#               acceleration signal from smartphone accelerometer Y axis in std gravity units 
# TR_tot_acc_z: total_acc_z_train.txt; 7352R x 128C records
#               acceleration signal from smartphone accelerometer Z axis in std gravity units 
# Only the subject_train.txt file was directly used to produce desired output file
# Other files were read and stored to data frames to check contents and see if there are information
# needed for producing output file which are not availble from the X_train.txt and X_test.txt files.

subject_train<-read.table("subject_train.txt")

### TEST GROUP Information data ###
# Number of records and columns checked using dim.data.frame() to check for functionality
# Range of values for subject_* checked using unique() 
# head() function used for each TEST_* variables to check if the way read.table() captured
# the information from the text data files makes sense

# subject_test: subject_test.txt: identifies the subject who performed the activity, 2,947 entries
#                values are 2, 4, 9, 10, 12, 13, 18, 20, 24
#
# TEST_body_acc_x: body_acc_x_test.txt; 2947R x 128C records
#                body acceleration signal from smartphone X-axis
#                obtained by subtracting the gravity from total acceleration 
#                7352R x 128C records
# TEST_body_acc_y: body_acc_y_test.txt; 2947R x 128C records
#                body acceleration signal from smartphone Y-axis 
#                obtained by subtracting the gravity from total acceleration
#                7352R x 128C records
# TEST_body_acc_z: body_acc_z_test.txt; 2947R x 128C records
#                body acceleration signal from smartphone Z-axis 
#                obtained by subtracting the gravity from total acceleration 
#                7352R x 128C records

# TEST_body_gyro_x: body_gyro_x_test.txt; 2947R x 128C records
#                 angular velocity vector measured by gyroscope for each sample 
#                 in radians/second for the X-axis   
# TEST_body_gyro_y: body_gyro_y_test.txt; 2947R x 128C records
#                 angular velocity vector measured by gyroscope for each sample in radians/second   
#                 in radians/second for the X-axis
# TEST_body_gyro_z: body_gyro_z_test.txt; 2947R x 128C records
#                 angular velocity vector measured by gyroscope for each sample in radians/second   
#                 in radians/second for the X-axis

# TEST_tot_acc_x: total_acc_x_train.txt; 2947R x 128C records
#               acceleration signal from smartphone accelerometer X axis in std gravity units 
# TEST_tot_acc_y: total_acc_y_train.txt; 2947R x 128C records
#               acceleration signal from smartphone accelerometer Y axis in std gravity units 
# TEST_tot_acc_z: total_acc_z_train.txt; 2947R x 128C records
#               acceleration signal from smartphone accelerometer Z axis in std gravity units 
# Only the subject_test.txt file was directly used to produce desired output file
# Other files were read and stored to data frames to check contents and see if there are information
# needed for producing output file which are not availble from the X_train.txt and X_test.txt files.

subject_test<-read.table("subject_test.txt")

#####################################################################
#1. Merge the training and the test sets to create one data set.
#2. Extract only measurements on the mean and standard deviation
#for each measurement. 
#4. Label the data set with descriptive variable names
#####################################################################

# Read the data files and capture the information
# in a R dataframe:
# x_train: X_train.txt (7352R x 561C entries on Training information)
# x_test : X_test.txt (2947R x 561C entries on Test information)
# Use features dataframe to specify the column names 
# for both x_train and x_test(#4)

x_train<-read.table("X_train.txt",col.names=features$V2)
x_test<-read.table("X_test.txt",col.names=features$V2)

# Append values of subject_train and subject_test (subject identifier) to
# x_train and x_test, respectively

x_train<-cbind(x_train,subject_train)
x_test<-cbind(x_test,subject_test)

# Append values of y_train and y_test (activity identifier) to
# x_train and x_test, respectively

x_train<-cbind(x_train,y_train)
x_test<-cbind(x_test,y_test)

# Rename appended column to Subject_id and activity

names(x_train)[562]<-"subject_id"
names(x_test)[562]<-"subject_id"

names(x_train)[563]<-"activity"
names(x_test)[563]<-"activity"

# capture column numbers to include in the merged data
# Sub-features only include mean(), std(), subject_id and activity (#2)

SubFeatures<-c(grep(pattern=".*-(mean|std)\\(\\)",features$V2,value=FALSE),562,563)
x_train<-x_train[,SubFeatures]
x_test<-x_test[,SubFeatures]

# add column to indicate if subject is from Train or Test groups
x_train<-mutate(x_train,subject_grp="train")
x_test<-mutate(x_test,subject_grp="test")

# Merge the train and test data to one data frame.(#1)
AllData<-rbind(x_train,x_test)

#####################################################################
#3. Use descriptive activity names to name activities in the dataset
#####################################################################
AllData<-merge(AllData,act_labels,by.x='activity', by.y='V1')
names(AllData)[70]<-"desc_activity"

##############################################################################
# #5 creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject after (1) to (4).
# Thus, the mean will be calculated from Columns 2 to 67.
###############################################################################

TidySet<-aggregate(AllData[, 2:67], list(AllData$subject_id,AllData$desc_activity), mean)
TidySet<-transform(TidySet,Group.1=as.character(Group.1))

# To export TidySet data frame to a text file, install the
# MASS package: install.packages("MASS")
# and then load the library via library(MASS) command
# Output file is Output_Mean_Grouped.txt

library(MASS)
write.matrix(TidySet,file="tidy_data.txt",sep=" ")

# use rm(list=ls()) to remove variables from workspace when 
# done using the data frames
