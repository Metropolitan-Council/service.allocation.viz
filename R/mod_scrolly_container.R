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
      h2("Scenario Summaries"),
      scrollytell::scrolly_sections(
        scrollytell::scrolly_section(
          id = 00,
          h3("Choose your scenario and scroll down for more")
        ),
        scrollytell::scrolly_section(
          id = 0.5,
          wellPanel(
            h3("How many more people would have access to all-day transit service?"),
            p("Each scenario provides an opportunity to extend all-day, local transit service to people and jobs that currently do not have access to the all-day, local transit network. Your selected scenario would expand access to the all-day transit network to the following number of people and jobs. For your reference 1.6 million people and 1.2 million jobs had access to the all-day, local transit network in early 2020 (pre-COVID 19).")
          ),
          HTML("<center>"),
          mod_plot_new_access_ui("plot_new_access_ui_1"),
          HTML("</center>")
        ),
        scrollytell::scrolly_section(
          id = 0.8,
          wellPanel(
            h3("How many people would see improved transit service of any kind?"),
            p("Each scenario provides an opportunity to extend all-day, local transit service to people and jobs that currently do not have access to the all-day, local transit network. Your selected scenario would expand access to the all-day transit network to the following number of people and jobs. For your reference 1.6 million people and 1.2 million jobs had access to the all-day, local transit network in early 2020 (pre-COVID 19).")
          ),
          HTML("<center>"),
          mod_plot_improve_service_ui("plot_improve_service_ui_1"),
          HTML("</center>")
        ),

        scrollytell::scrolly_section(
          id = 0.9,
          wellPanel(
            h3("What types of transit service would be improved and for how many people?"),
            p("In order to have a full understanding how your selected scenario is going to impact the region, it is important to understand how transit service is going to be improved at the various service thresholds described earlier. The chart below shows how many more people would have new access to high-frequency and local transit service. High-frequency is a service you can use for most or all of your daily needs while local is a service that you can rely on but generally need to plan ahead to use. For your reference, 645,000 people had access to high frequency services and 610,000 people had access to local bus service.")
          ),
          HTML("<center>"),
          # mod_plot_improve_service_ui("plot_improve_service_ui_1"),
          HTML("</center>")
        ),


        # Proposed network table -----------------------------------------------
        scrollytell::scrolly_section(
          id = 0,
          wellPanel(
            h3("Proposed network"),
            p("The following changes to the network are proposed for the selected scenario.")
          ),
          HTML("<center>"),
          mod_table_ui("table_ui_1"),
          HTML("</center>")
        ),
        br(),

        scrollytell::scrolly_section(
          id = "job_access",
          wellPanel(
            h3("How many more jobs will the average resident be able to reach when considering the entire transit network?"),
            p("Investments in transit improvements make the system easier to use by providing better access to places people want to go. One of the primary places people want to go is their job. The chart below shows how your scenario will improve job accessibility for the average regional resident in the region; the figures are provided by how many jobs are accessible within a given time spent (e.g. 15 minutes, 30 minutes) traveling on the transit network. This measure provides a better assessment of how the scenarios would impact people’s ability to access jobs than previous measures because it considers where the routes go relative to people, not just whether they are nearby or not. ")
          ),
          HTML("<center>"),
          mod_plot_job_access_ui("plot_job_access_ui_1"),
          HTML("</center>")
        ),
        br(),


        # Scenario summary -----------------------------------------------------
        scrollytell::scrolly_section(
          id = 1,
          wellPanel(
            h3("Detailed Scenario Summary"),
            p("Each option on the slider bar presents an alternative strategy for allocating resources to expand the transit network. Scenario I prioritizes investments into transit services that are able to serve a wide variety of trips, these improvements are primarily in areas with the highest transit demand, Transit Market Areas 1 and 2; scenario II prioritizes investments in transit services that maximize the number of people in the region that have access to transit service. Along the spectrum are intermediate scenarios that combine the two strategies in different ratios.")
          ),
          HTML("<center>"),
          fluidRow(
            column(
              width = 6,
              mod_plot_scenario_summary_ui("plot_scenario_summary_ui_expand")
            ),
            column(
              width = 6,
              mod_plot_scenario_summary_ui("plot_scenario_summary_ui_improve")
            )
          ),
          br(),
          fluidRow(
            mod_plot_scenario_tma_ui("plot_scenario_tma_ui_1")
          ),
          HTML("</center>")
        ),
        # br(),
        br(),
        scrollytell::scrolly_section(
          id = 2,
          wellPanel(
            h3("New Access to All Day Transit"),
            p("Each scenario would also improve the level of transit service in the region by improving the frequency of transit service available. The selected scenario would increase the frequency of transit service accessible to the following people and jobs.")
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
            p("Each scenario would also improve the level of transit service in the region by improving the frequency of transit service available. The selected scenario would increase the frequency of transit service accessible to the following people and jobs.")
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
            p("The following provides greater detail as to how each scenario benefits the region. The chart on the left describes which level of transit service the scenario provides and the chart on the right shows how where in the region transit service is improved")
          ),
          HTML("<center>"),
          fluidRow(
            column(
              width = 6,
              mod_plot_service_type_ui("plot_service_type_ui_1")
            ),
            column(
              width = 6,
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
            p("At the high level the selected scenario would have the following impacts on system level ridership and on regional job accessibility.")
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
        scrollytell::scrolly_section(
          id = 5,
          wellPanel(
            h3("What do you think?"),
            p("Which scenario best captures the strategy that you feel the region should engage when investing in expanding the transit system? Please let us know by completing the following survey: surveymonkey link")
          )
        ),
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
