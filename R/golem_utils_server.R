#' @title App utilities
#' Inverted versions of in, is.null and is.na
#'
#' @noRd
#'
#' @examples
#' 1 %not_in% 1:10
#' not_null(NULL)
`%not_in%` <- Negate(`%in%`)

not_null <- Negate(is.null)

not_na <- Negate(is.na)

#' Removes the null from a vector
#'
#' @noRd
#'
#' @example
#' drop_nulls(list(1, NULL, 2))
drop_nulls <- function(x) {
  x[!sapply(x, is.null)]
}

#' If x is `NULL`, return y, otherwise return x
#'
#' @param x,y Two elements to test, one potentially `NULL`
#'
#' @noRd
#'
#' @examples
#' NULL %||% 1
"%||%" <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

#' If x is `NA`, return y, otherwise return x
#'
#' @param x,y Two elements to test, one potentially `NA`
#'
#' @noRd
#'
#' @examples
#' NA %||% 1
"%|NA|%" <- function(x, y) {
  if (is.na(x)) {
    y
  } else {
    x
  }
}

#' Typing reactiveValues is too long
#'
#' @inheritParams reactiveValues
#' @inheritParams reactiveValuesToList
#'
#' @noRd
rv <- shiny::reactiveValues
rvtl <- shiny::reactiveValuesToList


#' theme elements
#'
#'
#'
#' @importFrom showtext showtext_auto
#' @importFrom sysfonts font_paths font_files font_add

showtext::showtext_auto()
sysfonts::font_paths()
files <- sysfonts::font_files()
sysfonts::font_add("Condensed", "inst/app/www/helveticaneueltstd-cn-webfont.woff")
sysfonts::font_add("Light", "inst/app/www/helveticaneueltstd-lt-webfont.woff")
sysfonts::font_add("Medium-Condensed", "inst/app/www/helveticaneueltstd-mdcn-webfont.woff")
sysfonts::font_add("Arial Narrow", "inst/app/www/ARIALN_0.TTF")
sysfonts::font_add("Palatino Linotype", "inst/app/www/pala.ttf")
sysfonts::font_add("Arial", "inst/app/www/arial.ttf")


font_sizes <- list(
  font_size_base = 14,
  font_size_plot_title = 18,
  font_size_axis_title = 16,
  font_size_legend_title = 16,
  font_size_strip_title = 16,
  font_size_axis_text = 11,
  font_size_legend_text = 11,
  font_size_caption = 9,
  font_size_margin = 10
)

font_families <- list(
  font_family_base = "Arial",
  font_family_title = "Light",
  font_family_caption = "Palatino Linotype",
  font_family_subtitle = "Helvetica",
  font_family_strip = "Arial Narrow",
  font_family_axis_title = "Condensed",
  font_family_axis_text = "Helvetica"
)

size_margin <- 10

font_family_list <- "Roman, Helvetica, Tahoma, Geneva, Arial, sans-serif"

axis_options <- list(
  zeroline = FALSE,
  showline = FALSE,
  showgrid = FALSE,
  visible = FALSE
)


job_color <- "#E2F0D9"
people_color <- "#DAE3F3"


spectrum_colors <- RColorBrewer::brewer.pal(7, "PRGn")


convenient_colors <- c(
  spectrum_colors[[1]],
  "orchid3"
)

coverage_colors <- c(
  spectrum_colors[[7]],
  "darkseagreen3"
)

tooltip_text <- list(
  # transit service levels
  high_frequency = "<strong>High frequency transit service </strong> includes buses or trains that come at least every 15-30 minutes. You can use high frequency service for most or all of your daily needs.",
  local = "<strong>Local transit service </strong> includes buses or trains that come at least every 15-30 minutes. Service is reliable, but you may have to plan ahead to use.",
  basic = "<strong>Basic Service </strong> Buses or trains come at most every 30 minutes",
  commuter = "<strong> Commuter and Express </strong> Buses or trains only operate in the rush hour and serve limited stops",

  # people, jobs definitions
  people = "<strong>Affordable Housing Units</strong> Housing units for households with an income below 30% of the Area Median Income. <br> <strong> BIPOC</strong> Black, Indigenous, and people of color <br> <strong>Elderly</strong> People ages 65 and over <br> <strong>Low-Income</strong> Individuals with an individual or family income below 185% of the federal poverty threshold",

  affordable_housing = "<strong>Affordable Housing Units</strong> Housing units for households with an income below 30% of the Area Median Income. ",
  bipoc = "<strong> BIPOC</strong> Black, Indigenous, and people of color ",
  low_income = "<strong>Low-Income</strong> Individuals with an individual or family income below 185% of the federal poverty threshold",
  elderly = "<strong>Elderly</strong> People ages 65 and over",



  jobs = "<strong>High-Wage jobs</strong> Jobs earning more than $40,000 per year. <br> <strong>Low-Wage jobs </strong> Jobs earning less than $40,000 per year"
)
