#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    br(),
    br(),
    fluidPage(
      # HTML('<center>'),
      h1("Bus Network Service Allocation Study"),
      p("Welcome to the Metropolitan Council’s Scenario Analysis Tool for the Regional Transit Service Allocation Study. This tool will allow you to explore how different service allocation strategies for expanding transit service in the Twin Cities would impact the region."),
      p("As you explore this tool, keep in mind that resources for transit have always been limited, creating a need to consider how investments might achieve different and sometimes competing values for transit’s role for people in the region. Expanding the transit network has to consider the different values inherent in transit planning; Do we plan for future investments that expand geographic access (e.g. coverage) to the transit network with a basic level of service; or Do we plan for future investments  that will create a network of frequent service people can plan all their daily travel needs around?. It is difficult to plan for both adequately with limited resources, so how do you assess this problem? We’ve created a tool with analysis to help demonstrate to you the outcomes associated with hypothetical transit expansion scenarios."),
      br(),
      h3("How did we look at the problem of competing transit system investment values for this study?"),
      p(
        "To help us understand the outcomes of different ways of investing transit expansion resources, we developed scenarios that represent a spectrum of possible strategies for distributing transit investments across the region. The spectrum represents strategies ranging from a",
        strong("Coverage Concept"),
        " maximizing geographic access to transit on one end to a",
        strong(" Convenient Transit Concept"),
        " maximizing a network of frequent service people can plan all their daily travel needs around on the other end. The intermediate scenarios are a mix of the hypothetical improvements included in these concepts. "
      ),
      mod_plot_scenario_spectrum_ui("plot_scenario_spectrum_ui_1"),
      br(),
      br(),
      h2("Important Definitions"),
      h3("Route types"),
      tags$ul(HTML(tooltip_text$high_frequency)),
      tags$ul(HTML(tooltip_text$local)),
      tags$ul(HTML(tooltip_text$basic)),
      tags$ul(HTML(tooltip_text$commuter)),
      br(),
      h3("People"),
      tags$ul(HTML(tooltip_text$affordable_housing)),
      tags$ul(HTML(tooltip_text$bipoc)),
      tags$ul(HTML(tooltip_text$low_income)),
      tags$ul(HTML(tooltip_text$elderly)),
      p(
        "To get more information on key terms, hover your cursor over ",
        my_tippy(
          text = " underlined text ",
          tooltip = "Here is some context!"
        ),
        " or ",
        tippy::with_tippy(
          element = icon(name = "question-circle"),
          tooltip = "Here is more context!",
          placement = "right-end",
          interactive = "true",
          allowHTML = "true"
        )
      ),
      br(),
      mod_scrolly_container_ui("scrolly_container_ui_1"),
      # HTML('</center>'),
      br(),
      br(),
      br(),
      br(),
      h2("What do you think?"),
      p("Which scenario best captures the strategy that you feel the region should engage when investing in expanding the transit system? Please let us know by completing the following survey: surveymonkey link"),
      tags$footer(
        #----
        tags$a(
          href = "https://metrocouncil.org",
          target = "_blank",
          img(src = "www/main-logo.png", align = "right", style = "padding: 1%")
        )
        # tags$div(
        #   tags$a(href="https://github.com/Metropolitan-Council/loop-sensor-trends", target="_blank",
        #          icon(name = "github", lib = "font-awesome"))
        # )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  suppressDependencies()

  tags$head(
    # favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Service Allocation Study"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
