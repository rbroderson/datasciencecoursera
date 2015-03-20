# Set home directory
homeDir <- "./UCI HAR Dataset"

# Read files into data frames
activityTest <- read.table(file.path(homeDir, "test" , "y_test.txt" ),header = FALSE)
featuresTest <- read.table(file.path(homeDir, "test" , "X_test.txt" ),header = FALSE)
subjectTest <- read.table(file.path(homeDir, "test" , "subject_test.txt" ),header = FALSE)

activityTrain <- read.table(file.path(homeDir, "train" , "y_train.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(homeDir, "train" , "X_train.txt" ),header = FALSE)
subjectTrain <- read.table(file.path(homeDir, "train" , "subject_train.txt" ),header = FALSE)

# Combine like files at row level (test and training data)
activityComb <- rbind(activityTest, activityTrain)
featuresComb <- rbind(featuresTest, featuresTrain)
subjectComb <- rbind(subjectTest, subjectTrain)

# Set friendly names
features <- read.table(file.path(homeDir, "", "features.txt" ),header = FALSE)

names(activityComb) <- "activity"
names(featuresComb) <- features$V2
names(subjectComb) <- "subject"

# Combine files by adding columns together
combined <- cbind(subjectComb, activityComb, featuresComb)

# Order data by subject and variable name
ordered <- combined[order(combined[,2]), ]

# Select columns that include mean or std
selectFeatures <- features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]

columns <- c("activity", as.character(selectFeatures), "subject")

extractedColumns <- subset(ordered, select = columns)

# Set friendly activity labels
activityLabels <- read.table(file.path(homeDir, "", "activity_labels.txt" ),header = FALSE)

library("plyr")
mergedData <- mutate(merge(extractedColumns, activityLabels, by.x="activity", by.y=1,all=TRUE), activity = V2)

library("reshape2")
mergedData <- subset(mergedData, select = columns)

meltdata<-melt(mergedData, id=c("activity", "subject"))

# Calculate average of each variable for each activity and each subject
averaged<-dcast(meltdata, subject+activity~variable, mean)

