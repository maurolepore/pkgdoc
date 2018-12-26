
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
#> # A tibble: 71,937 x 11
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
#> # ... with 71,927 more rows, and 1 more variable: concept <chr>

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
packages <- c("stats", "MASS")
pick_package(packages)
#> # A tibble: 2,416 x 7
#>    package title                 topic   type  alias  keyword concept      
#>    <chr>   <chr>                 <chr>   <chr> <chr>  <chr>   <chr>        
#>  1 MASS    Australian AIDS Surv~ Aids2   help  Aids2  datase~ Datasets ava~
#>  2 MASS    Brain and Body Weigh~ Animals help  Anima~ datase~ Datasets ava~
#>  3 MASS    Housing Values in Su~ Boston  help  Boston datase~ Datasets ava~
#>  4 MASS    Data from 93 Cars on~ Cars93  help  Cars93 datase~ Datasets ava~
#>  5 MASS    Diagnostic Tests on ~ Cushin~ help  Cushi~ datase~ Datasets ava~
#>  6 MASS    DDT in Kale           DDT     help  DDT    datase~ Datasets ava~
#>  7 MASS    Level of GAG in Urin~ GAGuri~ help  GAGur~ datase~ Datasets ava~
#>  8 MASS    Numbers of Car Insur~ Insura~ help  Insur~ datase~ Datasets ava~
#>  9 MASS    Survival from Malign~ Melano~ help  Melan~ datase~ Datasets ava~
#> 10 MASS    Null Spaces of Matri~ Null    help  Null   algebra Linear Algeb~
#> # ... with 2,406 more rows

concepts <- c("combine strings", "files", "PCA")
pick_concept(concepts)
#> # A tibble: 18 x 7
#>    package title            topic    type  alias       keyword   concept   
#>    <chr>   <chr>            <chr>    <chr> <chr>       <chr>     <chr>     
#>  1 base    Find Packages    find.pa~ help  find.packa~ <NA>      files     
#>  2 base    Find Packages    find.pa~ help  path.packa~ <NA>      files     
#>  3 base    Concatenate Str~ paste    help  paste       character combine s~
#>  4 base    Concatenate Str~ paste    help  paste0      character combine s~
#>  5 stats   Principal Compo~ prcomp   help  prcomp      multivar~ PCA       
#>  6 stats   Principal Compo~ prcomp   help  prcomp.for~ multivar~ PCA       
#>  7 stats   Principal Compo~ prcomp   help  prcomp.def~ multivar~ PCA       
#>  8 stats   Principal Compo~ prcomp   help  plot.prcomp multivar~ PCA       
#>  9 stats   Principal Compo~ prcomp   help  predict.pr~ multivar~ PCA       
#> 10 stats   Principal Compo~ prcomp   help  print.prco~ multivar~ PCA       
#> 11 stats   Principal Compo~ prcomp   help  summary.pr~ multivar~ PCA       
#> 12 stats   Principal Compo~ prcomp   help  print.summ~ multivar~ PCA       
#> 13 stats   Principal Compo~ princomp help  princomp    multivar~ PCA       
#> 14 stats   Principal Compo~ princomp help  princomp.f~ multivar~ PCA       
#> 15 stats   Principal Compo~ princomp help  princomp.d~ multivar~ PCA       
#> 16 stats   Principal Compo~ princomp help  plot.princ~ multivar~ PCA       
#> 17 stats   Principal Compo~ princomp help  print.prin~ multivar~ PCA       
#> 18 stats   Principal Compo~ princomp help  predict.pr~ multivar~ PCA
```

``` r
reference_package("fgeo", url = "https://forestgeo.github.io/") %>% 
  knitr::kable()
```

| topic                                                                | alias                                 | title                                 |
| :------------------------------------------------------------------- | :------------------------------------ | :------------------------------------ |
| <a href=https://forestgeo.github.io/fgeo/reference/fgeo_browse>?</a> | fgeo\_browse, fgeo\_browse\_reference | Open a web browser on fgeo’s website. |
| <a href=https://forestgeo.github.io/fgeo/reference/fgeo_help>?</a>   | fgeo\_help, fgeo\_help\_addin         | Get help with fgeo.                   |

``` r

reference_concept("datasets", url = "https://forestgeo.github.io/") %>% 
  knitr::kable()
```

| topic                                                                    | alias                                                                                       | title                                      |
| :----------------------------------------------------------------------- | :------------------------------------------------------------------------------------------ | :----------------------------------------- |
| <a href=https://forestgeo.github.io/fgeo.map/reference/vft_1quad>?</a>   | vft\_1quad                                                                                  | Small ViewFullTables from Luquillo.        |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/vft_1quad>?</a>  | vft\_1quad                                                                                  | Small ViewFullTables from Luquillo.        |
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a>      | datasets, elevation, habitat, stem5, stem6, taxa, tree5, tree6, vft\_4quad, tree6\_3species | Datasets from Luquillo, Puerto Rico.       |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a> | download\_data                                                                              | Download data from fgeo.data.              |
| <a href=https://forestgeo.github.io/fgeo.x/reference/x_example>?</a>     | x\_example                                                                                  | Path to directory containing example data. |
