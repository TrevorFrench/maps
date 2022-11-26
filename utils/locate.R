# SAN FRANCISCO
bbox <- list(
  p1 = list(long = -122.522, lat = 37.707),
  p2 = list(long = -122.354, lat = 37.84)
)

leaflet() %>%
  addTiles() %>%
  addRectangles(
    lng1 = bbox$p1$long, lat1 = bbox$p1$lat,
    lng2 = bbox$p2$long, lat2 = bbox$p2$lat,
    fillColor = "transparent"
  ) %>%
  fitBounds(
    lng1 = bbox$p1$long, lat1 = bbox$p1$lat,
    lng2 = bbox$p2$long, lat2 = bbox$p2$lat,
  )
