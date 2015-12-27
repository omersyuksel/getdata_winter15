#Code Book
This code book describes the variables and their values in the dataset (tidy_sum.txt). 

###Overview
There are three categories of variables: identifiers, measurements, and values. 
- *Identifiers* describe the subjects and activities in the experiment. 
- *Measurements* describe aspects of the features in the raw data (from features.txt), such as the dimension, time or frequency domain, or the device used. 
- *Values* are (numeric) outcomes of the measurements.

The summarized data is grouped by the identifiers and measurements, hence the "Group." prefix in their names. The values are averaged by these groups.

(note that the data is in narrow form)


##Identifiers
**Group.subject**
- **Type**: nominal
- **Description**: identifier of each subject in the experiment.
- **Values**: Integers in the range [1,30]

**Group.activity**
- **Type**: nominal
- **Description**: activity performed by the subject.
- **Values**: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

##Measurements
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
  
 
##Values
**meanvalue**
- **Type**: numeric
- **Description**: average normalized value.
- **Remarks**: Mean value per measurement, activity, and subject. Since the data is in narrow form, see the "measurements" part describing the type of the value. The values have no units since they are normalized.
- **Values**: real numbers in range [- 1, 1]