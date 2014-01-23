\name{getNumLines}
\alias{getNumLines}
\title{get number of lines from a file}
\description{
    actually uses the shell command "wc -l $FILENAME" but 
    greps suitable part and turned it into integer 
}
\usage{
    getNumLines(filename)
}
\arguments{
  \item{file}{the name of the local file containing the
  line/observations of interest}
}
\value{
    an integer denoting the total number of lines  
}
\author{
Duncan Temple Lang with bug contributions from Karen Ng
}
\seealso{
  \code{\link[base]{system}}
  \code{\link[base]{sprintf}}  
  \code{\link[base]{as.integer}}  
  \code{\link[base]{gsub}}  
}
\examples{
}
\keyword{IO}

