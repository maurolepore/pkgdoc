
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgdoc

<!-- badges: start -->

[![R-CMD-check](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/maurolepore/pkgdoc/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/maurolepore/pkgdoc/graph/badge.svg)](https://app.codecov.io/gh/maurolepore/pkgdoc)
<!-- badges: end -->

The goal of pkgdoc is to make it easy to create a data frame of the
documentation of multiple packages. Combined with `krittr::kable()` or
`DT::datatable()`, pkgdoc allows you to organize documentation by
package or concept, and link each function or dataset to it’s
corresponding help file online.

If you develop a universe, like the tidyverse and tidymodels, pkgdoc
helps you to easily create a universe-wide reference for the pkgdown
website of your meta-package
([example](https://forestgeo.github.io/fgeo/articles/siteonly/reference.html#global-search)).

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

universe <- c("fgeo.x", "fgeo.plot")

universe |> 
  reference_package(url = "https://forestgeo.github.io/")
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

You can make links clickable with `DT::datatable()` or `knitr::kable()`.

``` r
universe |> 
  reference_package(url = "https://forestgeo.github.io/") |> 
  knitr::kable()
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.fgeo_habitat>?</a> | autoplot | Plot habitats. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.fgeo_habitat>?</a> | autoplot | Plot habitats. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | functions to plot elevation | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | functions to plot species | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot.sp_elev>?</a> | autoplot | Plot species distribution and/or topography. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot_by_species | List plots of species distribution and topography (good for pdf output). | functions to list plots from different ForestGEO classes | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot_by_species | List plots of species distribution and topography (good for pdf output). | functions to plot elevation | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot_by_species | List plots of species distribution and topography (good for pdf output). | functions to plot species | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/autoplot_by_species.sp_elev>?</a> | autoplot_by_species | List plots of species distribution and topography (good for pdf output). | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/datasets>?</a> | datasets, elevation, habitat, stem5, stem6, tree5, tree6, vft_4quad, tree6_3species | Access data via ‘library(fgeo.x)’ or ‘fgeo.x::<dataset-name>’. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/download_data>?</a> | download_data | Access data stored online. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/elev>?</a> | elev | Allow autoplotting the column ‘elev’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/elev>?</a> | elev | Allow autoplotting the column ‘elev’. | functions to construct fgeo classes | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/elev>?</a> | elev | Allow autoplotting the column ‘elev’. | functions to plot elevation | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/elev>?</a> | elev | Allow autoplotting the column ‘elev’. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.x/reference/example_path>?</a> | example_path | Access data stored in system files. | datasets | <a href=https://forestgeo.github.io/fgeo.x>fgeo.x</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_dbh_bubbles_by_quadrat>?</a> | plot_dbh_bubbles_by_quadrat | List dbh bubble-plots by quadrat (good for .pdf output). | functions to list plots from ForestGEO ViewFullTable | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_dbh_bubbles_by_quadrat>?</a> | plot_dbh_bubbles_by_quadrat | List dbh bubble-plots by quadrat (good for .pdf output). | functions to plot dbh bubbles | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_dbh_bubbles_by_quadrat>?</a> | plot_dbh_bubbles_by_quadrat | List dbh bubble-plots by quadrat (good for .pdf output). | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_tag_status_by_subquadrat>?</a> | plot_tag_status_by_subquadrat | List plots of tree-tag status by subquadrat (good for .pdf output). | functions to list plots from ForestGEO ViewFullTable | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_tag_status_by_subquadrat>?</a> | plot_tag_status_by_subquadrat | List plots of tree-tag status by subquadrat (good for .pdf output). | functions to plot tag status | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/plot_tag_status_by_subquadrat>?</a> | plot_tag_status_by_subquadrat | List plots of tree-tag status by subquadrat (good for .pdf output). | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp>?</a> | sp | Allow autoplotting the column ‘sp’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp>?</a> | sp | Allow autoplotting the column ‘sp’. | functions to construct fgeo classes | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp>?</a> | sp | Allow autoplotting the column ‘sp’. | functions to plot species | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp>?</a> | sp | Allow autoplotting the column ‘sp’. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | autoplots | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | functions to construct fgeo classes | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | functions to plot elevation | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | functions to plot species | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
| <a href=https://forestgeo.github.io/fgeo.plot/reference/sp_elev>?</a> | sp_elev | Allow autoplotting the columns ‘sp’ and ‘elev’. | plot functions | <a href=https://forestgeo.github.io/fgeo.plot>fgeo.plot</a> |
