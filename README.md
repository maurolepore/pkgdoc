
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc

<!-- badges: start -->

[![R-CMD-check](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/maurolepore/pkgdoc/graph/badge.svg)](https://app.codecov.io/gh/maurolepore/pkgdoc)
<!-- badges: end -->

The goal of pkgdoc is to make it easy to create a data frame of the
metadata associated to the documentation of a collection of R packages.

If you maintain an R-package universe, it helps you to easily create a
universe-wide reference for the pkgdown website of your meta-package
(e.g. tidyverse, tidymodels).

## Installation

``` r
# install.packages("pak")
pak::pak("maurolepore/pkgdoc")
```

## Example

``` r
library(pkgdoc)
library(fgeo.x)
library(fgeo.plot)

universe <- c("fgeo.plot", "fgeo.x")

docs <- reference_package(universe, url = "https://forestgeo.github.io/")
docs
#> # A tibble: 32 × 5
#>    topic                                             alias title concept package
#>    <glue>                                            <chr> <chr> <chr>   <glue> 
#>  1 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… autopl… <a hre…
#>  2 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… plot f… <a hre…
#>  3 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… autopl… <a hre…
#>  4 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… functi… <a hre…
#>  5 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… functi… <a hre…
#>  6 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… Plot… plot f… <a hre…
#>  7 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… List… functi… <a hre…
#>  8 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… List… functi… <a hre…
#>  9 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… List… functi… <a hre…
#> 10 <a href=https://forestgeo.github.io/fgeo.plot/re… auto… List… plot f… <a hre…
#> # ℹ 22 more rows
```

You can easily organize the documentation by concept (`#' @family`) and
make links clickable with `DT::datatable()` or `knitr::kable()`. For
example:

- Datasets

``` r
knitr::kable(subset(docs, concept == "datasets"))
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a> | datasets, elevation, habitat, stem5, stem6, tree5, tree6, vft_4quad, tree6_3species | Access data via ‘library(fgeo.x)’ or ‘fgeo.x::<dataset-name>’. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a> | download_data | Access data stored online. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/example_path>?</a> | example_path | Access data stored in system files. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |

- Autoplots

``` r
knitr::kable(subset(docs, concept == "autoplots"))
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.fgeo_habitat>?</a> | autoplot | Plot habitats. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/elev>?</a> | elev | Allow autoplotting the column ‘elev’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp>?</a> | sp | Allow autoplotting the column ‘sp’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
