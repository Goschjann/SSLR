% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Democratic.R
\name{democraticCombine}
\alias{democraticCombine}
\title{Combining the hypothesis of the classifiers}
\usage{
democraticCombine(pred, W, classes)
}
\arguments{
\item{pred}{A list with the prediction for each classifier.}

\item{W}{A vector with the confidence-weighted vote assigned to each classifier
during the training process.}

\item{classes}{the classes.}
}
\value{
The classification proposed.
}
\description{
This function combines the probabilities predicted by the set of
classifiers.
}
