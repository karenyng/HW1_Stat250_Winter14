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
# compute the median 
# t.median  <- floor(w.total/2) 
 
