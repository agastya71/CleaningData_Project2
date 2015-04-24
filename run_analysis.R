cleanupdata <- function() {
  ## Load dependency libraries. 
  library(dplyr)
  
  #read test and train data
  X_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"), quote="\"", stringsAsFactors=FALSE)
  X_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"), quote="\"", stringsAsFactors=FALSE)
  subject_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"), quote="\"", stringsAsFactors=FALSE)
  subject_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt")subject_text, quote="\"")
  y_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"), quote="\"")
  y_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"), quote="\"", stringsAsFactors=FALSE)
  activity_labels <- read.table(paste0(getwd(),"/UCI HAR Dataset/activity_labels.txt"), quote="\"", stringsAsFactors=FALSE)
  features_labels <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"), quote="\"", stringsAsFactors=FALSE)
  
  #cbind acitivity and test columns
  X_test_complete <- cbind(X_test,y_test,subject_test)
  X_train_complete <- cbind(X_train,y_train,subject_train)
  
  # rbind test and train
  X_merged_complete <- rbind(X_test_complete,X_train_complete)
  
  # apply labels
  labels <- as.vector(features_labels$V2)
  labels <- append(labels,c("activity","subject"),after=length(labels))
  colnames(X_merged_complete) <- labels
  
  #Apply subsetting to get only columns that are either mean or std.
  subset_labels <- as.vector(labels[grep("mean|std|activity|subject", labels)])
  X_subset <- subset(X_merged_complete,select = subset_labels)
  
  # apply activity lables as additional columns
  X_subset <- tbld_df(X_subset)   ## Convert to dplyr table format
  X_subset <- mutate(X_subset, activity_label = activity_labels$V2[activity])
  X_subset <- select(X_subset,-activity) 
  X_subset <- rename(X_subset, activity = activity_label)  ## renaming column to activity


  # perform required calculations
  X_subset_groupedBysubjectAndActivity = group_by(X_subset, subject,activity, add=TRUE)
  summarisedBymean <- summarise_each(X_subset_groupedBysubjectAndActivity,funs(mean),matches("mean|std"))
  write.table(summarisedBymean,file="summarised_data.txt",row.name=FALSE)

}
