#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# reads in a two column file with frequency of each entry and entry value
#---------------------------------------------------------------------

col.names <- c('freq', 'delay')
DF <- read.table("sorted_freq.txt", col.names = col.names, fill = TRUE)
w.total <- sum(DF[['freq']])  
print(w.total)

# compute the mean 
t.mean <- sum(DF[['freq']] * ( DF[['delay']] / w.total))

# have to find duplicate entries and combine them 
# compute the median 
t.median <- floor(w.total/2) 
 
