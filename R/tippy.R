#' @name Custom tippy widget functions
#' @param x
#' @param elementId
#' @noRd
#'
#'
.as_widget <- function (x, elementId = NULL)
{
  htmlwidgets::createWidget(name = "service.allocation.viz",
                            x,
                            width = 0,
                            height = 0,
                            package = "service.allocation.viz", elementId = elementId)
}
#'
#' @inheritParams tippy::tippy
#'
#' @return a tippy
#' @export
#' @importFrom tippy tippy
#'
my_tippy <- function(
  tooltip,
  text
) {
  tippy::tippy(
    tooltip = tooltip,
    text = text,
    placement = "right-end",
    interactive = "true",
    allowHTML = "true"
  )
}


#'
#'
#' @inheritParams tippy::with_tippy
#'
#' @importFrom tippy with_tippy
#' @importFrom htmltools tagList
#' @importFrom shiny tagAppendAttributes
#'
with_my_tippy <- function(
  element,
  tooltip,
  ...
) {
  if (missing(tooltip)) {
    stop("must pass tooltip.", call. = FALSE)
  }
  if (missing(element)) {
    stop("must pass element.", call. = FALSE)
  }
  x <- list(
    element = element$attribs$id,
    opts = list(...)
  )
  htmltools::tagList(
    shiny::tagAppendAttributes(element, `data-tippy` = tooltip),
    .as_widget(x)
  )
}
