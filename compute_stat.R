#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# reads in a two column file with frequency of each entry and entry value
#---------------------------------------------------------------------

run <- function(){
  col.names <- c('freq', 'delay')
  print("compute_stat.R: ")
  print("computing and reading in sorted frequency table from bash script")
  # call the shell script for cutting columns and doing frequency count 
  DF <- try(read.table(pipe("./freq_count.sh"), col.names = col.names, 
                            fill = TRUE), silent=TRUE)
  if (class(DF) == "try-error"){
    print("ERROR: failed to read in $PWD/data/*.csv") 
    print("USAGE: place data in $PWD/data/*.csv for this script to work")
    q("no", 1, FALSE)
  }
  # REMOVE NAN!!! 
  DF <- na.omit(DF)

  print("compute_stat.R")
  print("this takes ~8 min for a single core with clockspeed ~3.2 GHz")
  print("compute_stat.R: computing total frequencies")
  w.total <- sum(DF[['freq']])  

  print("compute_stat.R: computing mean")
  t.mean <- sum(DF[['freq']] * ( DF[['delay']] / w.total), na.rm = TRUE)

  print("compute_stat.R: computing median")
  i <- 1
  Sum <- DF[['freq']][i]
  medianFreqCount <- floor(w.total / 2) 
  ## sorry don't know better than to write a loop...
  while(Sum < medianFreqCount) { 
    i <- i + 1 
    # this vectorized operation 
    Sum <- sum(DF[['freq']][1:i], na.rm = TRUE)
    # is faster than 
    ## if ( !is.na(DF[['freq']][i]) ) {
    ##   Sum <- Sum + DF[['freq']][i] 
    ## }
  }
  ## check for corner case:  
  ## or else there the median will may be off  
  if( Sum == medianFreqCount &&  w.total %% 2 == 0){
    # print("going through special case")
    t.median <- (DF[['delay']][i] + DF[['delay']][i+1])/2   
  }else{
    t.median <- DF[['delay']][i]
  }

  # after reading Jook Cook 's entry on computation of std. dev
  # I decide to go with the (two-pass) direct method  because this can be 
  # written entirely in vectorized form
  std.dev <- sqrt(sum(DF[['freq']] * (DF[['delay']] - t.mean) ^ 2 / (w.total-1))) 
  results <- c(t.mean, t.median, std.dev)
  #print(results)
  results
}
 
timeTaken <- system.time(results <- run())
#CPUtime <- timeTaken[["sys.child"]]
code <- c("compute_stat.R", "freq_count.sh") 
shell.command <- 'Rscript compute_stat.R'
csvfiles <- c("uncompressed csv of
              http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2")

RESULTS1 <- list(time = timeTaken, results = results, system = Sys.info(),
     session = sessionInfo(), files = csvfiles, run.command =
     shell.command, code = code) 
save(RESULTS1, file="results1.rda")
