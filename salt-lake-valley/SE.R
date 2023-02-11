library(rayshader)
localtif = raster::raster("ASTGTMV003_N40W112_dem.tif")
elmat = raster_to_matrix(localtif)

elmat %>%
  sphere_shade(texture = "imhof4") %>%
  add_water(detect_water(elmat), color = "imhof4") %>%
  plot_3d(elmat, zscale = 10, fov = 0, theta = 135, zoom = 0.75, phi = 45, windowsize = c(1000, 800))
Sys.sleep(0.2)
render_snapshot()
