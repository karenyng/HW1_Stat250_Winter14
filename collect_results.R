#----------------------------------------------------------------------
# Author: Karen Ng 
# Purpose: 
# write all the results into one big rda file 
#---------------------------------------------------------------------

# load back the results from each method
method1.result <- load("results1.rda") 
method2.result <- load("results2.rda") 
method3.result <- load("results3.rda") 

code1 <- c("method1.R", "freq_count.sh") 
code2 <- c("method2.R", "compute_stat.py") 
code3 <- c("method3.R", "NotSoFastCSVSample") 

shell.command1 <- 'Rscript method1.R'
shell.command2 <- 'Rscript method2.R'
shell.command3 <- 'Rscript method3.R'

csvfiles <- 
c("uncompressed csv of 
  http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2")

machine.specs <- c(RAM = 
                   "Corsair Vengeance 2x8GB DDR3 1600 MHz Desktop Memory",
                   CPU = 
                   "Intel(R) Core(TM) i7-4770K CPU @ 3.50GHz Quad Core",
                   Motherboard = 
                   "Motherboard: Asus Z87-Deluxe DDR3 1600 LGA 1150",
                   HD = 
                   "Western Digital 2TB unknown RPM")

method1 <- "Shell to compute entire frequency table then use R to compute statistics"
method2 <- "Python with the use of pandas and numpy python modules.
            The file method2.R is a wrapper to call the R profiler for
            giving consistent timing for my python code"
method3 <- "forked Duncan's FastCSVSample package and added R code to it
            hard coded sampling options..."

method2.dependency <- "Python v. 2.7.4, numpy v.1.7.1, pandas v.0.10.1"
method3.dependency <- "forked R package NotSoFastCSVSample"
author <- '(Karen) Yin-Yee Ng <karenyng@ucdavis.edu>'

RESULTS <- list(method1 = method1, time.method1 = time.method1, results1 = results1, 
                 method2 = method2, time.method2 = time.method2, results2 = results2,
                 method3 = method3, time.method3 = time.method3, results3 =
                 results3,
                 system = Sys.info(), session = sessionInfo(), files = csvfiles, 
                 run.command1 = shell.command1, code1 = code1, 
                 run.command2 = shell.command2, code2 = code2,
                 run.command3 = shell.command3, code2 = code3,
                 method2.dependency = method2.dependency,
                 method3.dependency = method3.dependency,
                 machine.specs = machine.specs, author = author) 

save(RESULTS, file="results.rda")
