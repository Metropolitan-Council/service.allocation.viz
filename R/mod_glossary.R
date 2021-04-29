#' glossary UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_glossary_ui <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(ns("glossary_modal"),
                 label = "Glossary"),

  )
}

#' glossary Server Function
#'
#' @noRd
mod_glossary_server <- function(input, output, session){
  ns <- session$ns

  observeEvent(input$glossary_modal, {
    showModal(modalDialog(
      title = "Glossary",
      includeMarkdown("inst/app/www/glossary.md"),
      easyClose = TRUE
    ))
  })
}

## To be copied in the UI
# mod_glossary_ui("glossary_ui_1")

## To be copied in the server
# callModule(mod_glossary_server, "glossary_ui_1")

