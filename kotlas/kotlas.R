# library(remotes)
# remotes::install_github("ropensci/osmdata")

library(tidyverse)
library(osmdata)
library(showtext)
library(ggmap)
library(rvest)
library(sf)

font_add_google(name = "Cormorant Garamond", family = "Cormorant Garamond")
showtext_auto()

kotlas <- getbb("Kotlas Russia")

streets <- kotlas %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "motorway_link", "primary_link",
                            "secondary", "tertiary", "secondary_link", "tertiary_link",
                            "residential", "living_street", "unclassified", "service", "footway")) %>%
  osmdata_sf()

water <- kotlas %>%
  opq() %>%
  add_osm_feature(key = "natural", value = "water") %>%
  osmdata_sf()

railway <- kotlas %>%
  opq() %>%
  add_osm_feature(key = "railway", value="rail") %>%
  osmdata_sf()

ggplot() +
  geom_sf(data = water$osm_multipolygons,
          color = "transparent",
          fill = "steelblue",
          size = 0,
          alpha = .5) +
  geom_sf(data = railway$osm_lines
          , inherit.aes = FALSE
          , color = "#515b72"
          , linetype = "dotted"
          ) +
  geom_sf(data = streets$osm_lines
          , inherit.aes = FALSE
          , color = "#515b72"
          ) +
  coord_sf(xlim = c(46.572, 46.725)
           , ylim = c(61.219, 61.295)
           , expand = FALSE
           )  +
  theme_void() +
  theme(panel.background = element_rect(fill = 'azure', color = 'black')
        , plot.margin = unit(c(1, 1, 1, 1), "cm")
        , plot.title = element_text(size = 20, family = "Cormorant Garamond", face="bold", hjust=.5)
        , plot.subtitle = element_text(family = "Cormorant Garamond", size = 9, hjust=.5, margin=margin(2, 0, 5, 0))
        ) +
  labs(title = "KOTLAS", subtitle = "61.257°N / 46.649°E")
