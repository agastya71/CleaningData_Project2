##CodeBook explaining the data ans transformation taking place within the script
---
###Script :
run_analysis.R

###Library dependencies :
dplyr 

#####variables:
1. X_test/train  = variable that contains the dataframe of the data from X_test/train.txt
2. subject_test/train = variable containing the subject information from subject_test/train.txt
3. y_test/train = variable containing the activity information from y_text/train.txt
4. activity_lables = variable containing text descriptions of the activities mentioned in y_test/train variables
5. feature_lables = columnar headings of the data in X_test/train variables
6. X_test/train_complete = Combined data for test/train (adding the subject and activity columns to the test/train data from X_test/train)
7. X_merged_complete = test and Train data combined
8. lables = transient variable used to store the label Strings form the feature_label variable
9. subset_labels = transient variable used to store just the column names that contain "mean" or "std" 
10. X_subset = subset of the complete merged data (X_merged_complete) that contains data for columns with "mean" or "std"
11. X_subset_groupedBysubjectAndActivity = subset data that is grouped by subject and by activity.
12. summarisedByMean = Final data set that is   average of each variable for each activity and each subject

#####Transformations :
The following Transformations are performed on the data to extract the required data :
* data stored in variables mentioned in Item 5(above) are achieved via the use of cbind (allowing to bind dataframes together via columns)
* data stored in variable mentioned in Item 6(above) is achieved via the use of rbind(allowing for the two dataframes to be bound rowise)
* the lables mentioned in Item 8(above) are assigned to the dataframe created in Item 7
* the complete merged data set is then subsetted (using subset) and only the columns that match the patern "mean|std" are included via the use of grep and subset and select
* the data frame is converted into a Table (for use with the dplyr package)
* An additional column(activity_label) is then added to the subsetted data that indicates the activity in String version. 
* Original Column activity is moved (using the select function)
* Newly added column (activity_label) is renamed to activity, using the rename function
* The subset data is then grouped by two columns - subject and then by activity.

FInally the grouped data is summarised to result in the required result : "average of each variable for each activity and each subject"


