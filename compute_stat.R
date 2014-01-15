#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# reads in a two column file with frequency of each entry and entry value
#---------------------------------------------------------------------

col.names <- c('freq', 'delay')
print("reading sorted frequency table")
# call the shell script for cutting columns and doing frequency count 
DF <- read.table(pipe("./freq_count.sh"), col.names = col.names, fill = TRUE)
DF <- na.omit(DF)

print("computing total frequencies")
w.total <- sum(DF[['freq']])  
print(w.total)

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
# have to check if the total frequency count is odd or even
# or else there the median will be off by 1    
t.median <- DF[['delay']][i]

# after reading Jook Cook 's entry on computation of std. dev
# I decide to go with the (two-pass) direct method  because this can be 
# written entirely in vectorized form
std.dev <- sum( DF[['freq']] * (DF[['delay']] - t.mean)^2 / (w.total-1) )  

print(t.mean)
print(t.median)
print(std.dev)
 
list(mean = t.mean, median = t.median, sd = std.dev)
