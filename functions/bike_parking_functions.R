

#' Create New Bike Parking Reference
#' 
#' name and address are required
#' the other parameters are optional
#'
#' @param name string uniquely identifying location
#' might be something like 'USPS-SILVERDALE' or 'BETHEL GRAVITY COFFEE'
#' if you supply a name already in bike parking, it may be confusing
#' @param address string postal address of location of bike rack
#' You can find this by searching the location in Maps.
#' A complete address, like "123 Elm St, Bremerton WA 98312" is best
#' @param desc string describing the location of the bike rack on the premises. 
#' You roll up to the Safeway - where should you look to find the rack?
#' Something like "on the south side" or "to the right of entrance"
#' @param variant string what kind of rack is it?
#' ideally, one of GRID, WAVE, BOLLARD, STAPLE, CUSTOM, 
#' defaults to OTHER
#' @param covered string YES, NO is it covered? 
#' defaults to NO
#' @param spaces int how many bikes can probably park here at once?
#' @param image string name of the image stored in img/racks/
#' like "Bethel Gravity Coffee.jpg"
#'
#' @return
#' @export
#'
#' @examples
create_new <- function(name, address, desc = NA,
                       variant = c("OTHER","GRID","WAVE",
                                   "BOLLARD","STAPLE","CUSTOM"), 
                       covered = c("NO","YES"), # defaults to NO
                       spaces = 0,
                       image = NA){
  variant <- match.arg(variant, several.ok = FALSE)
  covered <- match.arg(covered, several.ok = FALSE)
  geocode <- mapboxapi::mb_geocode(address)
  return(tibble::tibble(NAME = name,
          ADDRESS = address,
          DESC = desc,
          VARIANT = variant,
          COVERED = covered,
          SPACES = spaces,
          IMG = image,
          LNG = geocode[1],
          LAT = geocode[2]
          ) )
}

add_new <- function(new_row){
  bikeparking <- get_bike_parking_data(local = TRUE)
  bikeparking <- bikeparking %>%
    tibble::add_row(new_row)
  return(bikeparking)
}

# this is in one fell swoop and shoule probably be avoided
update_bikeparking_with_new <- function(name, address, desc = NA,
                                        variant = c("OTHER","GRID","WAVE",
                                                    "BOLLARD","STAPLE","CUSTOM"), 
                                        covered = c("NO","YES"), # defaults to NO
                                        spaces = 0,
                                        image = NA) {
  new_row <- create_new(name, address, desc,variant,covered,spaces,image)
  new_bikeparking <- add_new(new_row = new_row)
  save_bike_parking_data(new_bikeparking)
}



get_bike_parking_path <- function(local = TRUE) {
  if(local) {
    return("./kitsap-bike-parking.csv")
  } else {
    return("https://raw.githubusercontent.com/monkeywithacupcake/kitsap-bike-parking/main/kitsap-bike-parking.csv")
  }
}

get_rack_image_path <- function(local = TRUE) {
  if(local) {
    return("./img/racks/")
  } else {
    return("https://raw.githubusercontent.com/monkeywithacupcake/kitsap-bike-parking/main/img/racks/")
  }
}

get_bike_parking_data <- function(local = TRUE) {
  dpath <- get_bike_parking_path(local)
  readr::read_csv(dpath)
}

save_bike_parking_data <- function(bikeparking){
  readr::write_csv(bikeparking, file="./kitsap-bike-parking.csv")
}