
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

library(tools)
library(datasets)
universe <- c("tools", "datasets")

docs <- reference_package(universe)
```

You may organize the documentation by package or concept (`#' @family`):

``` r
# By package
subset(docs, package == "datasets")
#> # A tibble: 87 × 5
#>    topic          alias                 title                    concept package
#>    <chr>          <chr>                 <chr>                    <chr>   <chr>  
#>  1 AirPassengers  AirPassengers         Monthly Airline Passeng… Datase… datase…
#>  2 BJsales        BJsales, BJsales.lead Sales Data with Leading… Datase… datase…
#>  3 BOD            BOD                   Biochemical Oxygen Dema… Datase… datase…
#>  4 CO2            CO2                   Carbon Dioxide Uptake i… Datase… datase…
#>  5 ChickWeight    ChickWeight           Weight versus age of ch… Datase… datase…
#>  6 DNase          DNase                 Elisa assay of DNase     Datase… datase…
#>  7 EuStockMarkets EuStockMarkets        Daily Closing Prices of… Datase… datase…
#>  8 Formaldehyde   Formaldehyde          Determination of Formal… Datase… datase…
#>  9 HairEyeColor   HairEyeColor          Hair and Eye Color of S… Datase… datase…
#> 10 Harman23.cor   Harman23.cor          Harman Example 2.3       Datase… datase…
#> # ℹ 77 more rows

subset(docs, package == "tools")
#> # A tibble: 141 × 5
#>    topic             alias                                 title concept package
#>    <chr>             <chr>                                 <chr> <chr>   <chr>  
#>  1 .print.via.format .print.via.format                     Prin… Utilit… tools  
#>  2 Adobe_glyphs      Adobe_glyphs, charset_to_Unicode      Conv… Datase… tools  
#>  3 CRAN_package_db   CRAN_package_db, CRAN_check_results,… CRAN… <NA>    tools  
#>  4 HTMLheader        HTMLheader                            Gene… Utilit… tools  
#>  5 HTMLheader        HTMLheader                            Gene… Docume… tools  
#>  6 HTMLheader        HTMLheader                            Gene… Utilit… tools  
#>  7 HTMLheader        HTMLheader                            Gene… Docume… tools  
#>  8 QC                QC, checkDocFiles, checkDocStyle, ch… QC C… Utilit… tools  
#>  9 QC                QC, checkDocFiles, checkDocStyle, ch… QC C… Docume… tools  
#> 10 QC                QC, checkDocFiles, checkDocStyle, ch… QC C… Utilit… tools  
#> # ℹ 131 more rows

# By concept
datasets <- subset(docs, concept == "Datasets available by data()")
datasets
#> # A tibble: 87 × 5
#>    topic          alias                            title         concept package
#>    <chr>          <chr>                            <chr>         <chr>   <chr>  
#>  1 Adobe_glyphs   Adobe_glyphs, charset_to_Unicode Conversion T… Datase… tools  
#>  2 AirPassengers  AirPassengers                    Monthly Airl… Datase… datase…
#>  3 BJsales        BJsales, BJsales.lead            Sales Data w… Datase… datase…
#>  4 BOD            BOD                              Biochemical … Datase… datase…
#>  5 CO2            CO2                              Carbon Dioxi… Datase… datase…
#>  6 ChickWeight    ChickWeight                      Weight versu… Datase… datase…
#>  7 DNase          DNase                            Elisa assay … Datase… datase…
#>  8 EuStockMarkets EuStockMarkets                   Daily Closin… Datase… datase…
#>  9 Formaldehyde   Formaldehyde                     Determinatio… Datase… datase…
#> 10 HairEyeColor   HairEyeColor                     Hair and Eye… Datase… datase…
#> # ℹ 77 more rows

utilities <- subset(docs, concept == "utilities")
utilities
#> # A tibble: 0 × 5
#> # ℹ 5 variables: topic <chr>, alias <chr>, title <chr>, concept <chr>,
#> #   package <chr>
```

You may link to documentation online.

``` r
template <- "<a href=https://www.rdocumentation.org/packages/%s/versions/3.6.2/topics/%s>?</a>"
linked <- transform(datasets, topic = sprintf(template, package, topic))
knitr::kable(head(linked))
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Adobe_glyphs>?</a> | Adobe_glyphs, charset_to_Unicode | Conversion Tables between Character Sets | Datasets available by data() | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/AirPassengers>?</a> | AirPassengers | Monthly Airline Passenger Numbers 1949-1960 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BJsales>?</a> | BJsales, BJsales.lead | Sales Data with Leading Indicator | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BOD>?</a> | BOD | Biochemical Oxygen Demand | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/CO2>?</a> | CO2 | Carbon Dioxide Uptake in Grass Plants | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/ChickWeight>?</a> | ChickWeight | Weight versus age of chicks on different diets | Datasets available by data() | datasets |
