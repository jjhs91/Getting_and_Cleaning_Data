######################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Jose J. Herrera S.
## run_analysis.R script

## Following the assignment indications, this script:

# Download the requiered data sets and load it into R
# 1. Merges the training and test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the
#    average of each variable for each activity and each subject.

######################################################################################################


# Clean workspace and load necessary packages
remove(list = ls())
library(plyr)

# Create and set working directory
# Download and unzip file
archivoURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
nombrearchivo <- "datos.zip"
directorio <- paste(getwd(), "/DaCD_CP", sep = "")
if (getwd() != directorio) { 
        if (!dir.exists(directorio)) {
                dir.create(directorio)
                setwd(directorio)
                download.file(archivoURL, nombrearchivo)
        } else {
                setwd(directorio)
                if (!file.exists(nombrearchivo)) {
                        download.file(archivoURL, nombrearchivo) 
                }
        }
}
remove(archivoURL)
unzip(nombrearchivo)
remove(nombrearchivo)

# Read and imports activity_labels and features data
actividades <- read.table("UCI HAR Dataset/activity_labels.txt")
actividades <- actividades[, 2]
medidas <- read.table("UCI HAR Dataset/features.txt")
medidas <- as.character(medidas[, 2])

# Read and imports train data set, corresponding train activities and subjects
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActividades <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSujetos <- read.table("UCI HAR Dataset/train/subject_train.txt")


# Read and imports test data set, corresponding test activities and subjects
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testActividades <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSujetos <- read.table("UCI HAR Dataset/test/subject_test.txt")


# 1. Merges train and test data sets with their corresponding activities and subjects
train <- cbind(trainSujetos, trainActividades, train)
test <- cbind(testSujetos, testActividades, test)
datos <- rbind(test, train)
remove(trainActividades, trainSujetos, testActividades, testSujetos, train, test)

# Assigns names to data set columns
medidas <- c("Subject", "Activity", medidas)
colnames(datos) = medidas

# 2. Extracts only the columns containing "mean()" and "std()" (ignore Freqmean() columns)
medidas <- c("Subject", "Activity", grep("mean\\(\\)|std", medidas, value = TRUE))
datos <- datos[, medidas]

# 3. Assigns descriptive activity names to the "Activity" column
datos[, 2] <- actividades[datos[, 2]]
remove(medidas, actividades)

# 4. Label columns with descriptive variable names
colnames(datos) <- gsub("^t", "Time_", colnames(datos))
colnames(datos) <- gsub("^f", "Frequency_", colnames(datos))
colnames(datos) <- gsub("Body", "Body_", colnames(datos))
colnames(datos) <- gsub("Gravity", "Gravity_", colnames(datos))
colnames(datos) <- gsub("Acc", "Accelerometer_", colnames(datos))
colnames(datos) <- gsub("Gyro", "Gyroscope_", colnames(datos))
colnames(datos) <- gsub("Jerk", "Jerk_", colnames(datos))
colnames(datos) <- gsub("Mag", "Magnitude_", colnames(datos))
colnames(datos) <- gsub("-", "", colnames(datos))
colnames(datos) <- gsub("mean", "Mean_", colnames(datos))
colnames(datos) <- gsub("std", "StandardDeviation_", colnames(datos))
colnames(datos) <- gsub("\\()", "", colnames(datos))

# 5. Creates a new tidy data set containing avarage values for each activity and each subject
promedios <- ddply(datos, .(Subject, Activity), function(datos) colMeans(datos[, 3:68]))

# Exports the new data set
write.table(promedios, "averages.txt", row.name=FALSE)
paste("the averages.txt file is in", directorio)