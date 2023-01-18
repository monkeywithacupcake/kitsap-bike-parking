
# allows us to add a new bike parking spot

library(tidyverse)
library(mapboxapi)


newaddress <- "10444 Silverdale Way NW, Silverdale, WA 98383"
newname <-"MCDONALDS SILVERDALE"
newimage <- "McDonalds Silverdale.jpg" # NA if none
newdesc <- "Silverdale Way side front"
newvariant <- "STAPLE" #VARIANT GRID WAVE BOLLARD STAPLE CUSTOM
newcovered <- "NO" #YESNO
newspaces <- 1 # number

# read it in
bikeparking <- read_csv("~/Documents/kitsap-bike-parking/kitsap-bike-parking.csv") 

# add the stuff
bikeparking <- bikeparking %>%
  add_row(NAME = newname,
          ADDRESS = newaddress,
          DESC = newdesc,
          VARIANT = newvariant,
          COVERED = newcovered,
          SPACES = newspaces,
          IMG = newimage,
          LNG = mb_geocode(newaddress)[1],
          LAT = mb_geocode(newaddress)[2]
  )

write_csv(bikeparking, file="~/Documents/kitsap-bike-parking/kitsap-bike-parking.csv")



# mapbox_map <- leaflet() %>%
#   addMapboxTiles(style_id = "light-v9",
#                  username = "mapbox") %>%
#   setView(lng = -122.6413,
#           lat = 47.6477,
#           zoom = 11)
# 
# mapbox_map %>% 
#   leaflet() %>%
#   setView(lng = -122.6413,
#           lat = 47.6477,
#           zoom = 11)%>%
#   addTiles() %>%
#   addCircleMarkers(data = bikeparking, lng = ~LNG, lat = ~LAT, color = "#301934",
#                    label = ~NAME, radius = 7,  fillOpacity = 0.7, fillColor = "#D8BFD8") 
#markerOptions(interactive = FALSE))
#labelOptions(noHide = TRUE, permanent = TRUE))






