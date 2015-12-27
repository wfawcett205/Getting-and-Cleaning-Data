run_analysis <- function(...){
  library(plyr)
  library(dplyr)
  
  ## Read-in the UCI HAR Dataset  
  
  features <- read.table("./UCI HAR Dataset/features.txt")
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  
  ## Generate two data sets: test_db and train_db using cbind().
  ## Assign column names from the object "features".
  ## Write the new data sets to file.
  
  test_db <- cbind(subject_test, y_test, x_test)
  train_db <- cbind(subject_train, y_train, x_train)
  features[,2] <- as.character(features[,2])
  db_names <- c("Subject" , "Activity", features[,2])
  colnames(test_db) <- db_names
  colnames(train_db) <- db_names
  write.csv(train_db, "test_db.csv")
  write.csv(train_db, "train_db.csv")
  
  ## Combine the two data sets into a single data set using rbind().
  ## Assign the descriptive labels from activity_labels to Activity.
  ## Using a series of for statements assign the descriptive activity labels to
  ## the new data set.
  ## Write the new data set to file.
  
  data_set <- rbind(test_db, train_db)
  data_set$Subject <- as.numeric(data_set$Subject)
  data_set$Activity <- as.character(data_set$Activity)
  Activity <- as.character(activity_labels[,2])
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "1") {data_set$Activity[i] <- Activity[1]}}
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "2") {data_set$Activity[i] <- Activity[2]}}
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "3") {data_set$Activity[i] <- Activity[3]}}
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "4") {data_set$Activity[i] <- Activity[4]}}
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "5") {data_set$Activity[i] <- Activity[5]}}
  for(i in 1:nrow(data_set)){if(data_set$Activity[i] == "6") {data_set$Activity[i] <- Activity[6]}}
  write.csv(data_set, "data_set.csv")
  
  ## Subset data_set using "grep" to select columns that contain either "mean" or "std".
  ## Assign this new data set to new_db.
  ## Assign appropriate column names.
  ## Sort new_db on the 1st and 2nd columns.
  ## Reset the rownames.
  ## Write new_db to file.
  
  new_db <- data_set[,(1:2)]
  temp_db <- data_set[,(3:563)]
  new_features <- grep("mean|std", features[,2], ignore.case = TRUE)
  for (i in 1:length(new_features)){new_db <- cbind(new_db, temp_db[, new_features[i]])}
  new_db_names <- c("Subject", "Activity")
  for (i in 1:length(new_features)){new_db_names <- c(new_db_names, features[i,2])}
  colnames(new_db)<-new_db_names
  new_db <- new_db[order(new_db[,1], new_db[,2]), ]
  row.names(new_db)<-c(1:10299)
  write.csv(new_db, "new_db.csv")
  
  ## For each Subject and Activity determine the mean for each column and assign
  ## the results to a vector: Group_i.
  ## Combine the individual vectors into a single table using rbind().
  ## Transpose the table using t().
  
  for(i in 3:88){assign(paste("Group", "_", i-2, sep = ""), as.vector(tapply(new_db[, i], 
    list(new_db$Subject, new_db$Activity), mean)))}
  group_name <- "Group_1"
  for(i in 2:86) group_name <- c(group_name, paste("Group", "_", i, sep = ""))
  grp_tbl<- rbind(Group_1, Group_2)
  for(i in 3:86) grp_tbl <- rbind(grp_tbl, get(group_name[i]))
  group_tbl <- t(grp_tbl)
  group_tbl <- as.data.frame(group_tbl)
 
  ## Assign descriptive variable labels.
  ## Generate the final tidy_data set.
  ## Write tidy_data to file.
  
  column_names <- colnames(new_db)
  colnames(group_tbl) <- column_names[3:88]
  Subject <- "Subject_01"
  for(i in 2:9) Subject <- c(Subject, paste("Subject", "_", "0", i, sep = ""))
  for(i in 10:30) Subject <- c(Subject, paste("Subject", "_", i, sep = ""))
  Subject_name <- Subject
  for(i in 1:5) Subject_name <- c(Subject_name, Subject)
  Subject_name <- sort(Subject_name)
  Activity <- sort(Activity)
  Activity_name <- Activity
  for(i in 1:29) Activity_name <- c(Activity_name, Activity)
  tidy_data <- cbind(Subject_name, Activity_name, group_tbl)
  write.csv(tidy_data, "tidy_data.csv")
  }