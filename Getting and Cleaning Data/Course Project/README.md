# Getting and Cleaning Data Course Project
This repo contains deliverables for the course project.

## Contents
* **run_analysis.R**		R script used to transform the data.  Script contains comments to help user understand the process.  In order to run the script, the data must be in the R root directory such that the following first line of the script will recognize the files properly: # Set home directory homeDir <- "./UCI HAR Dataset".  The script executes a process that performs the following steps in order to create the tidy data file:
 * Download source data to local environment
 * Read files into data frames
 * Combine like files at row level (test and training data)
 * Set friendly names
 * Combine files by adding columns together
 * Order data by subject and variable name
 * Select columns that include mean or std
 * Set friendly activity labels
 * Calculate average of each variable for each activity and each subject
 * Write data to a file

* **AveragedTidyData.txt**	Results of run_analysis.R where data is the final average of each variable for each activity and subject.

* **CodeBook.md**		Description of variables, data and transformations used to clean up the source data.

