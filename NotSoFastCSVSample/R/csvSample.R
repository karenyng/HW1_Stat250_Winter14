
#@example  tt = csvSample("~/Data/Airline/Airlines/2002.csv", 100)
#          read.csv(textConnection(tt), header = FALSE)
csvSample =
function(file, n, rows = sample(1:numRows, n),
         numRows = getNumLines(file),
         randomize = FALSE, header = TRUE, colName = NULL)
{
  file = path.expand(file)
  if(!file.exists(file))
    stop("file does not exist")

  rows = sort(as.integer(rows))
  if(header)
    rows = rows + 1L

  ans = .Call("R_csv_sample", file, rows)
  names(ans) = rows

  if(header & !is.null(colName))
    ans <- getCol(file, colName, ans)

  if(randomize)
    sample(ans)
  else
    ans
}

getNumLines =
function(file)
{
  txt = system(sprintf("wc -l %s", file), intern = TRUE)
  as.integer(gsub("^ ?([0-9]+) .*", "\\1", txt))
}

getColNum = 
function(file, colName)
{ 
  colNum <- -99L
  csvHeader <- system(sprintf('head -1 %s | tr "," "\n"', file), 
                      intern = TRUE)
  for(i in 1:length(csvHeader))
  {
    if(csvHeader[[i]] == colName)
    # not sure if this is the best way to do string comparison in R
    #if(grepl(csvHeader[[i]], colName) & !grepl("^$", csvHeader[[i]]))
    {
      colNum <- i 
      #print(paste("found ", colName, " at column", colNum))
      break
    }
  }
  if(colNum == -99L)
    stop(paste(colName, "does not exist in the csv header"))

  colNum
}

getCol = 
function(file, colName, ans)
{
  colNum <- getColNum(file, colName)  
  ans <- extractCol(colNum, ans, colName) 
}

extractCol=
function(colNum, ans, colName)
# have not found time to write a fancy one that would match the double quotes 
# in the csv intelligently
# if there is time, should write one that compares consecutive elements 
# in the split list to see if \" and \" has been split between two elements
# then join them back together
# ideally this should also be written in C or C++ for speed 
{
  splitAns <- strsplit(ans, ",")
  if (colName == '\"ARR_DELAY\"') 
  {
    splitAns <- sapply(splitAns, "[", c(colNum+2L)) 
    splitAns <- gsub("*NA*","NaN", splitAns) 
  }
  else if(colName == "ArrDelay")
  {
    splitAns <- sapply(splitAns, "[", c(colNum)) 
    splitAns <- gsub("\"([-0-9]+)\"","\\1", splitAns) 
    # replace all the blank entries with NaN
    splitAns <- gsub("^$","NaN", splitAns) 
  } 
  
  # trying to make R stop complaining about NAs introduced by coercion
  #splitAns <- as.data.frame(splitAns)
  #splitAns <- na.omit(splitAns)
  splitAns <- sapply(splitAns, as.integer)
}
