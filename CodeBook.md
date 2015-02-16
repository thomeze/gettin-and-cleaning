This file describes the variables, the data, and  transformations  I have performed to clean up the data as requested.

The site where all the data can be found:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file run_analysis.R script performs the following:

1. Reads the files "y_test.txt", "y_train.txt" from the folder test
2. Reads the files "x_test.txt", "x_train.txt" from the folder train
3. Reads the files "subject_test.txt" from the test folder and "subject_train.txt" from the train folder
4. Reads the files "features.txt" and "activity_labels.txt" from the UCI folder.
5. Combines the files ""y_test.txt", "y_train.txt"
6. Combines the files ""x_test.txt", "x_train.txt"
7. Combines the files  "subject_test.txt", "subject_train.txt" 
8. Names the columns and combines all the previous variables from the files into one variable 
9. Substitutes some letters in columns so the data is more readable
10. Creates a new variable with the asked mean
11. Write a file with all the tidy data

