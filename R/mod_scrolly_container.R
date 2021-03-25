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
          id = "0_summaries",
          h3("Choose your scenario and scroll down for more")
        ),
        # Proposed network table -----------------------------------------------
        scrollytell::scrolly_section(
          id = "01_proposed_network_changes",
          wellPanel(
            h3("Proposed network"),
            p("The following changes to the network are proposed for the selected scenario.")
          ),
          HTML("<center>"),
          mod_table_network_improvements_ui("table_ui_1"),
          HTML("</center>")
        ),
        br(),
        br(),
        scrollytell::scrolly_section(
          id = "02_new_all_day",
          wellPanel(
            h3("How many more people would have access to all-day transit service?"),
            p(
              "Each scenario provides an opportunity to extend all-day, ",
              my_tippy(
                text = " local transit ",
                tooltip = tooltip_text$local
              ),
              "service to people and jobs that currently do not have access to the all-day,",
              my_tippy(
                " local transit",
                tooltip = tooltip_text$local
              ),
              " network. Your selected scenario would expand access to the all-day transit network to the following number of people and jobs. For your reference 1.6 million people and 1.2 million jobs had access to the all-day,",
              my_tippy(
                " local transit ",
                tooltip = tooltip_text$local
              ),
              "network in early 2020 (pre-COVID 19)."
            )
          ),
          HTML("<center>"),
          mod_plot_new_access_ui("plot_new_access_ui_1"),
          br(),
          br(),
          fluidRow(
            column(
              width = 6,
              tippy::with_tippy(
                h4(
                  "People",
                  icon(name = "question-circle"),
                  class = "my-plot-title"
                ),
                tooltip = tooltip_text$people,
                placement = "right-end",
                interactive = "true",
                allowHTML = "true"
              ),
              mod_plot_people_jobs_detail_ui("plot_people_expand_detail_ui_1")
            ),
            column(
              width = 6,
              tippy::with_tippy(
                h4(
                  "Jobs",
                  icon(name = "question-circle"),
                  class = "my-plot-title"
                ),
                tooltip = tooltip_text$jobs
              ),
              mod_plot_people_jobs_detail_ui("plot_jobs_expand_detail_ui_1")
            )
          ),
          HTML("</center>")
        ),
        scrollytell::scrolly_section(
          id = "03_any_improvement",
          wellPanel(
            h3("How many people would see improved transit service of any kind?"),
            p("Each scenario would improve the level of transit service in the region by improving the frequency of transit service available. Your selected scenario would improve the level of transit service for the following number of people and jobs.  The tool shows which percent of the region’s 3,013,000 people and 1,763,000 jobs would see improvements in service.")
          ),
          HTML("<center>"),
          mod_plot_improve_service_ui("plot_improve_service_ui_1"),
          br(),
          fluidRow(
            column(
              width = 6,
              tippy::with_tippy(
                h4(
                  "People",
                  icon(name = "question-circle"),
                  class = "my-plot-title"
                ),
                tooltip = tooltip_text$people,
                placement = "right-end",
                interactive = "true",
                allowHTML = "true"
              ),
              mod_plot_people_jobs_detail_ui("plot_people_improve_detail_ui_1")
            ),
            column(
              width = 6,
              tippy::with_tippy(
                h4(
                  "Jobs",
                  icon(name = "question-circle"),
                  class = "my-plot-title"
                ),
                tooltip = tooltip_text$jobs,
                placement = "right-end",
                interactive = "true",
                allowHTML = "true"
              ),
              mod_plot_people_jobs_detail_ui("plot_jobs_improve_detail_ui_1")
            )
          ),
          HTML("</center>")
        ),
        scrollytell::scrolly_section(
          id = "04_service_type_changes",
          wellPanel(
            h3("What types of transit service would be improved and for how many people?"),
            p(
              "In order to have a full understanding how your selected scenario is going to impact the region, it is important to understand how transit service is going to be improved at the various service thresholds described earlier. The chart below shows how many more people would have new access to",
              my_tippy(
                " high-frequency ",
                tooltip = tooltip_text$high_frequency
              ),
              " and ",
              my_tippy(
                "local transit service",
                tooltip = tooltip_text$local
              ),
              ". For your reference, 645,000 people had access to high frequency services and 610,000 people had access to local bus service."
            )
          ),
          HTML("<center>"),
          mod_plot_service_type_ui("plot_service_type_ui_1"),
          HTML("</center>"),
          br(),
          h4("What market areas will be served by these improvements?"),
          p(
            "The region is divided into five distinct",
            my_tippy(
              "Transit Market Areas (TMAs).",
              tooltip = tooltip_text$tma_defs
            ),
            " TMAs are a tool used to guide transit planning decisions. TMAs are determined by a combination of measures, including population and employment density, automobile availability, and intersection density. You can read more about TMAs in",
            a(
              "Appendix G of the Transportation Policy Plan.",
              icon(name = "external-link-alt"),
              href = "https://metrocouncil.org/Transportation/Publications-And-Resources/Planning/2040-TRANSPORTATION-POLICY-PLAN-(2020-version)/Appendices/Appendix-G.aspx",
              target = "_blank"
            ),
            .noWS = "inside"
          ),
          br(),
          HTML("<center>"),
          mod_plot_tma_service_type_ui("plot_tma_service_type_ui_1"),
          # mod_plot_tma_abstract_ui("plot_tma_abstract_ui_1"),
          HTML("</center>")
        ),
        scrollytell::scrolly_section(
          id = "05_job_access",
          wellPanel(
            h3("How many more jobs will the average resident be able to reach when considering the entire transit network?"),
            p("Investments in transit improvements make the system easier to use by providing better access to places people want to go. One of the primary places people want to go is their job. The chart below shows how your scenario will improve job accessibility for the average regional resident in the region; the figures are provided by how many jobs are accessible within a given time spent (e.g. 15 minutes, 30 minutes) traveling on the transit network. This measure provides a better assessment of how the scenarios would impact people’s ability to access jobs than previous measures because it considers where the routes go relative to people, not just whether they are nearby or not. ")
          ),
          HTML("<center>"),
          mod_plot_job_access_ui("plot_job_access_ui_1"),
          HTML("</center>")
        ),
        scrollytell::scrolly_section(
          id = "06_ridership_increase",
          wellPanel(
            h3("How many more people would use the transit system?"),
            p("Measuring transit riders is a fundamental aspect of assessing a transit system’s impact. If the system is useful to people, more will likely ride it. While it is impossible to assess ridership potential perfectly, since many factors influence people’s choices, the following is an estimate of how each scenario’s improvements would impact regional transit ridership.")
          ),
          HTML("<center>"),
          # mod_plot_job_access_ui("plot_job_access_ui_1"),
          HTML("</center>")
        ),
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
