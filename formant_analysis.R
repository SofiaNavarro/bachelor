# This shows step by step, how to merge multiple data sets in .csv format
# This can be done because all the datasets have the same structure, i.e
# the same amount of columns and the same column names.

# Load the necessary packages

library(tidyverse)

# Make a function that lists the names of the target .csv files in the directory

forname <- list.files(path = "./formant_peaks", pattern = "*.csv")


# Use the lapply function to make a list of all the .csv files contained in
# the directory. This is a quick and smart way of loading 
# all the datafiles simultaneously.

lformants <- lapply(forname, function(x) read.csv(paste0("./formant_peaks/",x)))


#--------------------------------------

# This function creates two new columns in the dataset
# one indicating the recorded voice quality
# and one indicating the code-name for the individual who produced the 
# datrecording


for(i in 1:length(lformants)){    # loop the function over each row of the list of 80 .csv files
  split_name <- strsplit(forname[i], "\\_",)[[1]] # split the names of the files
                                                  # into voice quality and code-name

  voice_quality <- gsub(pattern = ".csv", replacement = "", split_name[2]) # removes "csv" from the name
                                                                           # and prints out the voice quality

  testperson <- split_name[1] # prints out the code-name for the testperson


  lformants[[i]]$voice_quality <- voice_quality # Create new column, name it voice_quality

  lformants[[i]]$testperson <- testperson # create a new column, name it individual

  
}


# Merge the rows from the individual datasets using bind_rows
# This creates one large dataset consisting of the combination of all
# 80 .csv files 

formant_data <- bind_rows(lformants)

