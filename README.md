
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc (deprecated)

See <https://github.com/maurolepore/dverse>

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/maurolepore/pkgdoc.svg?branch=master)](https://travis-ci.org/maurolepore/pkgdoc)
[![Coverage
status](https://coveralls.io/repos/github/maurolepore/pkgdoc/badge.svg)](https://coveralls.io/r/maurolepore/pkgdoc?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/pkgdoc)](https://cran.r-project.org/package=pkgdoc)

Dataframe the documentation of available packages, and reference objects
across multiple packages by package or concept. Combined with
`krittr::kable()` or `DT::datatable()`, **pkgdoc** allows you to
reference functions by package or concept across multiple packages and
to provide links to each topic’s help file (similar to the Reference
section of a [**pkgdown**](https://pkgdown.r-lib.org/) website but not
limited to a single package).

- [Reference and
  tutorial](https://maurolepore.github.io/pkgdoc/articles/siteonly/reference.html)
- [**pkgdoc** in
  action](https://forestgeo.github.io/fgeo/articles/siteonly/reference.html)

## Installation

``` r
# install.packages("devtools")
devtools::install_github("maurolepore/pkgdoc")
```

## Example

``` r
library(pkgdoc)
```

`search_docs()` creates a dataframe of documentation available to you.

``` r
# Documentation of all installed packages
search_docs()
#> Warning: `as.tibble()` was deprecated in tibble 2.0.0.
#> ℹ Please use `as_tibble()` instead.
#> ℹ The signature and semantics have changed, see `?as_tibble`.
#> ℹ The deprecated feature was likely used in the pkgdoc package.
#>   Please report the issue at <https://github.com/maurolepore/pkgdoc/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> # A tibble: 54,800 × 11
#>    package  libpath id    name  title topic encoding type  alias keyword concept
#>    <chr>    <chr>   <chr> <chr> <chr> <chr> <chr>    <chr> <chr> <chr>   <chr>  
#>  1 askpass  /home/… 1/1   askp… Pass… askp… "UTF-8"  help  askp… <NA>    <NA>   
#>  2 askpass  /home/… 1/2   ssh_… ASKP… ssh_… "UTF-8"  help  ssh_… <NA>    <NA>   
#>  3 base64e… /home/… 2/1   base… Enco… base… ""       help  base… manip   Data M…
#>  4 base64e… /home/… 2/1   base… Enco… base… ""       help  base… manip   Data M…
#>  5 base64e… /home/… 2/1   base… Enco… base… ""       help  base… manip   Data M…
#>  6 base64e… /home/… 2/2   chec… Chec… chec… ""       help  chec… manip   Data M…
#>  7 base64e… /home/… 2/3   data… Crea… data… ""       help  data… manip   Data M…
#>  8 bit      /home/… 3/1   Coer… Coer… Coer… "UTF-8"  help  Coer… classes Data T…
#>  9 bit      /home/… 3/1   Coer… Coer… Coer… "UTF-8"  help  Coer… classes Logica…
#> 10 bit      /home/… 3/1   Coer… Coer… Coer… "UTF-8"  help  Coer… logic   Data T…
#> # ℹ 54,790 more rows

some_packages <- c("utils", "base")
search_docs(some_packages)
#> # A tibble: 6,445 × 11
#>    package libpath  id    name  title topic encoding type  alias keyword concept
#>    <chr>   <chr>    <chr> <chr> <chr> <chr> <chr>    <chr> <chr> <chr>   <chr>  
#>  1 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   remain…
#>  2 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   modulo 
#>  3 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   modulus
#>  4 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   quotie…
#>  5 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   divisi…
#>  6 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  +     arith   Basic …
#>  7 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  -     arith   remain…
#>  8 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  -     arith   modulo 
#>  9 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  -     arith   modulus
#> 10 base    /opt/R/… 171/1 Arit… Arit… Arit… ""       help  -     arith   quotie…
#> # ℹ 6,435 more rows
```

`reference_package()` and `reference_concept()` allow you to pick
specific documentation.

``` r
reference_package(c("stats", "MASS"))
#> Warning:   All packages should be attached `strip_s3class` to work properly.
#>   Not attached: MASS
#> # A tibble: 977 × 5
#>    topic           alias                                   title concept package
#>    <chr>           <chr>                                   <chr> <chr>   <chr>  
#>  1 .checkMFClasses .checkMFClasses, .MFclass, .getXlevels  Func… Utilit… stats  
#>  2 print.ts        .preformat.ts, print                    Prin… Time S… stats  
#>  3 AIC             AIC, BIC                                Akai… Statis… stats  
#>  4 ARMAacf         ARMAacf                                 Comp… Time S… stats  
#>  5 ARMAtoMA        ARMAtoMA                                Conv… Time S… stats  
#>  6 Aids2           Aids2                                   Aust… Datase… MASS   
#>  7 Animals         Animals                                 Brai… Datase… MASS   
#>  8 Beta            Beta, dbeta, pbeta, qbeta, rbeta        The … incomp… stats  
#>  9 Beta            Beta, dbeta, pbeta, qbeta, rbeta        The … Probab… stats  
#> 10 Binomial        Binomial, dbinom, pbinom, qbinom, rbin… The … Probab… stats  
#> # ℹ 967 more rows

reference_concept(c("combine strings", "files", "PCA"))
#> # A tibble: 7 × 5
#>   topic            alias                                   title concept package
#>   <chr>            <chr>                                   <chr> <chr>   <chr>  
#> 1 find.package     find.package, path.package, packageNot… Find… files   base   
#> 2 paste            paste, paste0                           Conc… combin… base   
#> 3 prcomp           prcomp, plot, predict, print, summary   Prin… PCA     stats  
#> 4 princomp         princomp, plot, print, predict          Prin… PCA     stats  
#> 5 stri_read_lines  stri_read_lines                         Read… files   stringi
#> 6 stri_read_raw    stri_read_raw                           Read… files   stringi
#> 7 stri_write_lines stri_write_lines                        Writ… files   stringi
```

Use `knittr::kable()` or `DT::datatable()` for the links to become
clickable.

``` r
library(fgeo)
#> ── Attaching packages ──────────────────────────────────────────── fgeo 1.1.4 ──
#> ✔ fgeo.analyze 1.1.14     ✔ fgeo.tool    1.2.9 
#> ✔ fgeo.plot    1.1.11     ✔ fgeo.x       1.1.4
#> ── Conflicts ─────────────────────────────────────────────── fgeo_conflicts() ──
#> ✖ fgeo.tool::filter() masks stats::filter()

reference_concept(
  c("datasets", "plot functions"),
  url = "https://forestgeo.github.io/",
  ) %>% 
  arrange(concept) %>%
  head() %>% 
  knitr::kable()
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a> | datasets, elevation, habitat, stem5, stem6, tree5, tree6, vft_4quad, tree6_3species | Access data via ‘library(fgeo.x)’ or ‘fgeo.x::<dataset-name>’. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a> | download_data | Access data stored online. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/example_path>?</a> | example_path | Access data stored in system files. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.fgeo_habitat>?</a> | autoplot | Plot habitats. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot_by_species | List plots of species distribution and topography (good for pdf output). | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
