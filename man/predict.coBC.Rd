% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CoBC.R
\name{predict.coBC}
\alias{predict.coBC}
\title{Predictions of the coBC method}
\usage{
\method{predict}{coBC}(object, x, ...)
}
\arguments{
\item{object}{coBC model built with the \code{\link{coBC}} function.}

\item{x}{An object that can be coerced to a matrix.
Depending on how the model was built, \code{x} is interpreted as a matrix
with the distances between the unseen instances and the selected training instances,
or a matrix of instances.}

\item{...}{This parameter is included for compatibility reasons.}
}
\value{
Vector with the labels assigned.
}
\description{
Predicts the label of instances according to the \code{coBC} model.
}
\details{
For additional help see \code{\link{coBC}} examples.
}
