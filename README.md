
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GroceryStoreHamiltonData

<!-- badges: start -->
<!-- badges: end -->

This package is an activity completed by [Zehui
Yin](https://zehuiyin.github.io/) for the course [GEOG 712 Reproducible
Research Workflow with GitHub and
R](https://academiccalendars.romcmaster.ca/preview_course.php?catoid=55&coid=274877),
taught by [Dr. Antonio Paez](https://experts.mcmaster.ca/display/paezha)
in Fall 2024.

It contains the data for the paper titled “[Food Deserts or Food Oases?
Predicting Grocery Store Locations in Hamilton,
Ontario](https://github.com/zehuiyin/grocery_store_hamilton),” which is
the final project for the course and is also hosted on GitHub.

## Installation

You can install the development version of `GroceryStoreHamiltonData`
from [GitHub](https://github.com) with:

``` r
if(!require(remotes)){
    install.packages("remotes")
    library(remotes)
}
remotes::install_github("zehuiyin/GroceryStoreHamiltonData")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(GroceryStoreHamiltonData)
```

Load and plot the `grocery_CT` vector data. This dataset includes the
geometry of all the census tracts in Hamilton and contains a variable
that shows the count of grocery stores in each census tract.

``` r
data("grocery_DA")
hist(grocery_DA$Freq,
     main = "Grocery Store Count of Census Dissemination Area in Hamilton",
     xlab = "Grocery Store Count")
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

Alternatively, we can use the `prepare_data()` function to obtain a
cleaned dataset, which I utilized in the paper “[Food Deserts or Food
Oases? Predicting Grocery Store Locations in Hamilton,
Ontario](https://github.com/zehuiyin/grocery_store_hamilton).”

``` r
grocery_DA <- prepare_data()
summary(grocery_DA[,c("Freq", "PCT_single_detached")])
#>       Freq         PCT_single_detached          geometry  
#>  Min.   :0.00000   Min.   :  0.00      MULTIPOLYGON :891  
#>  1st Qu.:0.00000   1st Qu.: 37.86      epsg:26917   :  0  
#>  Median :0.00000   Median : 72.44      +proj=utm ...:  0  
#>  Mean   :0.09877   Mean   : 63.79                         
#>  3rd Qu.:0.00000   3rd Qu.: 93.94                         
#>  Max.   :4.00000   Max.   :104.17                         
#>                    NA's   :4
```

# How to cite

Yin, Z. (2024). GroceryStoreHamiltonData: Data for the paper “Food
Deserts or Food Oases? Predicting Grocery Store Locations in Hamilton,
Ontario”. <https://github.com/zehuiyin/GroceryStoreHamiltonData>

``` latex
@Manual{GroceryStoreHamiltonData,
  title = {GroceryStoreHamiltonData: Data for the paper "Food Deserts or Food Oases? Predicting Grocery Store Locations in Hamilton, Ontario"},
  author = {Zehui Yin},
  year = {2024},
  note = {R package version 1.1},
  url = {https://github.com/zehuiyin/GroceryStoreHamiltonData}
}
```
