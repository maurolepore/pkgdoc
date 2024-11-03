
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc

<!-- badges: start -->

[![R-CMD-check](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml)
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

library(tools)
library(datasets)

universe <- c("datasets", "tools")
url_template <- "https://www.rdocumentation.org/packages/{package}/versions/3.6.2/topics/{topic}.html"

linked <- reference_package(universe, url_template = url_template)
linked
#> # A tibble: 228 × 5
#>    topic                                             alias title concept package
#>    <chr>                                             <chr> <chr> <chr>   <chr>  
#>  1 <a href=https://www.rdocumentation.org/packages/… .pri… Prin… Utilit… tools  
#>  2 <a href=https://www.rdocumentation.org/packages/… Adob… Conv… Datase… tools  
#>  3 <a href=https://www.rdocumentation.org/packages/… AirP… Mont… Datase… datase…
#>  4 <a href=https://www.rdocumentation.org/packages/… BJsa… Sale… Datase… datase…
#>  5 <a href=https://www.rdocumentation.org/packages/… BOD   Bioc… Datase… datase…
#>  6 <a href=https://www.rdocumentation.org/packages/… CO2   Carb… Datase… datase…
#>  7 <a href=https://www.rdocumentation.org/packages/… CRAN… CRAN… <NA>    tools  
#>  8 <a href=https://www.rdocumentation.org/packages/… Chic… Weig… Datase… datase…
#>  9 <a href=https://www.rdocumentation.org/packages/… DNase Elis… Datase… datase…
#> 10 <a href=https://www.rdocumentation.org/packages/… EuSt… Dail… Datase… datase…
#> # ℹ 218 more rows

knitr::kable(head(linked[c("topic", "title")]))
```

| topic | title |
|:---|:---|
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/.print.via.format.html>.print.via.format</a> | Printing Utilities |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Adobe_glyphs.html>Adobe_glyphs</a> | Conversion Tables between Character Sets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/AirPassengers.html>AirPassengers</a> | Monthly Airline Passenger Numbers 1949-1960 |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BJsales.html>BJsales</a> | Sales Data with Leading Indicator |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BOD.html>BOD</a> | Biochemical Oxygen Demand |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/CO2.html>CO2</a> | Carbon Dioxide Uptake in Grass Plants |
