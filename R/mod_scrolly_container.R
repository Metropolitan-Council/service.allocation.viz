#' scrolly_container UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_scrolly_container_ui <- function(id) {
  ns <- NS(id)
  tagList(
    scrollytell::scrolly_container(
      outputId = ns("scr"),

      scrollytell::scrolly_graph(
        textOutput(ns("section")),
        mod_slider_ui("slider_ui_1"),
        mod_plot_ui("plot_ui_1"),
        br(),
        br(),
        br(),


      ),

      scrollytell::scrolly_sections(
        # HTML('<center>'),
        scrollytell::scrolly_section(id = 0, HTML(shinipsum::random_text(nwords = 20)),
                                     mod_plot_ui("plot_ui_2")
        ),
        br(),
        br(),

        scrollytell::scrolly_section(id = 1, HTML(shinipsum::random_text(nwords = 40))),
        br(),
        br(),

        scrollytell::scrolly_section(id = 2, HTML(shinipsum::random_text(nwords = 60))),
        br(),
        br(),

        scrollytell::scrolly_section(id = 3, HTML(shinipsum::random_text(nwords = 80))),
        br(),
        br()

        # scrollytell::scrolly_section(id = 4, render_text(4)),
        # scrollytell::scrolly_section(id = 5, render_text(5)),
        # HTML('</center>')
      )
    )
  )
}

#' scrolly_container Server Function
#'
#' @noRd
mod_scrolly_container_server <- function(input, output, session) {
  ns <- session$ns

  # browser()

  output$scr <- scrollytell::renderScrollytell({
    scrollytell::scrollytell()
  })

  renderText(paste0("Section: ", input$scr))

  observe({
    cat("section:", input$scr, "\n")
  })

  vals <- reactiveValues()

  observe({
    vals$scr_section <- input$scr
  })

  return(vals)
}

## To be copied in the UI
# mod_scrolly_container_ui("scrolly_container_ui_1")

## To be copied in the server
# callModule(mod_scrolly_container_server, "scrolly_container_ui_1")
