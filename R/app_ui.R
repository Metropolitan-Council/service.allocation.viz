#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom gotop use_gotop
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    gotop::use_gotop(color = councilR::colors$councilBlue),
    # List the first level UI elements here
    br(),
    br(),
    fluidPage(
      # HTML('<center>'),
      h1("Bus Network Service Allocation Study"),
      p("Welcome to the Metropolitan Council’s scenario analysis tool for the Regional Transit Service Allocation Study. This tool will allow you to explore how different strategies for expanding transit service in the Twin Cities would impact the region."),
      p("As you explore this tool, keep in mind that resources for transit expansion have always been limited. That’s why we need to consider how investments might result in different, and sometimes competing, values for how transit serves people in the region. Expanding the transit network has to consider varying values inherent in transit planning. Do we plan for future investments that:"),
      tags$ul(strong("Expand geographic access"), "(e.g. coverage) to transit with more basic levels of service; or"),
      tags$ul(strong("Create more frequent service"), "so people can plan more of their daily travel needs?"),
      p("With limited resources, it’s difficult to plan for both. So how do you weigh this problem? We’ve created a tool that shows the study’s analysis of the outcomes of hypothetical transit expansion scenarios."),
      br(),
      h3("Assessing competing values"),
      p(
        "To help us understand the results of different ways the region could invest transit expansion resources, we developed scenarios that represent a range of possible investment strategies. Strategies range from the ",
        strong("Coverage Concept"),
        " which increases access to transit by maximizing geographic coverage, to the ",
        strong("Convenience Concept"),
        " which capitalizes on a network of more frequent service so those who use transit most can meet more of their daily travel needs. The scenarios in the middle are a mix of the hypothetical improvements included in these concepts."
      ),
      mod_plot_scenario_spectrum_ui("plot_scenario_spectrum_ui_1"),
      br(),
      p(
        "To get more information on key terms, hover your cursor over ",
        my_tippy(
          text = " underlined text ",
          tooltip = "Here is some context!"
        ),
        " or ",
        my_tippy(
          text = icon(name = "question-circle"),
          tooltip = "Here is more context!"
        )
        # tippy::with_tippy(
        #   element = icon(name = "question-circle"),
        #   tooltip = "Here is more context!",
        #   placement = "right-end",
        #   interactive = "true",
        #   allowHTML = "true"
        # )
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
