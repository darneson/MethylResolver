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
- [License](./LICENSE)
- [Issues](https://github.com/darneson/MethylResolver/issues)
- [Version](#version-history)

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

# Installation Guide

## Stable Release

`MethylResolver` is available from github:

```r
install.packages('devtools')
devtools::install_github(repo = 'darneson/MethylResolver')
library(MethylResolver)
```

Typical install times are 1-2 minutes.

# Demo

## Examples

For demos of the functions, please check out the examples built into the package. They can be accessed as follows:

```
require(MethylResolver)

# Deconvolution with default signature and calculating absolute fractions with default RF model:
MethylResolver(methylMix = MethylMix)

# Deconvolution with default signature and only calculating relative fractions:
MethylResolver(methylMix = MethylMix, absolute = FALSE)

# Specify your own signature matrix and RF model for calculating absolute fractions:
MethylResolver(methylMix = MethylMix, methylSig = MethylSig, purityModel = RFmodel)
```

Typical run times for the examples are ~10 seconds.

Also, please look at the built in help for descriptions of the parameters using: `?MethylResolver`.

# Version History

February 20, 2019:
* Version 0.1.0 released (initial release)
