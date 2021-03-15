library(XML)
library(sf)
library(dplyr)

tma_abstract <- XML::htmlParse("lit/graphics/abstract_tma.svg")

tma_abstract
p <- xpathSApply(tma_abstract, "//polygon", xmlGetAttr, "points")

p2 <- lapply( strsplit(p, " "), function(u) {
  # browser()
  mat <-matrix(
    as.numeric(
      unlist(strsplit(u, ","))),
    ncol=2,
    byrow=TRUE)

  mat[is.na(mat)] <- 0

  mat[nrow(mat),] <- mat[1,]

  return(mat)
} )



tma_areas <- st_sfc(list(st_polygon(p2[1]),
                         st_polygon(p2[2]),
                         st_polygon(p2[3]),
                         st_polygon(p2[4]))) %>%
  st_as_sf() %>%
  mutate(tma_area = c(4,3,2,1))

plot(tma_areas)

bo <- st_bbox(tma_areas)

bo[1] <- st_bbox(tma_areas)[1] - 20
bo[2] <- st_bbox(tma_areas)[2] - 10
bo[3] <- st_bbox(tma_areas)[3] + 40
bo[4] <- st_bbox(tma_areas)[4] + 10


tma5 <-st_as_sfc(bo) %>%
  st_as_sf() %>%
  mutate(tma_area = 5) %>%
  st_difference(tma_areas$x[4]) %>%
  st_difference(tma_areas$x[3]) %>%
  st_difference(tma_areas$x[2]) %>%
  st_difference(tma_areas$x[1])

plot(tma5)


tma_area_abstract <- rbind(tma_areas, tma5)
plot(tma_area_abstract)

usethis::use_data(tma_area_abstract, overwrite = T)
