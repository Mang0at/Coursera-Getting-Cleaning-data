The script run_analysis.R has been created to create the output file as requested in the course project outline, seen in Readme.md


Variables:

These have been loaded from the supplied data set and named exactly as per the source files.

x_train, y_train, x_test, y_test, subject_train and subject_test

Variables have been created from merging the suplied source files:

x_data, y_data and subject_data

Steps:

Similar data is merged using the rbind() function where files are referencing the same x/y dimensions. 
Mean and standard deviation measures are extracted from the whole dataset and saved as their own variable. These are then are given the correct names, taken from an import of 'features.txt'.
We can match activity data with values 1:6 so the appropriate activity names as seen in 'activity_labels.txt'.
Any columns without clear column names are renamed to make them clearer.
A new dataset is generated with all the average measures for each subject and activity type named 'final_data.txt'

