#' slider UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyWidgets sliderTextInput
mod_slider_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinyWidgets::sliderTextInput(
      inputId = ns("slider"),
      label = "Scenario",
      grid = TRUE,
      force_edges = TRUE,
      choices = c(
        "1",
        "A",
        "B",
        "C",
        "D",
        "E",
        "2"
      ),
    )
  )
}

#' slider Server Function
#'
#' @noRd
mod_slider_server <- function(input, output, session) {
  ns <- session$ns

  vals <- reactiveValues()

  observeEvent(input$slider, {
    vals$slider <- input$slider
  })

  selected_scenario_def <- reactive({
    scenario_def_long[scenario_id == slider_input$slider, ]
  })

  return(vals)
}

## To be copied in the UI
# mod_slider_ui("slider_ui_1")

## To be copied in the server
# callModule(mod_slider_server, "slider_ui_1")
