# MethylResolver

[![Build Status](https://travis-ci.org/darneson/MethylResolver.png?branch=master)](https://travis-ci.org/darneson/MethylResolver)
[![HitCount](http://hits.dwyl.com/darneson/MethylResolver.svg)](http://hits.dwyl.com/darneson/MethylResolver)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Contents

- [Overview](#overview)
- [Repo Contents](#repo-contents)
- [System Requirements](#system-requirements)
- [Installation Guide](#installation-guide)
- [Demo](#demo)
- [Results](#results)
- [License](./LICENSE)
- [Issues](https://github.com/ebridge2/lol/issues)
- [Citation](#citation)

# Overview
``MethylResolver`` is an R package to conduct robust deconvolution of bulk tissue methylation profiles using a reference signature. A reference signature of 11 leukocyte cell types is provided. Additionally, tumor purity and tumor purity-adjusted cell type fractions can be estimated without a reference of the tumor using a Random Forest regression model trained on concensus tumor purity estimates (CPE) of TCGA samples.

MethylResolver was developed and is maintained by Douglas Arneson at UCLA.

# Repo Contents

- [R](./R): `R` package code.
- [man](./man): package manual for help in R session.
- [data](./data): data used in the tutorial, the RF model, and the signature matrix.

# System Requirements

## Hardware Requirements

The `MethylResolver` package requires only a standard computer with Rstudio installed.

## Software Requirements

### OS Requirements

The package has tested on *Mac OSX* operating systems. The package has been tested on the following systems:

Linux:  
Mac OSX: macOS Mojave 10.14.6
Windows:  

The R package should be compatible with Windows, Mac, and Linux operating systems.

Before setting up the `MethylResolver` package, users should have `R` version 3.4.0 or higher.


## Install MethylResolver v0.1.0
```r
install.packages('devtools')
devtools::install_github(repo = 'darneson/MethylResolver')
library(MethylResolver)
```

## Version History

February 20, 2019:
* Version 0.1.0 released (initial release)
