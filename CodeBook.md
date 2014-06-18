Created as part of 'course project' for course 'Getting and Cleaning data' as per the instructions.
Input: The original data sets provided 

Part 1:
Solution Part 1:

After setting the locations for folders (Training, Testing, and Final Destination), in order to Merges the training and the test sets to create one data set:
      Read subjects, features and labels from Training files into tables using read.table()
      Read subjects, features and labels from Testing files into tables using read.table()
      Put together the training data followed by the Testing data for complete data set files using      
      rbind()
      Write the complete data to various files [X_.txt, y_.txt, subject.txt]. No row or column names 
      were added to keep it as much alike the original data as possible using write.table() with row
      .names = FALSE, col.names =       
      FALSE 

Output X_.txt, y_.txt, subject.txt 
#---------------------------------------End of Part 1 -----------------------------------------------
Part 2: Extracts only the measurements on the mean and standard deviation for each measurement.
Solution Part 2

      Identify what measurements are there in the dataset on mean and standard deviation (S.D.). Use 
      features-info.txt and features.txt for this information 
      Use feature names provided in feature.txt as column names. Use read.table() and subsetting
      Add feature names as column names to the complete dataset using colnames()
      Write feature data with the column names to the feature data set file  using write.table() with 
      row.names = FALSE, col.names = TRUE 
      Create dataset with extracted features by subsetting the datasets by keeping only those columns 
      which have either "std" or "mean" in their names use grep() for partial matching of names and 
      use indices returned to subset the feature dataset
      Write feature data to file [extracted.txt] with the column names to the feature data set file  
      using write.table() with row.names = FALSE, col.names = TRUE  
Output:  extracted.txt
#---------------------------------------End of Part 2 -----------------------------------------------
Part 3: Uses descriptive activity names to name the activities in the data set

Solution Part 3:
      Descriptive activity names are taken from file activity_labels.txt along with the id. In the 
      dataset the activities are mentioned in y_.txt file.
      For all the rows (10299) in labels.txt dataset, we need to replace the id by descrption
      Get the activity number for the each row (using for loop)
            get the activity label corrosponding to the activity number  
            set the activity name instead of number in the data frame
      Write it to the file (labels.txt)

output: labels.txt
#---------------------------------------End of Part 3 -----------------------------------------------
The_Dataset.txt
Part 4: Appropriately label the data set with descriptive variable names.
Solution Part 4:
      In parts it has already been done as a part of solution to Part 2
      Using the feature names provided in feature.txt as column names Add feature names as column       
      names to the complete features dataset and write feature data with the column names to the       
      feature data set file 
      Give appropriate names to variables in subject and activity data (I used "Subject_ID" and  
      "Activity_Label" as column heads
      Put together all the data from three files to make a complete datasets 
      Write it to the file [The_Dataset.txt] using write.table with row.names = FALSE, col.names = 
      TRUE
Output: The_Dataset.txt

#---------------------------------------End of Part 4 -----------------------------------------------
Part 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Solution Part 5:
      We need to put all the data from three files into one before proceeding any further and use the 
      data to create a merged data frames  
      reshape2 library will be required for casting and melting functions
I have done this in three different ways to have:
      a) Tidy data set for avarage for each activity
      b) Tidy data set for avarage for each subject
      c) Tidy data set for avarage for each activity and each subject
      a)
            Put together the data from labels and features
            Create working copy of data (No need to do this, just to make sure that original copy is             
            safe)
            Melt data according to Activity Label
            Cast the data to get means for all variables for each activity
            Write the final cast data into file [Activity_mean.txt]
      b)
            Put together the data from subject and features
            Create working copy of data (No need to do this)
            Melt data according to Subject ID
            Cast the data to get means for all variables for each activity
            Write the final cast data into file [Subject_mean.txt]
      c)

            Take the complete data
            Create working copy of data (No need to do this)
            Melt data according to Subject ID and Activity Label
            Cast the data to get means for all variables for each activity and each subject
            Write the final cast data into file[Subject_Activity_mean.txt]

Output: Activity_Mean.txt
        Subject_mean.txt
        Subject_Activity_Mean.txt
#---------------------------------------End of Part 5 -----------------------------------------------