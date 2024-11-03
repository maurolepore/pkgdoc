
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

You can easily organize the documentation by package or concept
(`#' @family`):

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
subset(docs, concept == "Datasets available by data()")
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

subset(docs, concept == "utilities")
#> # A tibble: 0 × 5
#> # ℹ 5 variables: topic <chr>, alias <chr>, title <chr>, concept <chr>,
#> #   package <chr>
```

You can make links clickable with `DT::datatable()` or `knitr::kable()`.

``` r
template <- "<a href=https://www.rdocumentation.org/packages/%s/versions/3.6.2/topics/%s>?</a>"
linked <- transform(docs, topic = sprintf(template, package, topic))
knitr::kable(linked)
```

| topic | alias | title | concept | package |
|:---|:---|:---|:---|:---|
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/.print.via.format>?</a> | .print.via.format | Printing Utilities | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Adobe_glyphs>?</a> | Adobe_glyphs, charset_to_Unicode | Conversion Tables between Character Sets | Datasets available by data() | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/AirPassengers>?</a> | AirPassengers | Monthly Airline Passenger Numbers 1949-1960 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BJsales>?</a> | BJsales, BJsales.lead | Sales Data with Leading Indicator | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/BOD>?</a> | BOD | Biochemical Oxygen Demand | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/CO2>?</a> | CO2 | Carbon Dioxide Uptake in Grass Plants | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/CRAN_package_db>?</a> | CRAN_package_db, CRAN_check_results, CRAN_check_details, CRAN_check_issues, summarize_CRAN_check_status, R_CRAN_WEB, R_CRAN_SRC | CRAN Package Repository Tools | NA | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/ChickWeight>?</a> | ChickWeight | Weight versus age of chicks on different diets | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/DNase>?</a> | DNase | Elisa assay of DNase | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/EuStockMarkets>?</a> | EuStockMarkets | Daily Closing Prices of Major European Stock Indices, 1991-1998 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Formaldehyde>?</a> | Formaldehyde | Determination of Formaldehyde | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/HTMLheader>?</a> | HTMLheader | Generate a Standard HTML Header for R Help | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/HTMLheader>?</a> | HTMLheader | Generate a Standard HTML Header for R Help | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/HTMLheader>?</a> | HTMLheader | Generate a Standard HTML Header for R Help | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/HTMLheader>?</a> | HTMLheader | Generate a Standard HTML Header for R Help | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/HairEyeColor>?</a> | HairEyeColor | Hair and Eye Color of Statistics Students | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Harman23.cor>?</a> | Harman23.cor | Harman Example 2.3 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Harman74.cor>?</a> | Harman74.cor | Harman Example 7.4 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Indometh>?</a> | Indometh | Pharmacokinetics of Indomethacin | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/InsectSprays>?</a> | InsectSprays | Effectiveness of Insect Sprays | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/JohnsonJohnson>?</a> | JohnsonJohnson | Quarterly Earnings per Johnson & Johnson Share | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/LakeHuron>?</a> | LakeHuron | Level of Lake Huron 1875-1972 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/LifeCycleSavings>?</a> | LifeCycleSavings | Intercountry Life-Cycle Savings Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Loblolly>?</a> | Loblolly | Growth of Loblolly Pine Trees | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Nile>?</a> | Nile | Flow of the River Nile | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Orange>?</a> | Orange | Growth of Orange Trees | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/OrchardSprays>?</a> | OrchardSprays | Potency of Orchard Sprays | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/PlantGrowth>?</a> | PlantGrowth | Results from an Experiment on Plant Growth | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Puromycin>?</a> | Puromycin | Reaction Velocity of an Enzymatic Reaction | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/QC>?</a> | QC, checkDocFiles, checkDocStyle, checkReplaceFuns, checkS3methods, checkRdContents, nonS3methods, langElts, print | QC Checks for R Code and/or Documentation | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/QC>?</a> | QC, checkDocFiles, checkDocStyle, checkReplaceFuns, checkS3methods, checkRdContents, nonS3methods, langElts, print | QC Checks for R Code and/or Documentation | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/QC>?</a> | QC, checkDocFiles, checkDocStyle, checkReplaceFuns, checkS3methods, checkRdContents, nonS3methods, langElts, print | QC Checks for R Code and/or Documentation | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/QC>?</a> | QC, checkDocFiles, checkDocStyle, checkReplaceFuns, checkS3methods, checkRdContents, nonS3methods, langElts, print | QC Checks for R Code and/or Documentation | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/R_user_dir>?</a> | R_user_dir | R User Directories | NA | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rcmd>?</a> | Rcmd | ‘R CMD’ Interface | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd2HTML>?</a> | Rd2txt, Rd2HTML, Rd2ex, Rd2latex | Rd Converters | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd2txt_options>?</a> | Rd2txt_options | Set Formatting Options for Text Help | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/RdTextFilter>?</a> | RdTextFilter | Select Text in an Rd File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/RdTextFilter>?</a> | RdTextFilter | Select Text in an Rd File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/RdTextFilter>?</a> | RdTextFilter | Select Text in an Rd File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/RdTextFilter>?</a> | RdTextFilter | Select Text in an Rd File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd_db>?</a> | Rd_db | Rd Utilities | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd_db>?</a> | Rd_db | Rd Utilities | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd_db>?</a> | Rd_db | Rd Utilities | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rd_db>?</a> | Rd_db | Rd Utilities | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rdiff>?</a> | Rdiff | Difference R Output Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rdindex>?</a> | Rdindex | Generate Index from Rd Files | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rdindex>?</a> | Rdindex | Generate Index from Rd Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rdindex>?</a> | Rdindex | Generate Index from Rd Files | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/Rdindex>?</a> | Rdindex | Generate Index from Rd Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/SweaveTeXFilter>?</a> | SweaveTeXFilter | Strip R Code out of Sweave File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/SweaveTeXFilter>?</a> | SweaveTeXFilter | Strip R Code out of Sweave File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/SweaveTeXFilter>?</a> | SweaveTeXFilter | Strip R Code out of Sweave File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/SweaveTeXFilter>?</a> | SweaveTeXFilter | Strip R Code out of Sweave File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Theoph>?</a> | Theoph | Pharmacokinetics of Theophylline | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/Titanic>?</a> | Titanic | Survival of passengers on the Titanic | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/ToothGrowth>?</a> | ToothGrowth | The Effect of Vitamin C on Tooth Growth in Guinea Pigs | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/UCBAdmissions>?</a> | UCBAdmissions | Student Admissions at UC Berkeley | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/UKDriverDeaths>?</a> | UKDriverDeaths, Seatbelts | Road Casualties in Great Britain 1969-84 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/UKLungDeaths>?</a> | UKLungDeaths, ldeaths, fdeaths, mdeaths | Monthly Deaths from Lung Diseases in the UK | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/UKgas>?</a> | UKgas | UK Quarterly Gas Consumption | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/USAccDeaths>?</a> | USAccDeaths | Accidental Deaths in the US 1973-1978 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/USArrests>?</a> | USArrests | Violent Crime Rates by US State | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/USJudgeRatings>?</a> | USJudgeRatings | Lawyers’ Ratings of State Judges in the US Superior Court | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/USPersonalExpenditure>?</a> | USPersonalExpenditure | Personal Expenditure Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/VADeaths>?</a> | VADeaths | Death Rates in Virginia (1940) | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/WWWusage>?</a> | WWWusage | Internet Usage per Minute | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/WorldPhones>?</a> | WorldPhones | The World’s Telephones | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/ability.cov>?</a> | ability.cov | Ability and Intelligence Tests | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/add_datalist>?</a> | add_datalist | Add a ‘datalist’ File to a Source Package | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/airmiles>?</a> | airmiles | Passenger Miles on Commercial US Airlines, 1937-1960 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/airquality>?</a> | airquality | New York Air Quality Measurements | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/anscombe>?</a> | anscombe | Anscombe’s Quartet of ‘Identical’ Simple Linear Regressions | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/assertCondition>?</a> | assertCondition, assertWarning, assertError | Asserting Error Conditions | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/assertCondition>?</a> | assertCondition, assertWarning, assertError | Asserting Error Conditions | Error Handling | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/assertCondition>?</a> | assertCondition, assertWarning, assertError | Asserting Error Conditions | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/assertCondition>?</a> | assertCondition, assertWarning, assertError | Asserting Error Conditions | Error Handling | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/attenu>?</a> | attenu | The Joyner-Boore Attenuation Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/attitude>?</a> | attitude | The Chatterjee-Price Attitude Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/austres>?</a> | austres | Quarterly Time Series of the Number of Australian Residents | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/beavers>?</a> | beavers, beaver1, beaver2 | Body Temperature Series of Two Beavers | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/bibstyle>?</a> | bibstyle, getBibstyle | Select or Define a Bibliography Style | utilties | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/bibstyle>?</a> | bibstyle, getBibstyle | Select or Define a Bibliography Style | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/buildVignette>?</a> | buildVignette | Build One Vignette | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/buildVignettes>?</a> | buildVignettes, pkgVignettes | List and Build Package Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/buildVignettes>?</a> | buildVignettes, pkgVignettes | List and Build Package Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/buildVignettes>?</a> | buildVignettes, pkgVignettes | List and Build Package Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/buildVignettes>?</a> | buildVignettes, pkgVignettes | List and Build Package Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/cars>?</a> | cars | Speed and Stopping Distances of Cars | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkFF>?</a> | checkFF, print | Check Foreign Function Calls | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkFF>?</a> | checkFF, print | Check Foreign Function Calls | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkFF>?</a> | checkFF, print | Check Foreign Function Calls | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkFF>?</a> | checkFF, print | Check Foreign Function Calls | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkMD5sums>?</a> | checkMD5sums | Check and Create MD5 Checksum Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkPoFiles>?</a> | checkPoFile, checkPoFiles | Check Translation Files for Inconsistent Format Strings | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkRd>?</a> | checkRd | Check an Rd Object | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkRd>?</a> | checkRd | Check an Rd Object | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkRd>?</a> | checkRd | Check an Rd Object | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkRd>?</a> | checkRd | Check an Rd Object | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkRdaFiles>?</a> | checkRdaFiles, resaveRdaFiles | Report on Details of Saved Images or Re-saves them | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkTnF>?</a> | checkTnF, print | Check R Packages or Code for T/F | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkTnF>?</a> | checkTnF, print | Check R Packages or Code for T/F | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkTnF>?</a> | checkTnF, print | Check R Packages or Code for T/F | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkTnF>?</a> | checkTnF, print | Check R Packages or Code for T/F | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkVignettes>?</a> | checkVignettes, print | Check Package Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkVignettes>?</a> | checkVignettes, print | Check Package Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkVignettes>?</a> | checkVignettes, print | Check Package Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/checkVignettes>?</a> | checkVignettes, print | Check Package Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/check_packages_in_dir>?</a> | check_packages_in_dir, summarize_check_packages_in_dir_depends, summarize_check_packages_in_dir_results, summarize_check_packages_in_dir_timings, check_packages_in_dir_changes, check_packages_in_dir_details | Check Source Packages and Their Reverse Dependencies | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/chickwts>?</a> | chickwts | Chicken Weights by Feed Type | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/co2>?</a> | co2 | Mauna Loa Atmospheric CO2 Concentration | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/codoc>?</a> | codoc, codocClasses, codocData, print | Check Code/Documentation Consistency | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/compactPDF>?</a> | compactPDF, format | Compact PDF Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/crimtab>?</a> | crimtab | Student’s 3000 Criminals Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/datasets-package>?</a> | datasets-package, datasets | The R Datasets Package | Package Summaries | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/delimMatch>?</a> | delimMatch | Delimited Pattern Matching | Character Data (“String”) Operations | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/dependsOnPkgs>?</a> | dependsOnPkgs | Find Reverse Dependencies | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/discoveries>?</a> | discoveries | Yearly Numbers of Important Discoveries | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/encoded_text_to_latex>?</a> | encoded_text_to_latex | Translate non-ASCII Text to LaTeX Escapes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/esoph>?</a> | esoph | Smoking, Alcohol and (O)esophageal Cancer | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/euro>?</a> | euro, euro.cross | Conversion Rates of Euro Currencies | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/eurodist>?</a> | eurodist, UScitiesD | Distances Between European Cities and Between US Cities | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/faithful>?</a> | faithful | Old Faithful Geyser Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/file_ext>?</a> | file_ext, file_path_as_absolute, file_path_sans_ext, list_files_with_exts, list_files_with_type | File Utilities | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/findHTMLlinks>?</a> | findHTMLlinks | Collect HTML Links from Package Documentation | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/find_gs_cmd>?</a> | find_gs_cmd, R_GSCMD, GSC | Find a GhostScript Executable | NA | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/freeny>?</a> | freeny, freeny.x, freeny.y | Freeny’s Revenue Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/getVignetteInfo>?</a> | getVignetteInfo | Get Information on Installed Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/getVignetteInfo>?</a> | getVignetteInfo | Get Information on Installed Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/getVignetteInfo>?</a> | getVignetteInfo | Get Information on Installed Vignettes | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/getVignetteInfo>?</a> | getVignetteInfo | Get Information on Installed Vignettes | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/infert>?</a> | infert | Infertility after Spontaneous and Induced Abortion | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/iris>?</a> | iris, iris3 | Edgar Anderson’s Iris Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/islands>?</a> | islands | Areas of the World’s Major Landmasses | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/lh>?</a> | lh | Luteinizing Hormone in Blood Samples | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/loadRdMacros>?</a> | loadRdMacros, loadPkgRdMacros | Load User-defined Rd Help System Macros | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/loadRdMacros>?</a> | loadRdMacros, loadPkgRdMacros | Load User-defined Rd Help System Macros | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/loadRdMacros>?</a> | loadRdMacros, loadPkgRdMacros | Load User-defined Rd Help System Macros | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/loadRdMacros>?</a> | loadRdMacros, loadPkgRdMacros | Load User-defined Rd Help System Macros | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/longley>?</a> | longley | Longley’s Economic Regression Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/lynx>?</a> | lynx | Annual Canadian Lynx trappings 1821-1934 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/makeLazyLoading>?</a> | makeLazyLoading | Lazy Loading of Packages | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/make_translations_pkg>?</a> | make_translations_pkg | Package the Current Translations in the R Sources | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/makevars_user>?</a> | makevars_user, makevars_site | User and Site Compilation Variables | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/matchConcordance>?</a> | matchConcordance, as.character, as.Rconcordance, Rconcordance, activeConcordance, followConcordance | Concordance between source and target lines | NA | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/md5sum>?</a> | md5sum | Compute MD5 Checksums | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/morley>?</a> | morley | Michelson Speed of Light Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/mtcars>?</a> | mtcars | Motor Trend Car Road Tests | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/nhtemp>?</a> | nhtemp | Average Yearly Temperatures in New Haven | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/nottem>?</a> | nottem | Average Monthly Temperatures at Nottingham, 1920-1939 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/npk>?</a> | npk | Classical N, P, K Factorial Experiment | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/occupationalStatus>?</a> | occupationalStatus | Occupational Status of Fathers and their Sons | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/package_dependencies>?</a> | package_dependencies | Computations on the Dependency Hierarchy of Packages | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/package_native_routine_registration_skeleton>?</a> | package_native_routine_registration_skeleton | Write Skeleton for Adding Native Routine Registration to a Package | NA | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parseLatex>?</a> | parseLatex, deparseLatex, latexToUtf8 | Experimental Functions to Work with LaTeX Code | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parseLatex>?</a> | parseLatex, deparseLatex, latexToUtf8 | Experimental Functions to Work with LaTeX Code | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parseLatex>?</a> | parseLatex, deparseLatex, latexToUtf8 | Experimental Functions to Work with LaTeX Code | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parseLatex>?</a> | parseLatex, deparseLatex, latexToUtf8 | Experimental Functions to Work with LaTeX Code | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parse_Rd>?</a> | parse_Rd, print, as.character | Parse an Rd File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parse_Rd>?</a> | parse_Rd, print, as.character | Parse an Rd File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parse_Rd>?</a> | parse_Rd, print, as.character | Parse an Rd File | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/parse_Rd>?</a> | parse_Rd, print, as.character | Parse an Rd File | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/pkg2HTML>?</a> | pkg2HTML | Rd Converters | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/precip>?</a> | precip | Annual Precipitation in US Cities | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/presidents>?</a> | presidents | Quarterly Approval Ratings of US Presidents | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/pressure>?</a> | pressure | Vapor Pressure of Mercury as a Function of Temperature | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/pskill>?</a> | pskill, SIGHUP, SIGINT, SIGQUIT, SIGKILL, SIGTERM, SIGSTOP, SIGTSTP, SIGCONT, SIGCHLD, SIGUSR1, SIGUSR2 | Kill a Process | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/psnice>?</a> | psnice | Get or Set the Priority (Niceness) of a Process | utility | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/quakes>?</a> | quakes | Locations of Earthquakes off Fiji | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/randu>?</a> | randu | Random Numbers from Congruential Generator RANDU | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/read.00Index>?</a> | read.00Index | Read 00Index-style Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/read.00Index>?</a> | read.00Index | Read 00Index-style Files | Input/Output Connections | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/read.00Index>?</a> | read.00Index | Read 00Index-style Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/read.00Index>?</a> | read.00Index | Read 00Index-style Files | Input/Output Connections | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/rivers>?</a> | rivers | Lengths of Major North American Rivers | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/rock>?</a> | rock | Measurements on Petroleum Rock Samples | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/showNonASCII>?</a> | showNonASCII, showNonASCIIfile | Pick Out Non-ASCII Characters | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/sleep>?</a> | sleep | Student’s Sleep Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/stackloss>?</a> | stackloss, stack.loss, stack.x | Brownlee’s Stack Loss Plant Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/startDynamicHelp>?</a> | startDynamicHelp, help.ports, R_DISABLE_HTTPD | Start the Dynamic HTML Help System | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/state>?</a> | state, state.abb, state.area, state.center, state.division, state.name, state.region, state.x77 | US State Facts and Figures | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/sunspot.month>?</a> | sunspot.month | Monthly Sunspot Data, from 1749 to “Present” | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/sunspot.year>?</a> | sunspot.year | Yearly Sunspot Data, 1700-1988 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/sunspots>?</a> | sunspots | Monthly Sunspot Numbers, 1749-1983 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/swiss>?</a> | swiss | Swiss Fertility and Socioeconomic Indicators (1888) Data | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/testInstalledPackage>?</a> | testInstalledPackage, testInstalledPackages, testInstalledBasic, TEST_MC_CORES, standard_package_names | Test Installed Packages | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/texi2dvi>?</a> | texi2dvi, texi2pdf | Compile LaTeX Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toHTML>?</a> | toHTML | Display an Object in HTML | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toHTML>?</a> | toHTML | Display an Object in HTML | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toHTML>?</a> | toHTML | Display an Object in HTML | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toHTML>?</a> | toHTML | Display an Object in HTML | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toRd>?</a> | toRd | Generic Function to Convert Object to a Fragment of Rd Code | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toRd>?</a> | toRd | Generic Function to Convert Object to a Fragment of Rd Code | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toRd>?</a> | toRd | Generic Function to Convert Object to a Fragment of Rd Code | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toRd>?</a> | toRd | Generic Function to Convert Object to a Fragment of Rd Code | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/toTitleCase>?</a> | toTitleCase | Convert Titles to Title Case | NA | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-deprecated>?</a> | tools-deprecated | Deprecated Objects in Package ‘tools’ | Miscellaneous | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Package Summaries | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Package Summaries | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Package Summaries | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Programming | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/tools-package>?</a> | tools-package, tools | Tools for Package Development | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/treering>?</a> | treering | Yearly Tree-Ring Data, -6000-1979 | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/trees>?</a> | trees | Diameter, Height and Volume for Black Cherry Trees | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/undoc>?</a> | undoc, print | Find Undocumented Objects | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/update_PACKAGES>?</a> | update_PACKAGES | Update Existing PACKAGES Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/update_PACKAGES>?</a> | update_PACKAGES | Update Existing PACKAGES Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/update_PACKAGES>?</a> | update_PACKAGES | Update Existing PACKAGES Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/update_PACKAGES>?</a> | update_PACKAGES | Update Existing PACKAGES Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/update_pkg_po>?</a> | update_pkg_po | Prepare Translations for a Package | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/uspop>?</a> | uspop | Populations Recorded by the US Census | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/vignetteEngine>?</a> | vignetteEngine | Set or Get a Vignette Processing Engine | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/vignetteEngine>?</a> | vignetteEngine | Set or Get a Vignette Processing Engine | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/vignetteEngine>?</a> | vignetteEngine | Set or Get a Vignette Processing Engine | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/vignetteEngine>?</a> | vignetteEngine | Set or Get a Vignette Processing Engine | Documentation | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/vignetteInfo>?</a> | vignetteInfo | Basic Information about a Vignette | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/volcano>?</a> | volcano | Topographic Information on Auckland’s Maunga Whau Volcano | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/warpbreaks>?</a> | warpbreaks | The Number of Breaks in Yarn during Weaving | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/women>?</a> | women | Average Heights and Weights for American Women | Datasets available by data() | datasets |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/write_PACKAGES>?</a> | write_PACKAGES | Generate PACKAGES Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/write_PACKAGES>?</a> | write_PACKAGES | Generate PACKAGES Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/write_PACKAGES>?</a> | write_PACKAGES | Generate PACKAGES Files | Input/Output Files | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/write_PACKAGES>?</a> | write_PACKAGES | Generate PACKAGES Files | Utilities | tools |
| <a href=https://www.rdocumentation.org/packages/tools/versions/3.6.2/topics/xgettext>?</a> | xgettext, xngettext, xgettext2pot | Extract Translatable Messages from R Files in a Package | Utilities | tools |
