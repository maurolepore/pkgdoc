
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/maurolepore/pkgdoc.svg?branch=master)](https://travis-ci.org/maurolepore/pkgdoc)
[![Coverage
status](https://coveralls.io/repos/github/maurolepore/pkgdoc/badge.svg)](https://coveralls.io/r/maurolepore/pkgdoc?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/pkgdoc)](https://cran.r-project.org/package=pkgdoc)

Create dataframes of the documentation of installed packages. Combined
with `krittr::kable()` or `DT::datatable()`, **pkgdoc** allows you to
reference functions by package or concept across multiple packages and
to provide links to each topic’s help file (similar to the Reference
section of a [**pkgdown**](https://pkgdown.r-lib.org/) website but not
limited to a single package).

## Installation

``` r
# install.packages("devtools")
devtools::install_github("maurolepore/pkgdoc")
```

## Example

``` r
library(pkgdoc)
```

``` r
# Documentation of all installed packages
search_docs()
#> # A tibble: 71,919 x 11
#>    package libpath id    name  title topic encoding type  alias keyword
#>    <chr>   <chr>   <chr> <chr> <chr> <chr> <chr>    <chr> <chr> <chr>  
#>  1 acepack C:/Use~ 1/1   ace   Alte~ ace   ""       help  ace   models 
#>  2 acepack C:/Use~ 1/2   avas  Addi~ avas  ""       help  avas  models 
#>  3 acepack C:/Use~ 1/2   avas  Addi~ avas  ""       help  avas~ models 
#>  4 addine~ C:/Use~ 2/1   addi~ RStu~ addi~ ""       help  addi~ <NA>   
#>  5 addine~ C:/Use~ 2/1   addi~ RStu~ addi~ ""       help  addi~ <NA>   
#>  6 addine~ C:/Use~ 2/2   find~ Find~ find~ ""       help  find~ <NA>   
#>  7 addine~ C:/Use~ 2/3   inse~ Inse~ inse~ ""       help  inse~ <NA>   
#>  8 addine~ C:/Use~ 2/4   refo~ Refo~ refo~ ""       help  refo~ <NA>   
#>  9 addine~ C:/Use~ 2/5   subs~ Subs~ subs~ ""       help  subs~ <NA>   
#> 10 AGBflu~ C:/Use~ 3/1   AGBf~ AGBf~ AGBf~ UTF-8    help  AGBf~ intern~
#> # ... with 71,909 more rows, and 1 more variable: concept <chr>

some_packages <- c("utils", "base")
search_docs(some_packages)
#> # A tibble: 5,935 x 11
#>    package libpath id    name  title topic encoding type  alias keyword
#>    <chr>   <chr>   <chr> <chr> <chr> <chr> <chr>    <chr> <chr> <chr>  
#>  1 base    C:/Use~ 10/1  abbr~ Abbr~ abbr~ ""       help  abbr~ charac~
#>  2 base    C:/Use~ 10/2  agrep Appr~ agrep ""       help  agrep charac~
#>  3 base    C:/Use~ 10/2  agrep Appr~ agrep ""       help  agre~ charac~
#>  4 base    C:/Use~ 10/2  agrep Appr~ agrep ""       help  fuzz~ charac~
#>  5 base    C:/Use~ 10/2  agrep Appr~ agrep ""       help  .ama~ charac~
#>  6 base    C:/Use~ 10/2  agrep Appr~ agrep ""       help  .ama~ charac~
#>  7 base    C:/Use~ 10/3  all.~ Test~ all.~ ""       help  all.~ progra~
#>  8 base    C:/Use~ 10/3  all.~ Test~ all.~ ""       help  all.~ progra~
#>  9 base    C:/Use~ 10/3  all.~ Test~ all.~ ""       help  all.~ progra~
#> 10 base    C:/Use~ 10/3  all.~ Test~ all.~ ""       help  all.~ progra~
#> # ... with 5,925 more rows, and 1 more variable: concept <chr>
```

``` r
reference_package(c("stats", "MASS"))
#> Warning:   All packages should be attached `strip_s3class` to work properly.
#>   Not attached: MASS
#> # A tibble: 970 x 5
#>    topic     alias            title                   concept       package
#>    <chr>     <chr>            <chr>                   <chr>         <chr>  
#>  1 .checkMF~ .checkMFClasses~ Functions to Check the~ Utilities     stats  
#>  2 .preform~ .preformat.ts, ~ Printing and Formattin~ Time Series   stats  
#>  3 abbey     abbey            Determinations of Nick~ Datasets ava~ MASS   
#>  4 accdeaths accdeaths        Accidental Deaths in t~ Datasets ava~ MASS   
#>  5 acf       acf, ccf, pacf,~ Auto- and Cross- Covar~ Time Series   stats  
#>  6 acf2AR    acf2AR           Compute an AR Process ~ Time Series   stats  
#>  7 add.scope add.scope, drop~ Compute Allowed Change~ Statistical ~ stats  
#>  8 add1      add1, drop1      Add or Drop All Possib~ Statistical ~ stats  
#>  9 addmargi~ addmargins       Puts Arbitrary Margins~ totals        stats  
#> 10 addmargi~ addmargins       Puts Arbitrary Margins~ margins       stats  
#> # ... with 960 more rows

reference_concept(c("combine strings", "files", "PCA"))
#> # A tibble: 4 x 5
#>   topic     alias                    title              concept     package
#>   <chr>     <chr>                    <chr>              <chr>       <chr>  
#> 1 find.pac~ find.package, path.pack~ Find Packages      files       base   
#> 2 paste     paste, paste0            Concatenate Strin~ combine st~ base   
#> 3 prcomp    prcomp, plot, predict, ~ Principal Compone~ PCA         stats  
#> 4 princomp  princomp, plot, print, ~ Principal Compone~ PCA         stats
```

### Referencing functions across multiple packages

This example shows how to build a reference section like [this
one](https://forestgeo.github.io/fgeo/articles/siteonly/reference.html),
from the meta-package
[**fgeo**](https://forestgeo.github.io/fgeo/index.html).

``` r
library(fgeo)
#> -- Attaching packages ---------------------------------------------- fgeo 0.0.0.9002 --
#> v fgeo.analyze 0.0.0.9003     v fgeo.tool    0.0.0.9005
#> v fgeo.plot    0.0.0.9402     v fgeo.x       0.0.0.9000
#> -- Conflicts ------------------------------------------------------ fgeo_conflicts() --
#> x fgeo.tool::filter() masks stats::filter()

reference_concept(
  c("datasets", "plot functions"),
  url = "https://forestgeo.github.io/",
  ) %>% 
  arrange(concept) %>%
  head() %>% 
  knitr::kable()
```

| topic                                                                                     | alias                                                                                       | title                                                                    | concept        | package                                                     |
| :---------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------ | :----------------------------------------------------------------------- | :------------- | :---------------------------------------------------------- |
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a>                       | datasets, elevation, habitat, stem5, stem6, taxa, tree5, tree6, vft\_4quad, tree6\_3species | Datasets from Luquillo, Puerto Rico.                                     | datasets       | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a>       |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a>                  | download\_data                                                                              | Download data from fgeo.data.                                            | datasets       | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a>       |
| <a href=https://forestgeo.github.io/fgeo.x/reference/example_path>?</a>                   | example\_path                                                                               | Path to directory containing example data.                               | datasets       | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a>       |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.fgeo_habitat>?</a>       | autoplot                                                                                    | Quick habitat plots.                                                     | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a>            | autoplot                                                                                    | Quick plot of species distribution and/or topography.                    | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot\_by\_species                                                                       | List plots of species distribution and topography (good for pdf output). | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
