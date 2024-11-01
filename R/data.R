#' Data Source Information
#'
#' This is a dataframe containing the information about all the raw data in
#' this package
#'
#' @format A dataframe with 3 columns:
#' \describe{
#'   \item{Name}{Data Name: the name of the dataset.}
#'   \item{URL}{Source (URL): the link where the data is downloaded.}
#'   \item{Date}{Accessed Date: the date when the data is downloaded.}
#' }
#'
#' @name data_source
#' @docType data
#' @keywords datasets
#' @examples
#' data(data_source)
#' summary(data_source)
#' head(data_source)
NULL

#' Grocery Stores in Census Tracts in Hamilton
#'
#' This is a \emph{sf} dataframe containing the information about the number of grocery
#' stores in each Census Tract in Hamilton
#'
#' @format A \emph{sf} dataframe with 4 columns:
#' \describe{
#'   \item{GEOUID}{The unique ID for the geographical unit}
#'   \item{POP21}{The population count in the census tract from 2021 Canadian Census}
#'   \item{Grocery}{The number of grocery stores in that census tract}
#'   \item{geometry}{Geometry column for \emph{sf} dataframe}
#' }
#'
#' @name grocery_CT
#' @docType data
#' @keywords datasets
#' @examples
#' data(grocery_CT)
#' summary(grocery_CT[,c("GEOUID", "POP21", "Grocery")])
#' head(grocery_CT[,c("GEOUID", "POP21", "Grocery")])
NULL
