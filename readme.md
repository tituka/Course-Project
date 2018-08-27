# ReadMe

## Contents:
1. This readme.md file
2. Codebook
3. run_analysis.R file
4. Two versios of the tinydata file, just for fun

### Instructions:
1. Dowmload https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip it.
2. Open Rstudio (created using Version 1.1.456) and set the you working directory to where the above file was unzipped.
3.  run with:  source("run_analysis.R")

### About R script:
run_analysis.R  joins together the training and test sets  of data from Human Activity Recognition Using Smartphones Data Set by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.  (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
From this data, we select only those non-factor/character vector columns which include a mean or standard deviation in the variable name of the variable. 
Experiment subject and activity columns are merged into the same data frame, and descriptive row and column names are added, and some special characters are cleaned up from column names.
It then groups the data frame by subject and activity, and saves that as tinydata.txt.
Then the data frame is split into two new ones, so that the averages for subject and activity can be presented in the tidiest way I could think of after struggling for hours with what is extremely demotivating data where there is no joy of discovery when it’s just… why are we getting the means and standard deviations from this data, what is the significance of that? That is saved as tinydata.better.-
 