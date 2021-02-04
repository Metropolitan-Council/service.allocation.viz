#' plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("pl"))
  )
}

#' plot Server Function
#'
#' @noRd
mod_plot_server <- function(input, output, session, scroll_section) {
  ns <- session$ns

  output$pl <- plotly::renderPlotly({
    # browser()
    if (scroll_section$scr_section == 1) {
      shinipsum::random_ggplotly(type = "boxplot")
    } else if (scroll_section$scr_section == 2) {
      shinipsum::random_ggplotly(type = "hex")
    } else if (scroll_section$scr_section == 3) {
      shinipsum::random_ggplotly(type = "tile")
    } else if (scroll_section$scr_section == 4) {
      shinipsum::random_ggplotly(type = "tile")
    }
  })
}

## To be copied in the UI
# mod_plot_ui("plot_ui_1")

## To be copied in the server
# callModule(mod_plot_server, "plot_ui_1")
