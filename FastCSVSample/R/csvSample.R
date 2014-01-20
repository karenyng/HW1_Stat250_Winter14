
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

  if(header & !is.null(colName))
    getCol(file, colName)

  names(ans) = rows

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
  csvHeader <- system(sprintf('head -1 %s | tr "," "\n"', file), intern = TRUE)
  for(i in 1:length(csvHeader))
  {
    if(grepl(csvHeader[[i]], colName))
    {
      colNum <- i 
      break
    }
  }
  if(colNum == -99L)
    stop(c(colName, "does not exist in the csv header")

  colNum
}

getCol = 
function(file, colName, ans)
{
  colNum = getColNum(file, colName)
}
