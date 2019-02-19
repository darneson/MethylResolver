\name{MethylResolver}
\alias{MethylResolver}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
MethylResolver
}
\description{
This function deconvolves bulk methylation data into cell type fractions given a reference signature matrix for each cell type expected in the bulk profile. It also allows for the estimation of unknown content (purity) which allows both relative and absolute cell type fractions to be reported.
}
\usage{
MethylResolver(methylMix = NULL, methylSig = "default",
  betaPrime = TRUE, outputPath = "./", outputName = 
  "MethylResolver", doPar = FALSE, numCores = 1, 
  alpha = 0.5, absolute = TRUE, purityModel = "default")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{methylMix}{
    MxN (CpGs by samples) matrix of bulk methylation sequencing. Required.
  }
  \item{methylSig}{
    MxW (CpGs by cell types) matrix of purified cell type methylation profiles.
    Default signature is the MethylResolver leukocyte signature.
  }
  \item{betaPrime}{
    Deconvolutions are calculated using methylation Beta' values (1-Beta). Indicate
    whether you are supplying Beta' values (TRUE), or Beta values (FALSE). Default
    is TRUE.
  }
  \item{outputPath}{
    Path to output directory. Default is "./".
  }
  \item{outputName}{
    Prefix name to give to the deconvolution output. Default is
    "MethylResolver".
  }
  \item{doPar}{
    Whether to use parallel processing to speed up the deconvolution computation if
    many samples are present. Default is FALSE.
  }
  \item{numCores}{
    Number of cores used for parallel processing to speed up the deconvolution of many
    samples. Requires doPar = TRUE. Default is 1. numCores = "auto" is max number of
    cores available minus one.
  }
  \item{alpha}{
    Set the alpha parameter for LTS deconvolution. This is the fraction of optimal CpGs
    from the signature matrix which are used for deconvolution. Default is 0.5.
  }
  \item{absolute}{
    Whether to compute tumor purity and absolute cell type fractions. Default is TRUE.
  }
  \item{purityModel}{
    Random Forest model to predict mixture purity (unknown content) which allows the
    calculation of absolute cell type fractions. Required if absolute is TRUE. Default
    is our RF model trained on the consensus purity estimate (CPE) using TCGA data.
  }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
  Douglas Arneson
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# Deconvolution with default signature and calculating
# absolute fractions with default RF model:
MethylResolver(methylMix = MethylMix)
  
# Deconvolution with default signature and only
# calculating relative fractions:
MethylResolver(methylMix = MethylMix, absolute = FALSE)
  
# Specify your own signature matrix and RF model for
# calculating absolute fractions:
MethylResolver(methylMix = MethylMix, methylSig = 
methylSig, purityModel = RFmodel)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~models }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~robust }% __ONLY ONE__ keyword per line