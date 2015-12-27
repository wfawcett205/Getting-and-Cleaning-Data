# Getting-and-Cleaning-Data
Repository for Coursera Getting and Cleaning Data Unit

The UCI HAR Dataset has valuable information in its README file and that information will not be repeated here.

In brief, run_analysis.R reads eight (8) data files and stores them as local objects. 

The first objective of the assignment was to create a single data set from the information in the 8 data files. This was accomplished by first creating two (2) smaller data sets, test_db and train_db, using cbind(). A single data set (data_set) was then created by joining test_db and train_db with rbind(). Dimensions (10299 x 563).

The second objective was completed using grep() which allows for the use of "wildcards" In this instance it permitted the determination (as column numbers) of those columns that had either "mean" or "std" as part of the name. The use of ignore.case = TRUE permitted all versions to be identified. With a subsequent FOR statement, a smaller data set, new_db, was obtained. Dimensions (10299 x 88).

The third and fourth objectives (assigning descriptive activity names and variable (column) names) are actually performed for both data_set and new_db using simple substitution statements. 

The fifth objective required the use of multiple condition statements strung together. In brief, new_db is ordered on the first two columns ("Subject" and "Activity"). Using tapply() the mean of each activity (eg. "LAYING") for each subject is determined for columns 3-88. Since there were 30 subjects in all and 6 activities; a total of 86 vectors with 180 observations are obtained. These vectors are then joined using rbind and the resulting table is transposed and declared a data.frame (group_tbl).

The final data set, tidy_data, is created by joining "Subject_name", "Activity_name" and "group_tbl". Dimensions (180 x 88).

  