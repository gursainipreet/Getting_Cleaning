#R script named run_analysis.R 
#Created as part of 'course project' for course 'Getting and Cleaning data' as per the instructions.

# set the locations for folders (Training, Testing, and Final Destination)
dirTrain<- "/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/train"
dirTest<- "/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/test"
dirDest<- "/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/final"

# 1. Merges the training and the test sets to create one data set.


#Read subjects, features and labels from Training files into tables
trainSubjects <- read.table(paste(dirTrain, "/subject_train.txt",sep = ""), sep = " ")
trainFeatures <- read.table(paste(dirTrain, "/X_train.txt",sep = ""))
trainLabels   <-   read.table(paste(dirTrain, "/y_train.txt",sep = ""), sep = " ")

#Read subjects, features and labels from Testing files into tables
testSubjects <- read.table(paste(dirTest, "/subject_test.txt",sep = ""), sep = " ")
testFeatures <- read.table(paste(dirTest, "/X_test.txt",sep = ""))
testLabels   <-   read.table(paste(dirTest, "/y_test.txt",sep = ""), sep = " ")

# put together the training data followed by the Testing data for complete data set files
comSubjects <- rbind(trainSubjects, testSubjects)
comFeatures <- rbind(trainFeatures, testFeatures)
comLabels   <- rbind(trainLabels, testLabels)
      
# Writing the complete data to various files. No row or column names are added to keep it as much
# alike the original data as possible
write.table(comSubjects,paste(dirDest, "/subject.txt",sep = ""),row.names = FALSE, col.names = FALSE)
write.table(comFeatures,paste(dirDest, "/X_.txt",sep = ""),row.names = FALSE, col.names = FALSE)
write.table(comLabels,paste(dirDest, "/y_.txt",sep = ""),row.names = FALSE, col.names = FALSE)

#---------------------------------------End of Part 1 -----------------------------------------------


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

#In order to achieve this, first you have to identify what measurements are there in the dataset
#on mean and standard deviation (S.D.). From features-info.txt and features.txt we can get this 
# information. 

# In order to be able to extract the exact measures, we need to use feature names provided in
#feature.txt as column names.
colNames <- read.table("/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/features.txt", sep = " ")
# just keep the feature names
colNames <- colNames[,2]
# add feature names as column names to the complete dataset (comFeatures) created above 
colnames(comFeatures) <- colNames
# write feature data with the column names to the feature data set file 
write.table(comFeatures,paste(dirDest, "/X_.txt",sep = ""),row.names = FALSE, col.names = TRUE)

#create dataset with extracted features by subsetting the comFeatures datasets 
#by keeping only those columns which have either "std" or "mean" in their names
#using grep() for partial matching of names and using indices returned to subset the feature dataset
extFeatures<- comFeatures[,c(grep("std",colNames),grep("mean",colNames))]
write.table(extFeatures,paste(dirDest, "/extracted.txt",sep = ""),row.names = FALSE, col.names = TRUE)
#---------------------------------------End of Part 2 -----------------------------------------------


# 3. Uses descriptive activity names to name the activities in the data set
#Activity names are given in file activity_labels.txt along with the id. 
# In the dataset the activities are mentioned in y_.txt file. 
actNames<-read.table("/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/activity_labels.txt", sep = " ")
#for all the rows (10299) in comLabels (labels dataset) created above we need to replace the number
# by descrption
for (i in 1: 10299){
      # get the activity number for the row
      c = comLabels[i,1]
      # get the activity label corrosponding to the activity number  
      label = actNames[c,2]
      # set the activity name instead of number in the comLables data frame
      comLabels[i,1] <- label
}
# update the file with new information
write.table(comLabels,paste(dirDest, "/y_.txt",sep = ""),row.names = FALSE, col.names = FALSE)

#---------------------------------------End of Part 3 -----------------------------------------------


# 4. Appropriately labels the data set with descriptive variable names.

# This has been done already as a part of solution to Part 2
# We can use feature names provided in feature.txt as column names.
colNames <- read.table("/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/features.txt", sep = " ")
# just keep the feature names
colNames <- colNames[,2]
# add feature names as column names to the complete dataset (comFeatures) created above 
colnames(comFeatures) <- colNames
# write feature data with the column names to the feature data set file 
write.table(comFeatures,paste(dirDest, "/X_.txt",sep = ""),row.names = FALSE, col.names = TRUE)
#Give appropriate names to variables
colnames(comSubjects) <- "Subject_ID"
colnames(comLabels) <- "Activity_Label"
# put together all the data from three files to make a complete datasets 
dataComp<- cbind(comSubjects,comLabels, comFeatures)
#Write it to the file
write.table(castData,"/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/final/The_Dataset.txt",row.names = FALSE, col.names = TRUE)

#---------------------------------------End of Part 4 -----------------------------------------------

# 5. Creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject.

# We need to put all the data from three files into one before processding any further
# So, we will add descritptive variable names to columns in labels and subject data
# and use the data to create a merged file
# No need for comFeatures as it has been done already

#reshape2 library will be required for casting and melting functions
library(reshape2)
colnames(comSubjects) <- "Subject_ID"
colnames(comLabels) <- "Activity_Label"

#put together the data from labels and features
dataActFea<- cbind(comLabels,comFeatures)
# Create working copy of data
cpyDataActFea <- dataActFea
#melt data according to Activity Label
meltData<- melt(cpyDataActFea, id = c("Activity_Label"))
#cast the data to get means for all variables for each activity
castData <- dcast(meltData, Activity_Label ~ variable, mean)
# Write the final cast data into file
write.table(castData,"/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/final/Activity_mean.txt",row.names = FALSE, col.names = TRUE)

#put together the data from subject and features
dataSubFea<- cbind(comSubjects,comFeatures)
# Create working copy of data
cpydataSubFea <- dataSubFea
#melt data according to Subject ID
meltData<- melt(cpydataSubFea, id = c("Subject_ID"))
#cast the data to get means for all variables for each activity
castData <- dcast(meltData, Subject_ID ~ variable, mean)
# Write the final cast data into file
write.table(castData,"/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/final/Subject_mean.txt",row.names = FALSE, col.names = TRUE)


#take the complete data 
dataSubAct<- cbind(comSubjects,comLabels, comFeatures)
# Create working copy of data
cpydataSubAct <- dataSubAct
#melt data according to Subject ID and Activity Label
meltData<- melt(cpydataSubAct, id = c("Subject_ID", "Activity_Label"))
#cast the data to get means for all variables for each activity and each subject
castData <- dcast(meltData, Activity_Label + Subject_ID ~ variable, mean)
# Write the final cast data into file
write.table(castData,"/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/UCI_HAR_Dataset/final/Subject_Activity_mean.txt",row.names = FALSE, col.names = TRUE)


#---------------------------------------End of Part 5 -----------------------------------------------