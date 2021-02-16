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
        HTML("<center>"),
        textOutput(ns("section")),
        mod_slider_ui("slider_ui_1"),
        # mod_plot_ui("plot_ui_1"),
        # br(),
        # br(),
        # br(),
        HTML("</center>")
      ),
      scrollytell::scrolly_sections(
        scrollytell::scrolly_section(
          id = 00,
          h3("Choose your scenario and scroll down for more")
        ),
        # Scenario summary -----------------------------------------------------
        scrollytell::scrolly_section(
          id = 0,

          wellPanel(
            h3("Scenario Summary"),
            HTML(shinipsum::random_text(nwords = 40))
          ),

          HTML("<center>"),
          fluidRow(
            column(width = 6,
                   mod_plot_scenario_summary_ui("plot_scenario_summary_ui_expand")),
            column(width = 6,
                   mod_plot_scenario_summary_ui("plot_scenario_summary_ui_improve"))),
          br(),
          fluidRow(
            mod_plot_scenario_tma_ui("plot_scenario_tma_ui_1")),
          HTML("</center>")
        ),
        # br(),
        br(),
        # Proposed network table -----------------------------------------------
        scrollytell::scrolly_section(
          id = 1,
          wellPanel(
            h3("Proposed network"),
            tags$body(shinipsum::random_text(nwords = 20))
          ),
          HTML("<center>"),
          mod_table_ui("table_ui_1"),
          HTML("</center>")
        ),
        br(),
        scrollytell::scrolly_section(
          id = 2,
          wellPanel(
            h3("New Access to All Day Transit"),
            HTML(shinipsum::random_text(nwords = 40))
          ),
          HTML("<center>"),
          mod_plot_scenario_summary_ui("plot_scenario_summary_ui_expand_all_day"),
          fluidRow(
            column(width = 6, mod_plot_scenario_detail_ui("mod_plot_scenario_detail_ui_expand_people")),
            column(width = 6, mod_plot_scenario_detail_ui("mod_plot_scenario_detail_ui_expand_jobs"))
          ),
          HTML("</center>")
        ),
        # br(),
        br(),
        scrollytell::scrolly_section(
          id = 3,
          wellPanel(
            h3("New Improved Transit"),
            HTML(shinipsum::random_text(nwords = 80))
          ),

          HTML("<center>"),
          mod_plot_scenario_summary_ui("plot_scenario_summary_ui_improve_all"),
          fluidRow(
            column(width = 6, mod_plot_scenario_detail_ui("mod_plot_scenario_detail_ui_improve_people")),
            column(width = 6, mod_plot_scenario_detail_ui("mod_plot_scenario_detail_ui_improve_jobs"))
          ),
          HTML("</center>")

        ),
        scrollytell::scrolly_section(
          id = 4,
          wellPanel(
            h3("Increase by service type"),
            HTML(shinipsum::random_text(nwords = 80))
          ),

          HTML("<center>"),
          fluidRow(
            column(width = 6,
                   mod_plot_service_type_ui("plot_service_type_ui_1")),

            column(width = 6,
                   mod_plot_scenario_tma_ui("plot_scenario_tma_ui_2"),
            )
          ),
          fluidRow(
            column(width = 4),
            column(width = 8)
          ),

          HTML("</center>")

        ),

        scrollytell::scrolly_section(
          id = 4,
          wellPanel(
            h3("Network Improvements"),
            HTML(shinipsum::random_text(nwords = 80))
          ),

          HTML("<center>"),
          fluidRow(
            column(width = 4),
            column(width = 8)
          ),
          fluidRow(
            column(width = 4),
            column(width = 8)
          ),
          HTML("</center>")
        ),



        # br(),
        br(),
        # scrollytell::scrolly_section(id = 4, render_text(4)),
        # scrollytell::scrolly_section(id = 5, render_text(5)),
        HTML("</center>")
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
