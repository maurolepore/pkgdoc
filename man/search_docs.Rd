% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/search_docs.R
\name{search_docs}
\alias{search_docs}
\title{Dataframe the documentation of installed packages.}
\usage{
search_docs(packages = NULL)
}
\arguments{
\item{packages}{A character vector with the names of packages to limit the
search, or \code{NULL} to serach in all known libraries.}
}
\value{
A dataframe.
}
\description{
This is fundamentally a dataframe version of the output of
\code{\link[utils:hsearch_db]{utils::hsearch_db()}}.
}
\examples{
search_docs(NULL)

}
\seealso{
Other retrieve documentation: \code{\link{reference_package}}
}
\concept{retrieve documentation}
