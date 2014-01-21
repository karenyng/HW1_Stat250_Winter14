#dyn.load("/src/csvSampler.so")
require(NotSoFastCSVSample)

csvSample("./2008_May.csv", 60620, colName = "\"ARR_DELAY\"")
#csvSample("./1987.csv", 1, colName = "ArrDelay")


