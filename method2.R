#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# R wrapper around python code so there would be consistent profiling 
#---------------------------------------------------------------------
time.method2 <- system.time(system("./compute_stat.py"))
# read in results from python script
con = file("./results2.txt","r")
results2 <- readLines(con)
save(results2, time.method2, file="results2.rda")

