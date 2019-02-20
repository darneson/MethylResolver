\docType{data}
\name{RFmodel}
\alias{RFmodel}
\title{Random forest model to predict tumor purity and absolute leukocyte fractions}
\source{
Systematic pan-cancer analysis of tumour purity (doi: 10.1038/ncomms9971)
}
\usage{
RFmodel
}
\description{
A random forest regression model was trained on TCGA data to predict the concensus purity estimate (CPE) to get an estimate of the tumor purity using relative fractions obtained from MethylResolver. This model can be used to predict tumor purity and to obtain absolute fractions from the relative fractions of MethylResolver.
}
\keyword{datasets}