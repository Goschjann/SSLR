% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Democratic.R
\name{democratic}
\alias{democratic}
\title{General Interface for Democratic model}
\usage{
democratic(learners, schemes = NULL)
}
\arguments{
\item{learners}{List of models from parsnip package for training a supervised base classifier
using a set of instances. This model need to have probability predictions}

\item{schemes}{List of schemes (col x names in each learner).
Default is null, it means that learner uses all x columns}
}
\value{
(When model fit) A list object of class "democratic" containing:
\describe{
\item{W}{A vector with the confidence-weighted vote assigned to each classifier.}
\item{model}{A list with the final N base classifiers trained using the
enlarged labeled set.}
\item{model.index}{List of N vectors of indexes related to the training instances
used per each classifier. These indexes are relative to the \code{y} argument.}
\item{instances.index}{The indexes of all training instances used to
train the N \code{models}. These indexes include the initial labeled instances
and the newly labeled instances. These indexes are relative to the \code{y} argument.}
\item{model.index.map}{List of three vectors with the same information in \code{model.index}
but the indexes are relative to \code{instances.index} vector.}
\item{classes}{The levels of \code{y} factor.}
\item{preds}{The functions provided in the \code{preds} argument.}
\item{preds.pars}{The set of lists provided in the \code{preds.pars} argument.}
\item{x.inst}{The value provided in the \code{x.inst} argument.}
}
}
\description{
Democratic Co-Learning is a semi-supervised learning algorithm with a
co-training style. This algorithm trains N classifiers with different learning schemes
defined in list \code{gen.learners}. During the iterative process, the multiple classifiers
with different inductive biases label data for each other.
}
\details{
This method trains an ensemble of diverse classifiers. To promote the initial diversity
the classifiers must represent different learning schemes.
When x.inst is \code{FALSE} all \code{learners} defined must be able to learn a classifier
from the precomputed matrix in \code{x}.
The iteration process of the algorithm ends when no changes occurs in
any model during a complete iteration.
The generation of the final hypothesis is
produced via a weigthed majority voting.
}
\examples{
library(tidyverse)
library(tidymodels)
library(caret)
library(SSLR)

data(wine)

set.seed(1)
train.index <- createDataPartition(wine$Wine, p = .7, list = FALSE)
train <- wine[ train.index,]
test  <- wine[-train.index,]

cls <- which(colnames(wine) == "Wine")

#\% LABELED
labeled.index <- createDataPartition(wine$Wine, p = .2, list = FALSE)
train[-labeled.index,cls] <- NA

#We need a model with probability predictions from parsnip
#https://tidymodels.github.io/parsnip/articles/articles/Models.html
#It should be with mode = classification


rf <-  rand_forest(trees = 100, mode = "classification") \%>\%
  set_engine("randomForest")


bt <-  boost_tree(trees = 100, mode = "classification") \%>\%
  set_engine("xgboost")


m <- democratic(learners = list(rf,bt)) \%>\% fit(Wine ~ ., data = train)

#' \donttest{
#Accuracy
predict(m,test) \%>\%
  bind_cols(test) \%>\%
  metrics(truth = "Wine", estimate = .pred_class)


#With schemes
set.seed(1)
m <- democratic(learners = list(rf,bt),
                schemes = list(c("Malic.Acid","Ash"), c("Magnesium","Proline")) ) \%>\%
  fit(Wine ~ ., data = train)


#Accuracy
predict(m,test) \%>\%
  bind_cols(test) \%>\%
  metrics(truth = "Wine", estimate = .pred_class)

#'}
}
