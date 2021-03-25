library(XML)
library(sf)
library(dplyr)
library(ggplot2)

tma_abstract <- XML::htmlParse("lit/graphics/abstract_tma.svg")

tma_abstract
p <- xpathSApply(tma_abstract, "//polygon", xmlGetAttr, "points")

p2 <- lapply(strsplit(p, " "), function(u) {
  # browser()
  mat <- matrix(
    as.numeric(
      unlist(strsplit(u, ","))
    ),
    ncol = 2,
    byrow = TRUE
  )

  mat[is.na(mat)] <- 0

  mat[nrow(mat), ] <- mat[1, ]

  return(mat)
})



tma_areas <- st_sfc(list(
  st_polygon(p2[1]),
  st_polygon(p2[2]),
  st_polygon(p2[3]),
  st_polygon(p2[4])
)) %>%
  st_as_sf() %>%
  mutate(market_area = c(4, 3, 2, 1))

plot(tma_areas)

bo <- st_bbox(tma_areas)

bo[1] <- st_bbox(tma_areas)[1] - 20
bo[2] <- st_bbox(tma_areas)[2] - 10
bo[3] <- st_bbox(tma_areas)[3] + 40
bo[4] <- st_bbox(tma_areas)[4] + 10


tma5 <- st_as_sfc(bo) %>%
  st_as_sf() %>%
  mutate(market_area = 5) %>%
  st_difference(tma_areas$x[4]) %>%
  st_difference(tma_areas$x[3]) %>%
  st_difference(tma_areas$x[2]) %>%
  st_difference(tma_areas$x[1])

plot(tma5)


tma_area_abstract <- rbind(tma_areas, tma5) %>%
  rename(geometry = x) %>%
  mutate(market_area = as.factor(market_area)) %>%
  arrange(market_area)

# make sure areas nest neatly -----
plot(tma_area_abstract[3, ])

tma_area_abstract[4, ] <- st_difference(tma_area_abstract[4, ], tma_area_abstract[3, ]) %>%
  select(-market_area.1)

tma_area_abstract[3, ] <- st_difference(tma_area_abstract[3, ], tma_area_abstract[2, ]) %>%
  select(-market_area.1)

tma_area_abstract[2, ] <- st_difference(tma_area_abstract[2, ], tma_area_abstract[1, ]) %>%
  select(-market_area.1)

# final touches -----

tma_area_abstract <- tma_area_abstract %>%
  mutate(
    tma_area_numeral = c("I", "II", "III", "IV", "V"),
    tma_desc_short = c(
      "Transit Market Area I has the highest density of population, employment, and lowest automobile availability. These are typically Urban Center communities and have a more traditional urban form with a street network laid out in grid form.",
      "Transit Market Area II has high to moderately high population and employment densities and typically has a traditional street grid comparable to Market Area I.",
      "Transit Market Area III has moderate density but tends to have a less traditional street grid that can limit the effectiveness of transit. It is typically Urban with large portions of Suburban and Suburban Edge communities.",
      "Transit Market Area IV has lower concentrations of population and employment and a higher rate of auto ownership. It is primarily composed of Suburban Edge and Emerging Suburban Edge communities.",
      "Transit Market Area V has very low population and employment densities and tends to be primarily Rural communities and Agricultural uses."
    ),
    hover_text = tma_desc_short
  )

usethis::use_data(tma_area_abstract, overwrite = T)



tma_detailed <- councilR::import_from_gpkg("https://resources.gisdata.mn.gov/pub/gdrs/data/pub/us_mn_state_metc/trans_transit_market_areas/gpkg_trans_transit_market_areas.zip") %>%
  janitor::clean_names() %>%
  filter(market_area %in% c(1:5)) %>%
  arrange(market_area) %>%
  mutate(
    tma_area_numeral = c("I", "II", "III", "IV", "V"),
    tma_desc_short = c(
      "Transit Market Area I has the highest density of population, employment, and lowest automobile availability. These are typically Urban Center communities and have a more traditional urban form with a street network laid out in grid form.",
      "Transit Market Area II has high to moderately high population and employment densities and typically has a traditional street grid comparable to Market Area I.",
      "Transit Market Area III has moderate density but tends to have a less traditional street grid that can limit the effectiveness of transit. It is typically Urban with large portions of Suburban and Suburban Edge communities.",
      "Transit Market Area IV has lower concentrations of population and employment and a higher rate of auto ownership. It is primarily composed of Suburban Edge and Emerging Suburban Edge communities.",
      "Transit Market Area V has very low population and employment densities and tends to be primarily Rural communities and Agricultural uses."
    ),
    hover_text = tma_desc_short
  )


roads <- sf::st_sfc(
  sf::st_linestring(x = rbind(
    c(114.6, 145.9),
    c(114.6, 268.86),
    c(300.05, 268.86),
    c(300.05, 145.9),
    c(114.6, 145.9)
  )),
  sf::st_linestring(x = rbind(
    c(199.43, 197.19),
    c(199.43, 335.58),
    c(229.13, 335.58),
    c(229.13, 145.98)
  )),
  sf::st_linestring(x = rbind(
    c(176.69, 1),
    c(176.69, 268.86)
  )),
  sf::st_linestring(x = rbind(
    c(114.6, 197.2),
    c(380, 197.2)
  )),
  sf::st_linestring(x = rbind(
    c(229.13, 145.9),
    c(176.69, 82.12)
  )),
  sf::st_linestring(x = rbind(
    c(229.13, 335.58),
    c(229.13, 380)
  )),
  sf::st_linestring(x = rbind(
    c(114.6, 268.6),
    c(0.86, 357.6)
  ))
) %>%
  sf::st_as_sf()

cities <- sf::st_sfc(
  sf::st_point(c(185, 215)),
  sf::st_point(c(258, 210)),
  sf::st_point(c(330, 195)),
  sf::st_point(c(200, 345)),
  sf::st_point(c(120, 275)),
  sf::st_point(c(110, 225)),
  sf::st_point(c(110, 140)),
  sf::st_point(c(176.69, 110)),
  sf::st_point(c(225, 135))
) %>%
  sf::st_as_sf() %>%
  mutate(city = c(
    "Minneapolis",
    "St. Paul",
    "Woodbury",
    "Forest Lake",
    "Maple Grove",
    "Plymouth",
    "Eden Prairie",
    "Burnsville",
    "Eagan"
  )) %>%
  sf::st_intersection(tma_area_abstract)

usethis::use_data(cities, overwrite = TRUE)
usethis::use_data(roads, overwrite = TRUE)


ggplot() +
  geom_sf(
    data = tma_area_abstract,
    aes(fill = market_area),
    color = NA
  ) +
  geom_sf(
    data = roads,
    color = "darkgray",
    lwd = 1
  ) +
  geom_sf_text(
    data = cities,
    aes(label = stringr::str_wrap(city, 10)),
    color = "white",
    lineheight = 0.8,
    family = "Arial Narrow",
    size = font_sizes$font_size_base
  ) +
  coord_sf(
    xlim = c(12, 360),
    ylim = c(15, 360),
    expand = F
  ) +
  scale_fill_manual(values = c(
    "#0054A4",
    "#0069cc",
    "#0084ff",
    "#339cff",
    "#b3daff"
  )) +
  theme_void() +
  theme(legend.position = "bottom")
