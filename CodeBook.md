# Getting and Cleaning Data Course Project

José J. Herrera S.

## Introduction
The `run_analysis.R` script follows the 5 steps indicated in the assignment of the Course "Getting and Cleaning Data":

* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* 3. Uses descriptive activity names to name the activities in the data set.
* 4. Appropriately labels the data set with descriptive variable names.
* 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data Source
The data set was downloaded frome [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datase)
and a description of the data can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data sets
The following datasets were assigned to different variables:

* `activity_labels.txt` -> `actividades`      : a 6 by 2 matrix containing the activities description and its corresponding ID.
* `features.txt`        -> `medidas`          : a 561 by 2 matrix containing the features names in the second column.
* `X_train.txt`         -> `train`            : a 7352 by 561 matrix containing the observations for each feature in the training data set.
* `Y_train.txt`         -> `trainActividades` : a 7352 by 1 matrix containing the activities ID for each observation in the training data set.
* `subject_train.txt`   -> `trainSujetos`     : a 7352 by 1 matrix containing the subject ID for each observation in the training data set.
* `X_test.txt`          -> `test`             : a 2947 by 561 matrix containing the observations for each feature in the test data set.
* `Y_test.txt`          -> `testActividades`  : a 2947 by 1 matrix containing the activities ID for each observation in the test data set.
* `subject_test.txt`    -> `testSujetos`      : a 2947 by 1 matrix containing the subject ID for each observation in the test data set.

## Other variables in the script
* `archivoURL`    : the link to download the files.
* `nombrearchivo` : the name of the downloaded file.
* `directorio`    : the working directory.
* `datos`         : the unique merged data set.
* `promedios`     : the second independent tidy data set with the average of each variable for each activity and each subject.

## What does the script?

1. From line 21 to 22, cleans the workspace and install the necessary packages.
2. From line 26 to 43, basically creates and sets the working directory (if necessary), and then download the data and unzip it.
3. From line 46 to 60, reads and imports the needed `.txt` files.
4. **From line 64 to 67, merges all the files in one data set called `datos`.**
5. From line 70 to 71, assigns the features names as column names to the variable `datos`.
6. **From line 74 to 75, extracts only the `mean()` and `std()` measurements.**
7. **From line 78 to 79, assigns descirptive activity names to the `Activity` column according to the activity ID.**
8. **From line 82 to 93, labels the data set columns with descriptive variable names, using `gsub()`.**
9. **In line 96, creates a new tidy data set containing avarage values for each activity and each subject using `ddply`.**
10. From line 99 to 100, exports the new data set to a `.txt` file called `averages.txt`.