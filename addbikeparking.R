
# allows us to add a new bike parking spot
source("./functions/bike_parking_functions.R")

the_new_row <- create_new(
  name = 'fake',
  address = "731 Bethel Ave, Port Orchard, WA 98366",
  image = "Bethel Gravity Coffee.jpg",
  desc = "On the south side",
  spaces = 4,
  covered = "NO",
  variant = "WAVE"
)
new_row <- create_new(name, address, desc,variant,covered,spaces,image)
new_bikeparking <- add_new(new_row = new_row)
stop() # make sure that you are satisfied before saving
save_bike_parking_data(new_bikeparking)

# now go update the interactive_map.Rmd and publish



