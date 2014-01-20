\name{csvSample}
\alias{csvSample}
\title{Sample observations from a CSV file}
\description{
  This function provides a fast mechanism to sample
  observations (lines) within a local CSV file. It uses
  compiled code to read individual lines and return
  only the ones of interest. It is fast as it
  doesn't use a lot of memory, reading one line at a time.
  This compares with using \link[base]{\code{readLines}}
  and a connection.

  This can be used for non-CSV files as the actual lines are not
  interpreted.
}
\usage{
csvSample(file, n, rows = sample(1:numRows, n), numRows =
	  getNumLines(file), randomize = FALSE, header = TRUE, colName =
	  NULL )
}
\arguments{
  \item{file}{the name of the local file containing the
  line/observations of interest}
  \item{n}{the number of lines to sample from the file}
  \item{rows}{a vector of numbers identifying the lines/observations to sample}
  \item{numRows}{the total number of observations in the file. This is
  used to sample line numbers. If \code{rows} is specified, this is not used.}
  \item{randomize}{logical value controlling whether to randomly permute the result or leave the
  vector of lines in the order they are sampled.}
  \item{header}{a logical value that indicates whether the file has an
  initial line that contains the variable names, i.e. the header for the
  CSV file.}
  \item{colName}{a string that denotes the column entry to be returned only}	
}
\value{
A character vector containing the sampled lines.
}
\author{
Duncan Temple Lang
}
\seealso{
  \code{\link[base]{read.csv}}
  \code{\link[base]{file}}  
}
\examples{
}
\keyword{IO}
