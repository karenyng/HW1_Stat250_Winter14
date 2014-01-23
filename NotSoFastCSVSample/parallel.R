library(parallel)
library(FastCSVSample)

numCores = 7
cl = makeCluster(numCores, type = "FORK")
invisible(clusterEvalQ(cl, library(FastCSVSample)))
clusterSetRNGStream(cl, 124123)


files = list.files("~/Data/Airlines", pattern = "^[12].*.csv$", full.names = TRUE)

counts = clusterApplyLB(cl, files, FastCSVSample:::getNumLines)
system.time(system("wc -l ~/Data/Airlines/[12]*.csv"))  
# on jasper
#  13.57 seconds versus 2.33 seconds with the cluster

# We could use the counts to arrange for a truly random sample 
# across the files rather than the same number from each file.
# e.g.   
if(FALSE) {
   N = sum(unlist(counts))
   n = 100*length(files)
    # idx = sample(1:N, n)
    # like not to have to create 1:N, so 
   idx = ceiling(runif(n, 0, N))
     # now we have to figure out which observations
     # go with which files
  breaks = cumsum(unlist(counts))
  gr = cut(idx, c(0, breaks), labels = files)

  lineNums = mapply(function(vals, start)
                      vals - start,
                    split(idx, gr), c(0, breaks[-length(breaks)]))

  # Check the numbers make sense
  mapply(function(nums, max) all(nums > 0 & nums <= max), lineNums, counts)

 # so now we can send these with the filenames
 # We need a single element with the line numbers and file name
 # so that we can use clusterApplyLB() or parLapply()
 tasks = mapply(function(vals, file)
                  list(lineNums = vals, file = file),
                lineNums, names(lineNums), SIMPLIFY = FALSE)

 lines = clusterApplyLB(cl, tasks,
                        function(task) 
                           csvSample(task$file, rows = task$lineNums))
}


# Sample the same number from each file, e.g. 100
clusterApplyLB(cl, files, csvSample, 100)



