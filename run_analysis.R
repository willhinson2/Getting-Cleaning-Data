library(dplyr)

# Downloading the dataset
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./getcleandata/projectdataset.zip")

# Unzipping the dataset
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

