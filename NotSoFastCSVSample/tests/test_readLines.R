dyn.load("csvSampler.so")
source("csvSample.R")

stopifnot(identical(readLines("mtcars.csv")[c(2, 4, 8) + 1], readLines("mtcars.csv")[c(2, 4, 8) + 1]))

