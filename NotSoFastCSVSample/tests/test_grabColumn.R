#dyn.load("/src/csvSampler.so")
require(NotSoFastCSVSample)

# ideally this would get pandas and my R code to compare their 
# grabbed column but seems like it is currently quite slow to get this
# working
#checkagainst <- read.csv("./2008_May_col.txt") 
line <- csvSample("./2008_May.csv", 60, colName = "\"ARR_DELAY\"")
print(mean(line))


