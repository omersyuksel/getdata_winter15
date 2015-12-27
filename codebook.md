#Code Book
This code book describes the variables and their values in the dataset (tidy_sum.txt). 

###Overview
There are three categories of variables: identifiers, measurements, and values. 
-Identifiers describe the subjects and activities in the experiment. 
-Measurements describe aspects of the variables in the raw data, i.e. time or frequency domain, dimension, etc. 
-Values are the numbers pertaining to each measurement.

The summarized data is grouped by the identifiers and measurements, hence the "Group." prefix in the variable names.

(note that the data is in narrow form)


##Identifiers
*Group.subject*
-*Type*: nominal
-*Description*: identifier of each subject in the experiment.
-*Values*: Integers in the range [1,30]
-*Remarks*

*Group.activity*
-*Type*: nominal
-*Description*: activity performed by the subject.
-*Values*: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

##Measurements
*Group.domain*
-*Type*: nominal
-*Description*: the domain of the measurements.
-*Values*: time, frequency

*Group.varcategory*
-*Type*: nominal
-*Description*: categories of the measurements.
-*Values*: BodyBodyJerkMagnitude, BodyJerkMagnitude, BodyMagnitude, GravityMagnitude, BodyBodyMagnitude, Body, BodyJerk, Gravity  

*Group.device*
-*Type*: nominal
-*Description*: device used for measuring.
-*Values*: Accelerometer, Gyroscope

*Group.dimension*
-*Type*: nominal
-*Description*: dimension of the measurement, if applicable
-*Values*: X, Y, Z, NoDimension

*Group.sumtype*
-*Type*: nominal
-*Description*: the function used to summarize the data in the experiment.
-*Values*: 
  -Mean
  -Stdev: standard deviation
  
 
##Values
*meanvalue*
-*Type*: numeric
-*Description*: average normalized value.
-*Remarks*: Mean value per measurement, activity, and subject. Since the data is in narrow form, see the "measurements" part describing the type of the value. Due to normalization, the values have no units.
-*Values*: real numbers in range [-1, 1]