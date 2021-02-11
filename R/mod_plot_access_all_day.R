#' plot_access_all_day UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_access_all_day_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotlyOutput(ns("new_all_day"))

  )
}

#' plot_access_all_day Server Function
#'
#' @noRd
mod_plot_access_all_day_server <- function(
  input,
  output,
  session,
  slider_input = slider_input){

  ns <- session$ns

  output$new_all_day <- renderPlotly({


  })

}

## To be copied in the UI
# mod_plot_access_all_day_ui("plot_access_all_day_ui_1")

## To be copied in the server
# callModule(mod_plot_access_all_day_server, "plot_access_all_day_ui_1")

