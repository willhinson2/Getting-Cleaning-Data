library(dplyr)

### Downloading the Data
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./getcleandata/projectdataset.zip")

### Unzipping the Data
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

### Assigning Variables for Test & Training Data
features <- read.table("./getcleandata/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity <- read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
sub_test <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt", col.names = "code")
sub_train <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt", col.names = "code")

### Merging X, Y & Sub Data Together

combined_x <- rbind(x_test, x_train)
combined_y <- rbind(y_test, y_train)
combined_sub <- rbind(sub_test, sub_train)


### Removing the Mean and Standard Dev. Measurements for Each Activity
features_mod <- features[grep("mean|std",features[,2]),]
combined_x <- combined_x[,features_mod[,1]]

### Naming the Activities in the Dataset
colnames(combined_y) <- "label"
combined_y$activities <- factor(combined_y$label, labels = as.character(activity[,2]))
activities <- combined_y[,-1]

### Labeling the Dataset with Descriptive Names

colnames(combined_x) <- features[features_mod[,1],2]

### Creating a Tidy Dataset with the Mean Values for Each Variable

colnames(combined_sub) <- "subject"
totals <- cbind(combined_x, activities, combined_sub)
combined_mean <- group_by(totals, activities, subject)
final_mean <- summarize_all(combined_mean, funs(mean))
write.table(final_mean, file = "./getcleandata/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)









