# library(remotes)
# remotes::install_github("ropensci/osmdata")

library(tidyverse)
library(osmdata)
library(showtext)
library(ggmap)
library(rvest)

severo <- getbb("severomorsk")

big_streets <- severo %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway"
                            , "primary"
                            , "motorway_link"
                            , "primary_link")
                 ) %>%
  osmdata_sf()

med_streets <- severo %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("secondary"
                            , "tertiary"
                            , "secondary_link"
                            , "tertiary_link")
                 ) %>%
  osmdata_sf()

small_streets <- severo %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("residential"
                            , "living_street"
                            , "unclassified"
                            , "service"
                            , "footway")
                 ) %>%
  osmdata_sf()

water <- severo %>%
  opq() %>%
  add_osm_feature(key = "natural", value = "water") %>%
  osmdata_sf()

railway <- severo %>%
  opq() %>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()

military <- severo %>%
  opq()%>%
  add_osm_feature(key = "landuse", value="military") %>%
  osmdata_sf()

font_add_google(name = "Lato", family = "lato")
showtext_auto()

ggplot() +
  geom_sf(data = water$osm_multipolygons,
          inherit.aes = FALSE,
          fill = "steelblue",
          size = .2,
          alpha = .5) +
  geom_sf(data = military$osm_polygons,
          inherit.aes = FALSE,
          fill = "red",
          size = .2,
          alpha = .3) +
  geom_sf(data = railway$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .7,
          linetype="dotdash",
          alpha = .5) +
  geom_sf(data = med_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .5,
          alpha = .5) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#666666",
          size = .4,
          alpha = .3) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .9,
          alpha = .6) +
  coord_sf(xlim = c(33.36, 33.45),
           ylim = c(69.055, 69.09),
           expand = FALSE)  +
  theme_void() +
  theme(panel.background = element_rect(fill = 'white', color = 'black')
        , plot.title = element_text(vjust = - 11)
        , plot.subtitle = element_text(vjust = - 30)
       ) +
  theme(plot.title = element_text(size = 20
                                  , family = "lato"
                                  , face="bold"
                                  , hjust=.5
                                 ),
        plot.subtitle = element_text(family = "lato"
                                     , size = 8
                                     , hjust=.5
                                     , margin=margin(2, 0, 5, 0)
                                    )
       ) +
  labs(title = "SEVEROMORSK", subtitle = "69.067°N/33.415°E")
