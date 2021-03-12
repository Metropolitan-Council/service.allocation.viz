#' @name Custom tippy widget
#'
#'
#' @inheritParams tippy::tippy
#'
#' @return a tippy
#' @export
#' @importFrom tippy tippy
#'
my_tippy <- function(tooltip,
                     text){

  tippy::tippy(tooltip = tooltip,
               text = text,
               placement = "right-end",
               interactive = "true",
               allowHTML = "true")
}
