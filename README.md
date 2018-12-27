
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc

[![Travis build
status](https://travis-ci.org/maurolepore/pkgdoc.svg?branch=master)](https://travis-ci.org/maurolepore/pkgdoc)
[![Coverage
status](https://coveralls.io/repos/github/maurolepore/pkgdoc/badge.svg)](https://coveralls.io/r/maurolepore/pkgdoc?branch=master)

The goal of **pkgdoc** is to create dataframes of the documentation of
installed packages. This helps you to mamipulate documentation accross
multiple packages. For example, you can use **pkgdoc** to create a
reference of functions by concept accross multiple packages (similar to
the Reference section of a [**pkgdown**](https://pkgdown.r-lib.org/)
website but not limited to a single package).

## Installation

You can install the released version of pkgdoc from
[CRAN](https://CRAN.R-project.org) with:

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
#> # A tibble: 71,935 x 11
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
#> # ... with 71,925 more rows, and 1 more variable: concept <chr>

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
#> # A tibble: 970 x 3
#>    topic     alias     title                                               
#>    <chr>     <chr>     <chr>                                               
#>  1 Aids2     Aids2     Australian AIDS Survival Data                       
#>  2 Animals   Animals   Brain and Body Weights for 28 Species               
#>  3 Boston    Boston    Housing Values in Suburbs of Boston                 
#>  4 Cars93    Cars93    Data from 93 Cars on Sale in the USA in 1993        
#>  5 Cushings  Cushings  Diagnostic Tests on Patients with Cushing's Syndrome
#>  6 DDT       DDT       DDT in Kale                                         
#>  7 GAGurine  GAGurine  Level of GAG in Urine of Children                   
#>  8 Insurance Insurance Numbers of Car Insurance claims                     
#>  9 Melanoma  Melanoma  Survival from Malignant Melanoma                    
#> 10 Null      Null      Null Spaces of Matrices                             
#> # ... with 960 more rows

reference_concept(c("combine strings", "files", "PCA"))
#> # A tibble: 4 x 3
#>   topic        alias                             title                     
#>   <chr>        <chr>                             <chr>                     
#> 1 find.package find.package, path.package        Find Packages             
#> 2 paste        paste, paste0                     Concatenate Strings       
#> 3 prcomp       prcomp, plot, predict, print, su~ Principal Components Anal~
#> 4 princomp     princomp, plot, print, predict    Principal Components Anal~
```

``` r
if (requireNamespace("fgeo", quietly = TRUE)) {

  reference_concept(
    "datasets", 
    url = "https://forestgeo.github.io/",
    packages = c("fgeo.x", "fgeo.plot")
  ) %>% 
    knitr::kable()
} 
```

| topic                                                                    | alias                                                                                       | title                                      |
| :----------------------------------------------------------------------- | :------------------------------------------------------------------------------------------ | :----------------------------------------- |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/vft_1quad>?</a>  | vft\_1quad                                                                                  | Small ViewFullTables from Luquillo.        |
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a>      | datasets, elevation, habitat, stem5, stem6, taxa, tree5, tree6, vft\_4quad, tree6\_3species | Datasets from Luquillo, Puerto Rico.       |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a> | download\_data                                                                              | Download data from fgeo.data.              |
| <a href=https://forestgeo.github.io/fgeo.x/reference/x_example>?</a>     | x\_example                                                                                  | Path to directory containing example data. |
