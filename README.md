# MethylResolver v0.1.0

MethylResolver is an R package to conduct robust deconvolution of bulk tissue methylation profiles using a reference signature. A reference signature of 11 leukocyte cell types is provided. Additionally, tumor purity and absolute cell type fractions can be estimated without a reference of the tumor using a Random Forest regression model trained on concensus tumor purity estimates (CPE) of TCGA samples.

MethylResolver was developed and is maintained by Douglas Arneson at UCLA.

## Install MethylResolver v0.1.0
```r
install.packages('devtools')
devtools::install_github(repo = 'darneson/MethylResolver', ref = 'release/0.1.0')
library(MethylResolver)
```

## Version History

February 20, 2019:
* Version 0.1.0 released (initial release)
