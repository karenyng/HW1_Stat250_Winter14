#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# reads in a two column file with frequency of each entry and entry value
#---------------------------------------------------------------------

col.names <- c('freq', 'delay')
print("reading sorted frequency table")
DF <- read.table("sorted_freq.txt", col.names = col.names, fill = TRUE)
print("computing total frequencies")
w.total <- sum(DF[['freq']], na.rm = TRUE)  
print(w.total)

# compute the mean 
print("computing mean")
t.mean <- sum(DF[['freq']] * ( DF[['delay']] / w.total), na.rm = TRUE)
print(t.mean)

# have to find duplicate entries and combine them 
# or have to do something more complicated to compute the median 
median.index  <- floor(w.total/2) 

 
