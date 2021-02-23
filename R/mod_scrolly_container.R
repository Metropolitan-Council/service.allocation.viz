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
            tags$body("Each option on the slider bar presents an alternative strategy for allocating resources to expand the transit network. Scenario I prioritizes investments into transit services that are able to serve a wide variety of trips, these improvements are primarily in areas with the highest transit demand, Transit Market Areas 1 and 2; scenario II prioritizes investments in transit services that maximize the number of people in the region that have access to transit service. Along the spectrum are intermediate scenarios that combine the two strategies in different ratios.")
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
            tags$body("The following changes to the network are proposed for the selected scenario.")
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
            tags$body("Each scenario would also improve the level of transit service in the region by improving the frequency of transit service available. The selected scenario would increase the frequency of transit service accessible to the following people and jobs.")          ),
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
            tags$body("Each scenario would also improve the level of transit service in the region by improving the frequency of transit service available. The selected scenario would increase the frequency of transit service accessible to the following people and jobs.")
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
            tags$body("The following provides greater detail as to how each scenario benefits the region. The chart on the left describes which level of transit service the scenario provides and the chart on the right shows how where in the region transit service is improved")),

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
            tags$body("At the high level the selected scenario would have the following impacts on system level ridership and on regional job accessibility.")),

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
        scrollytell::scrolly_section(
          id = 5,
          wellPanel(
            h3("What do you think?"),
            tags$body("Which scenario best captures the strategy that you feel the region should engage when investing in expanding the transit system? Please let us know by completing the following survey: surveymonkey link")
          )
        ),


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
