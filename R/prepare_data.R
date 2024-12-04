#' Prepare data for analysis
#'
#' This function aggregates grocery store counts and computes additional
#' variables based on raw census data. The function does not require any
#' arguments but does require internet access.
#'
#' @import sf
#' @import tidytransit
#' @import dplyr
#' @import units
#' @importFrom utils data
#' @importFrom stats quantile
#'
#' @return a data frame based on grocery_DA with additional variables
#' @format A \emph{sf} dataframe with 49 columns, the additional columns compared to the raw grocery_DA:
#' \describe{
#'   \item{hsr_level}{The quantile level transit stop number in that census DA (high, mid, or low)}
#'   \item{n_hsr_stops}{The transit stop number in that census DA}
#'   \item{n_hsr_stops_density}{The transit stop density per square kilometres in that census DA}
#'   \item{pop_density}{Population density per square kilometres}
#'   \item{log_pop_density}{Natural log of population density per square kilometres plus 1}
#'   \item{log_area}{Natural log of land area in square kilometres}
#'   \item{dist_to_downtown}{Euclidean distance from census DA centroid to Hamilton downton in metres}
#'   \item{log_dist_to_downtown}{Natural log of Euclidean distance from census DA centroid to Hamilton downton in metres}
#'   \item{PCT_aged_under_24}{Percentage of residents aged under 24 years old}
#'   \item{PCT_aged_above_65}{Percentage of residents aged above 65 years old}
#'   \item{PCT_single_detached}{Percentage of residents living in single detached houses}
#'   \item{PCT_married_common_law}{Percentage of residents married or living in common law}
#'   \item{PCT_income_less_40k}{Percentage of residents have household income less than 40k}
#'   \item{PCT_income_greater_100k}{Percentage of residents have household income greater than 100k}
#'   \item{PCT_dont_know_official_language}{Percentage of residents don't know/speak official languages}
#'   \item{PCT_not_speak_offcial_language_at_home}{Percentage of residents don't speak official languages at home}
#' }
#'
#' @export
#' @author Zehui Yin, \email{yinz39@mcmaster.ca}
#'
#' @examples
#' grocery_DA <- prepare_data()
#' summary(grocery_DA[,c("Freq", "PCT_single_detached")])
prepare_data <- function(){
  # read data
  data("grocery_DA", envir = environment())

  # reproject the data
  grocery_DA <- st_transform(grocery_DA, crs = 26917)

  # create a point for hamilton downtown
  hamilton_downtown <- st_as_sf(data.frame(list("name"="hamilton downtown",
                                                "x"=43.258657062558896,
                                                "y"=-79.8707987387457)),
                                crs = 4326, coords = c("y", "x"))
  hamilton_downtown <- st_transform(hamilton_downtown, crs = 26917)

  # read hsr GTFS
  hsr <- read_gtfs("https://github.com/zehuiyin/geog712package/raw/refs/heads/main/data-raw/fall2024_GTFS_static.zip")

  # convert to hsr stops
  hsr_stops <- st_as_sf(hsr$stops,
                        coords = c("stop_lon", "stop_lat"),
                        crs = 4326)
  hsr_stops <- st_transform(hsr_stops, crs = 26917)

  # compute the number of hsr stops in each DA
  st_agr(hsr_stops) = "constant"
  st_agr(grocery_DA) = "constant"
  stops_inter <- st_intersection(hsr_stops, grocery_DA)

  stop_count <- stops_inter |> st_drop_geometry() |> group_by(GeoUID) |> count()

  colnames(stop_count) <- c("GeoUID", "n_hsr_stops")

  grocery_DA <- merge(x = grocery_DA,
                      y = stop_count,
                      by = "GeoUID",
                      all.x = TRUE
  )

  grocery_DA[is.na(grocery_DA$n_hsr_stops),]$n_hsr_stops <- 0

  # normalize it with area size
  grocery_DA$n_hsr_stops_density <- grocery_DA$n_hsr_stops/
    grocery_DA$v_CA21_7..Land.area.in.square.kilometres

  # convert it into a factor
  hsr_level <- cut(grocery_DA$n_hsr_stops_density,
                   breaks = c(-1, quantile(grocery_DA$n_hsr_stops_density)[3:5]))

  levels(hsr_level) <- c("low" , "mid", "high")

  grocery_DA$hsr_level <- hsr_level

  # construct some independent variables

  # population density
  grocery_DA$pop_density <- grocery_DA$v_CA21_1..Population..2021/grocery_DA$v_CA21_7..Land.area.in.square.kilometres
  grocery_DA$log_pop_density <- log(grocery_DA$pop_density + 1)

  # log land area
  grocery_DA$log_area <- log(grocery_DA$v_CA21_7..Land.area.in.square.kilometres)

  # calculate distance to downtown
  st_agr(grocery_DA) = "constant"
  grocery_DA$dist_to_downtown <- st_distance(st_centroid(grocery_DA),
                                             hamilton_downtown) |> drop_units()
  grocery_DA$log_dist_to_downtown <- log(grocery_DA$dist_to_downtown)

  # percentage of people age from 0 - 24
  grocery_DA$PCT_aged_under_24 <- (grocery_DA$v_CA21_11..0.to.14.years +
                                     grocery_DA$v_CA21_89..20.to.24.years)/
    grocery_DA$v_CA21_8..Total...Age*100

  # percentage of people aged above 65
  grocery_DA$PCT_aged_above_65 <- grocery_DA$v_CA21_251..65.years.and.over/
    grocery_DA$v_CA21_8..Total...Age*100

  # percentage of people living in single detached house
  grocery_DA$PCT_single_detached <- grocery_DA$v_CA21_435..Single.detached.house/
    grocery_DA$v_CA21_434..Occupied.private.dwellings.by.structural.type.of.dwelling.data*100

  # percentage of people married or living common-law
  grocery_DA$PCT_married_common_law <- grocery_DA$v_CA21_456..Married.or.living.common.law/
    grocery_DA$v_CA21_453..Marital.status.for.the.total.population.aged.15.years.and.over*100

  # percentage of people with income less than 40k
  grocery_DA$PCT_income_less_40k <- (grocery_DA$v_CA21_674..Under..10.000..including.loss. +
                                       grocery_DA$v_CA21_677...10.000.to..19.999 +
                                       grocery_DA$v_CA21_680...20.000.to..29.999 +
                                       grocery_DA$v_CA21_683...30.000.to..39.999)/
    grocery_DA$v_CA21_671..With.total.income*100

  # percentage of people with income greater than 100k
  grocery_DA$PCT_income_greater_100k <- (grocery_DA$v_CA21_707...100.000.to..149.999 +
                                           grocery_DA$v_CA21_710...150.000.and.over)/
    grocery_DA$v_CA21_671..With.total.income*100

  # percentage of population with no knowledge of official language
  grocery_DA$PCT_dont_know_official_language <- grocery_DA$v_CA21_1156..Neither.English.nor.French/
    grocery_DA$v_CA21_1144..Knowledge.of.official.languages.for.the.total.population.excluding.institutional.residents*100

  # percentage of population who don't speak official language at home
  grocery_DA$PCT_not_speak_offcial_language_at_home <- grocery_DA$v_CA21_2176..Non.official.language/
    grocery_DA$v_CA21_2167..All.languages.spoken.at.home.for.the.total.population.excluding.institutional.residents*100

  return(grocery_DA)
}
