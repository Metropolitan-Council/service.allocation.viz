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
      inputId = ns("mySliderText"),
      label = "Your choice:",
      grid = TRUE,
      force_edges = TRUE,
      choices = c(
        "Strongly disagree",
        "Disagree", "Neither agree nor disagree",
        "Agree", "Strongly agree"
      )
    )
  )
}

#' slider Server Function
#'
#' @noRd
mod_slider_server <- function(input, output, session) {
  ns <- session$ns
}

## To be copied in the UI
# mod_slider_ui("slider_ui_1")

## To be copied in the server
# callModule(mod_slider_server, "slider_ui_1")
