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
#' @author Zehui Yin, \email{yinz39@mcmaster.ca}
#' @examples
#' data(data_source)
#' summary(data_source)
#' head(data_source)
NULL

#' Grocery Stores in Census Dissemination Area in Hamilton
#'
#' This is a \emph{sf} dataframe containing the information about the number of grocery
#' stores in and census information about each Census dissemination area in Hamilton
#'
#' @format A \emph{sf} dataframe with 33 columns:
#' \describe{
#'   \item{GeoUID}{The unique ID for the geographical unit}
#'   \item{v_CA21_1}{The population count in the census dissemination area from 2021 Canadian Census}
#'   \item{v_CA21_7}{Land area in square kilometres}
#'   \item{v_CA21_8}{Total number of population in the census track with a valid age value}
#'   \item{v_CA21_11}{Total number of population between 0 to 14 years old}
#'   \item{v_CA21_10}{Total number of female population in the census track with a valid age value}
#'   \item{v_CA21_251}{Total number of population aged 65 years old or above}
#'   \item{v_CA21_71}{Total number of population aged 15 to 19 years old}
#'   \item{v_CA21_89}{Total number of population aged 20 to 24 years old}
#'   \item{v_CA21_435}{Total number of population live in single detached house}
#'   \item{v_CA21_434}{Total number of population with a valid value in occupied private dwelling by structural type of dwelling data}
#'   \item{v_CA21_453}{Total number of population with a valid value in marital status for the total population aged 15 years and over}
#'   \item{v_CA21_456}{Total number of population married or living common-law}
#'   \item{v_CA21_1142}{Gini index on adjusted household after tax income}
#'   \item{v_CA21_1144}{Total number of population with a valid value in knowledge of official languages excluding institutional residents}
#'   \item{v_CA21_671}{Total number of population with total income in 2020}
#'   \item{v_CA21_674}{Total number of population with income less than 10,000}
#'   \item{v_CA21_677}{Total number of population with income from 10,000 to 19,999}
#'   \item{v_CA21_680}{Total number of population with income from 20,000 to 29,999}
#'   \item{v_CA21_683}{Total number of population with income from 30,000 to 39,999}
#'   \item{v_CA21_686}{Total number of population with income from 40,000 to 49,999}
#'   \item{v_CA21_689}{Total number of population with income from 50,000 to 59,999}
#'   \item{v_CA21_692}{Total number of population with income from 60,000 to 69,999}
#'   \item{v_CA21_695}{Total number of population with income from 70,000 to 79,999}
#'   \item{v_CA21_698}{Total number of population with income from 80,000 to 89,999}
#'   \item{v_CA21_701}{Total number of population with income from 90,000 to 99,999}
#'   \item{v_CA21_707}{Total number of population with income from 100,000 to 149,999}
#'   \item{v_CA21_710}{Total number of population with income from 150,000 and over}
#'   \item{v_CA21_1156}{Total number of population with no knowledge of neither English or French}
#'   \item{v_CA21_2176}{Total number of population whose language spoken at home is non-official language}
#'   \item{v_CA21_2167}{Total number of population with a valid value in all languages spoken at home excluding institutional residents}
#'   \item{Freq}{The number of grocery stores in that census dissemination area}
#'   \item{geometry}{Geometry column for \emph{sf} dataframe}
#' }
#'
#' @name grocery_DA
#' @docType data
#' @keywords datasets
#' @import sf
#' @author Zehui Yin, \email{yinz39@mcmaster.ca}
#' @examples
#' data(grocery_DA)
#' summary(grocery_DA[,c("GeoUID", "Freq")])
#' head(grocery_DA[,c("GeoUID", "Freq")])
NULL
