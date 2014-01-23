#----------------------------------------------------------------------
# Author: Karen Ng <karenyng@ucdavis.edu>
# Method 3.R 
# Purpose: test what percentage we need to sample for us to be able to 
# compute statistics that is close enough to those of an exact approach
#----------------------------------------------------------------------
require(NotSoFastCSVSample)

# initialize some options 
dataDir <- "../../data_subset/"
samplePercent <- 0.05


files <- list.files(path = dataDir , pattern = "*.csv")

# can actually run these in parallel by splitting the files 
# in half for a dual core machine and have each cpu run half of the files 

# create empty dataframe to hold data ... 
# this might be stupid but I don't care I want to be done i want to be done
for(i in 1:length(files)){
  getNumLines()
  sampleNo <- as.integer(ceiling(filelength * samplePercent)) 
  print("sampling # line of lines = ")
  print(sampleNo)

  # try to tell the month-by-month csv apart from the year-by-year csv
  if (grepl("([0-9_]+)([A-Za-z]+).csv", files[i]))
  {
    print(paste("going through mnth-by-mnth csv", files[i]))
    temp <- csvSample(paste(dataDir, files[i], sep = ""), 
                      numRows = sampleNo, 
                      colName = "\"ARR_DELAY\"")
    print("sampled of lines is ")
    print(length(temp))
  }
  else 
  {
    print(paste("going through yr-by-yr csv", files[i]))
    temp <- csvSample(paste(dataDir, files[i], sep = ""), 
                      numRows = sampleNo, 
                      colName = "ArrDelay")
    print("sampled of lines is ")
    print(length(temp))

    # create a dataframe for appending later files 
    # if this is the first file being processed 
    if(i == 1)
      df <- temp
  }
  # append the later files to the first dataframe
  if(i != 1)
    df <- merge(df, temp)
}
print("mean")
print(mean(df, na.rm=T))
print("median")
print(median(df, na.rm=T))
print("std dev")
print(sd(df, na.rm=T))
