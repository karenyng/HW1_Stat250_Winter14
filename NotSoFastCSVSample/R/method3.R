#----------------------------------------------------------------------
# Author: Karen Ng <karenyng@ucdavis.edu>
# Method 3.R 
# Purpose: test what percentage we need to sample for us to be able to 
# compute statistics that is close enough to those of an exact approach
#----------------------------------------------------------------------
require(NotSoFastCSVSample)

# initialize some options 
dataDir <- "../../data_subset/"
samplePercent <- 1.
files <- list.files(path = dataDir , pattern = "*.csv")

# can actually run these in parallel by splitting the files 
# in half for a dual core machine and have each cpu run half of the files 

# create empty dataframe to hold data ... 
# this might be stupid but I don't care I want to be done i want to be done
for(i in 1:length(files)){
  filepath <- paste(dataDir, files[i], sep = "")
  filelength <- getNumLines(filepath)
  sampleNo <- as.integer(floor(filelength * samplePercent)) 

  # try to tell the month-by-month csv apart from the year-by-year csv

  if (grepl("([0-9_]+)([A-Za-z]+).csv", files[i]))
  {
    print(paste("going through mnth-by-mnth csv", files[i]))
    col.Name <- "\"ARR_DELAY\""
  }
  else 
  {
    print(paste("going through yr-by-yr csv", files[i]))
    col.Name <- "ArrDelay"
  }
  temp <- csvSample(filepath, numRows = sampleNo, 
                    colName = col.Name)
  print("sampled of lines is ")
  print(length(temp))

  # create a dataframe for appending later files 
  # if this is the first file being processed 
  if(i == 1)
    data <- temp
  else
    # wanna values 
    data <- c(data, temp)
}
print("mean")
print(mean(data))
print("median")
print(median(data))
print("std dev")
print(sd(data))
