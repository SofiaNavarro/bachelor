# In this document I go through the necessary steps to
# calculate the median and IQR (interquartile range) of 
# the feature_data dataframe for each testperson in
# each of the four conditions: normal, harsh, whispery and creaky.


# first I load the necessary package and 
# the feature_data dataset
library(tidyverse)
load(file = "feature_data.R")


# The function below first groups the data by
# testperson, and then by voice quality.
# So, voice quality is nested in testperson.
# We are left with four rows for each testperson,
# each row corresponding to a voice quality.
# Lastly, the summarise function calculates the median of
# all the remaining variables.

my_data_median <- feature_data %>% 
  group_by(testperson, voice_quality) %>% 
  summarise_all(median)

# This function does exactly the same, except it
# caluclates the IQR (interquartile range) for all 
# variables.

my_data_IQR <- feature_data %>% 
  group_by(testperson, voice_quality) %>% 
  summarise_all(IQR)