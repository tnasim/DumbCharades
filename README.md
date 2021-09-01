# Dumb Charades
The ultimate goal of this project is to develop a procedure to identify human gestures which includes: 

a) Identifying known gestures 
b) Segment sequence of gestures 
c) Identifying unknown gestures

## Data
The data contains numerical values collected from visual and other tools (gyroscope etc.) for different human gestures.
## Methods
We calculated the accuracy, precision, recall and F1 score of all the groups combined together. In this phase we will be calculating the same performance metrics for each user. We consider the 14 groups whose data was found to be valid. The valid groups have been selected by observing the raw data and plotting the raw data. Groups with more than 46 timestamps for any gesture were eliminated along with the outliers or anomaly.

We classify the data using Decision Tree, SVM and Neural Networks and compare their performance for each user. We have mainly measured the performance based on the following criteria: 
• Accuracy 
• Precision 
• Recall 
• F1 Score

NOTE : We had calculated the performance metrics for all users combined in the Assignment 3. The performance metrics for each group has been calculated in Assignment 4 of the project.


This is a project done as part of CSE 572 Data Mining course, Arizona State University, under Dr. Ayan Banerjee.
