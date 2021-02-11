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



#' Additional global values


ggplot2::theme(
  line = element_blank(),
  rect = element_blank(),
  text = element_text(
    family = base_family,
    face = "plain",
    colour = "black",
    size = base_size,
    lineheight = 0.9,
    hjust = 0.5,
    vjust = 0.5,
    angle = 0,
    margin = margin(),
    debug = FALSE
  ),
  axis.text = element_blank(),
  axis.title = element_blank(),
  axis.ticks.length = unit(0, "pt"),
  axis.ticks.length.x = NULL,
  axis.ticks.length.x.top = NULL,
  axis.ticks.length.x.bottom = NULL,
  axis.ticks.length.y = NULL,
  axis.ticks.length.y.left = NULL,
  axis.ticks.length.y.right = NULL,
  legend.box = NULL,
  legend.key.size = unit(1.2, "lines"),
  legend.position = "right",
  legend.text = element_text(size = rel(0.8)),
  legend.title = element_text(hjust = 0),
  strip.text = element_text(size = rel(0.8)),
  strip.switch.pad.grid = unit(
    half_line / 2,
    "pt"
  ),
  strip.switch.pad.wrap = unit(
    half_line / 2,
    "pt"
  ),
  panel.ontop = FALSE,
  panel.spacing = unit(
    half_line,
    "pt"
  ),
  plot.margin = unit(c(0, 0, 0, 0), "lines"),
  plot.title = element_text(
    size = rel(1.2),
    hjust = 0,
    vjust = 1,
    margin = margin(t = half_line)
  ),
  plot.title.position = "panel",
  plot.subtitle = element_text(hjust = 0, vjust = 1, margin = margin(t = half_line)),
  plot.caption = element_text(
    size = rel(0.8),
    hjust = 1,
    vjust = 1,
    margin = margin(t = half_line)
  ),
  plot.caption.position = "panel",
  plot.tag = element_text(
    size = rel(1.2),
    hjust = 0.5,
    vjust = 0.5
  ),
  plot.tag.position = "topleft",
  complete = TRUE
)
