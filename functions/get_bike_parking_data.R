

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