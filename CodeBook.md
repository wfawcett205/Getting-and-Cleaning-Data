run_analysis <- function(...){}

It is assumed that you have successfully downloaded the UCI HAR Dataset using the link to the following web site:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1.   Install the following libraries
 	i)  library(plyr)
 	ii) library(dplyr)
  
2. Read-in the UCI HAR Dataset (8 files)
     	   i)("./UCI HAR Dataset/features.txt")
	  ii)("./UCI HAR Dataset/activity_labels.txt")
 	 iii)("./UCI HAR Dataset/test/subject_test.txt")
	  iv)("./UCI HAR Dataset/test/x_test.txt")
	   v)("./UCI HAR Dataset/test/y_test.txt")
  	  vi)("./UCI HAR Dataset/train/subject_train.txt")
	 vii)("./UCI HAR Dataset/train/x_train.txt")
	viii)("./UCI HAR Dataset/train/y_train.txt")
  
3. Generate two data sets: test_db and train_db using cbind().
 	Note: the order of combinding the appropriate objects is
	"subject/y/x".
 
4. Assign column names to the two data sets as follows:
	Column 1: "Subject"
	Column 2: "Activity"
	Column 3-563: Values from features.txt
  
5. Write data sets to file: "test_db.csv","train_db.csv".
  
6. Combine the two data sets into data_set using rbind	().
 
7. Using a series of for statements assign the descriptive 	activity labels to data_set. 

8. Write data_set to file: "data_set.csv"
  
9. Subset data_set using "grep" to select columns that contain           	either "mean" or "std".

10. Assign this new data set to new_db.

11. Assign appropriate column names.

12. Sort new_db on the 1st and 2nd columns.

13. Reset the rownames.

14. Write new_db to file: "new_db.csv".
  
15. For each Subject and Activity determine the mean for each 	column and assign the results to a vector: Group_i. There 	will be a total of 86 vectors: num[1:180]. The function 	tapply() is useful.

16. Combine the individual vectors into a single table (grp_tbl)	using rbind().

17. Transpose grp_tbl using t(), assign to group_tbl, and declare 	as data.frame. The dimensions will be 180 obs. of 86 	variables.

18. Assign descriptive variable labels, eg. column names.

19. Generate a vector (Subject) that contains the following:
	Subject_01, Subject_02, ...Subject_30. Concatenate five(5) 	times and sort.

20. Generate a vector (Activity) that contains the descriptive 	labels from "activity_labels.txt". Concatenate twenty-nine 	(29) times and sort.
  
21. Create the tidy_data set with cbind():
	Set 1: Subject
	Set 2: Activity
	Set 3: group_tbl

22. Write tidy_data to file: "tidy_data.csv"

