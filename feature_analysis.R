# This shows step by step, how to merge multiple data sets in .csv format
# This can be done because all the datasets have the same structure, i.e
# the same amount of columns and the same column names.


# Load the necessary packages

library(tidyverse)

# Make a function that lists the names of the target .csv files in the directory

feaname <- list.files(path = "./acoustic_features_csvfiles", pattern = "*.csv")


# Use the lapply function to make a list of all the .csv files contained in
# the directory. This is a quick and smart way of loading 
# all the datafiles simultaneously.

lfeatures <- lapply(feaname, function(x) read.csv(paste0("./acoustic_features_csvfiles/",x)))



#----------------------------------------------
  # This function creates two new columns in the dataset
  # one indicating the recorded voice quality
  # and one indicating the code-name for the individual who produced the 
  # recording
  
  for(i in 1:length(lfeatures)){  # loop the function over each row of the list of 80 .csv files
    
    split_name <- strsplit(feaname[i], "\\_",)[[1]] # split the names of the files 
                                                    # into voice quality and code-name
    
    voice_quality <- gsub(pattern = ".csv", replacement = "", split_name[2]) # removes "csv" from filename 
                                                                             # and prints out the voice quality
    
    testperson <- split_name[1] # prints out the code-name for the testperson
    
    lfeatures[[i]]$voice_quality <- voice_quality # Create new column, name it voice_quality
    
    lfeatures[[i]]$testperson <- testperson # create a new column, name it individual
    
  }


# Merge the rows from the individual datasets using bind_rows
# This creates one large dataset consisting of the combination of all
# 80 .csv files 

feature_data <- bind_rows(lfeatures)

# This saves the dataset
# So I can load it directly in another .R document
save(feature_data, file = "feature_data.R")
