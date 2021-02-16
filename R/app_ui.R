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
    fluidPage(
      # HTML('<center>'),
      h1("service.allocation.viz"),
      h2("Here is what you can expect from this viz"),
      tags$body(shinipsum::random_text(nwords = 200)),
      br(),
      br(),
      br(),
      mod_scrolly_container_ui("scrolly_container_ui_1"),
      # HTML('</center>'),

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
