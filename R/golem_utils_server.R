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
sysfonts::font_add("HelveticaNeueLT Std Cn", "HelveticaNeueLTStd-Cn.otf")
sysfonts::font_add("HelveticaNeueLT Std Lt", "HelveticaNeueLTStd-Lt.otf")
sysfonts::font_add("HelveticaNeueLT Std Med Cn", "HelveticaNeueLTStd-MdCn.otf")
sysfonts::font_add("Arial Narrow", "ARIALN.TTF")
sysfonts::font_add("Palatino Linotype", "pala.ttf")
sysfonts::font_add("Arial", "arial.ttf")


font_sizes <- list(
  font_size_base = 12,
  font_size_plot_title = 22,
  font_size_axis_title = 14,
  font_size_legend_title = 14,
  font_size_strip_title = 16,
  font_size_axis_text = 11,
  font_size_legend_text = 10,
  font_size_caption = 8,
  font_size_margin = 10
)

font_families <- list(
  font_family_base = "Arial",
  font_family_title = "HelveticaNeueLT Std Lt",
  font_family_caption = "Palatino Linotype",
  font_family_subtitle = "Helvetica",
  font_family_strip = "Arial Narrow"
)

size_margin <- 10

font_family_list <- "Roman, Helvetica, Tahoma, Geneva, Arial, sans-serif"

axis_options <- list(
  zeroline = FALSE,
  showline = FALSE,
  showgrid = FALSE,
  visible = FALSE
)
