#Code Book
This code book describes the variables and their values in the dataset (tidy_sum.txt), and the steps taken by the script to create a tidy dataset.

##Variables
There are three categories of variables: identifiers, measurements, and values. 
- *Identifiers* describe the subjects and activities in the experiment. 
- *Measurements* describe aspects of the features in the raw data (from features.txt), such as the dimension, time or frequency domain, or the device used. 
- *Values* are (numeric) outcomes of the measurements.

The summarized data is grouped by the identifiers and measurements, hence the "Group." prefix in their names. The values are averaged by these groups.

(note that the data is in narrow form)


###Identifiers
**Group.subject**
- **Type**: nominal
- **Description**: identifier of each subject in the experiment.
- **Values**: Integers in the range [1,30]

**Group.activity**
- **Type**: nominal
- **Description**: activity performed by the subject.
- **Values**: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

###Measurements
**Group.domain**
- **Type**: nominal
- **Description**: the domain of the measurements.
- **Values**: time, frequency

**Group.varcategory**
- **Type**: nominal
- **Description**: categories of the measurements.
- **Values**: BodyBodyJerkMagnitude, BodyJerkMagnitude, BodyMagnitude, GravityMagnitude, BodyBodyMagnitude, Body, BodyJerk, Gravity  

**Group.device**
- **Type**: nominal
- **Description**: device used for measuring.
- **Values**: Accelerometer, Gyroscope

**Group.dimension**
- **Type**: nominal
- **Description**: dimension of the measurement, if applicable
- **Values**: X, Y, Z, NoDimension

**Group.sumtype**
- **Type**: nominal
- **Description**: the function used to summarize the (raw) data in the experiment.
- **Values**: 
  - Mean
  - Stdev: standard deviation
 
###Values
**meanvalue**
- **Type**: numeric
- **Description**: average normalized value.
- **Remarks**: Mean value per measurement, activity, and subject. Since the data is in narrow form, see the "measurements" part describing the type of the value. The values have no units since they are normalized.
- **Values**: real numbers in range [- 1, 1]


##Data cleaning steps
The script loads raw data from training and test data files in the project, merges them into a single dataset, selects the mean() and std() variables from the original dataset, and creates tidy data in narrow form (one measurement per row) with more understandable variable names.

**A detailed overview of the steps**:
- Load the feature labels from file.
- Assign more explicit labels to features by using regular expressions, e.g. "t" -> "time", "f" -> "frequency", "gyro" -> "Gyroscope", etc.
- Remove special characters such as dashes, commas and parantheses from feature labels.
- Load data from different files and perform column- wise merging:
  - Load X_train, Y_train, X_test, Y_test. 
  - Combine X and Y values together to create "train" and "test" data frames.
  - Load subject data for training and test.
  - Append "subject" as a column in the corresponding "train" and "test" data frames.
- Now we should have training and test data frames with all columns we need. We can start row- wise merging.
  - Combine "train" and "test" data frames together using cbind.
- Now we have a single data frame to play with and can work on making it more readable.
- Discard all "X" columns except those with mean() and std() in the labels.
- Load activity labels from file and use this to make activity column human- readable.
  - Convert the column into a factor with corresponding labels.
- Create a narrow form dataset by using the 'melt' command.
  - Choose 'subject' and 'activity' as identifiers, and the rest as variables.
- However, the variable labels are not very readable and they try to describe multiple aspects in a single variable, e.g. the device, the XYZ dimension, mean or standard deviation, etc.
  - This violates the 'one variable per column' principle.
  - We can break the 'variable' column down into multiple columns describing an aspect of the measurement, thereby making it more readable.
- Using regular expressions, we can create columns for: Dimension (XYZ), Device(Acc. or Gyroscope), Summary Type(Mean or Standard dev.), Domain(Time or Frequency) and Measurement Category(Body, Gravity, etc.) from the single `variable' column.
  - Note that this does not affect the rows in any way, it just helps reading the data.
- Finally, summarize the dataset using aggregate function.
  - Also remove the "excess" columns no longer required after the operation.
- We write the summarized dataset into the file "tidy_sum.txt"
