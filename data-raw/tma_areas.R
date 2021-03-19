library(XML)
library(sf)
library(dplyr)

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
    )
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
    )
  )


ggplot() +
  geom_sf(
    data = tma_detailed,
    aes(fill = market_area)
  )
