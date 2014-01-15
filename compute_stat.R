#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# reads in a two column file with frequency of each entry and entry value
#---------------------------------------------------------------------

run <- function(){
  col.names <- c('freq', 'delay')
  print("computing and reading in sorted frequency table from SHELL")
  print("this takes ~3 min for a single core with clockspeed ~3.2 GHz")
  # call the shell script for cutting columns and doing frequency count 
  DF <- read.table(pipe("./freq_count.sh"), col.names = col.names, fill = TRUE)
  DF <- na.omit(DF)

  print("computing total frequencies")
  w.total <- sum(DF[['freq']])  

  print("computing mean")
  t.mean <- sum(DF[['freq']] * ( DF[['delay']] / w.total), na.rm = TRUE)

  print("computing median")
  medianFreqCount <- floor(w.total/2) 
  i <- 1
  Sum <- DF[['freq']][1]

  # sorry don't know better than to write a loop...
  while( Sum < medianFreqCount) { 
    i <- i + 1 
    # this vectorized operation 
    Sum <- sum(DF[['freq']][1:i], na.rm = TRUE)
    # is faster than 
    ## if ( !is.na(DF[['freq']][i]) ) {
    ##   Sum <- Sum + DF[['freq']][i] 
    ## }
  }
  # check for corner case:  
  # or else there the median will may be off  
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
CPUtime <- timeTaken[["sys.child"]]
files <- c("compute_stat.R", "freq_count.sh") 
run.command <- 'source ("compute_stat.R")'

RESULTS1 <- list(time = CPUtime, results = results, system = Sys.info(),
     session = sessionInfo(), files = files, run.command = run.command) 
save(RESULTS1, file="results1.rda")
