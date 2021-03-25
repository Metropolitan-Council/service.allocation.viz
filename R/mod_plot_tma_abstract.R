#' plot_tma_abstract UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_tma_abstract_ui <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("tma_abstract"))
  )
}

#' plot_tma_abstract Server Function
#'
#' @noRd
mod_plot_tma_abstract_server <- function(
  input,
  output,
  session,
  data_for_plotting = data_for_plotting
) {
  ns <- session$ns

  output$tma_abstract <- renderPlot({
    ggplot() +
      geom_sf(
        data = tma_area_abstract,
        aes(fill = market_area),
        color = NA,
        show.legend = F
      ) +
      geom_sf(
        data = roads,
        color = "darkgray",
        lwd = 0.8
      ) +
      geom_label(
        # data = tma_area_abstract,
        aes(
          x = c(
            220,
            220 + (31.5 * 1),
            220 + (31.5 * 2),
            220 + (31.5 * 3),
            220 + (31.5 * 4)
          ),
          y = c(
            200,
            200 - (25 * 1),
            200 - (25 * 2),
            200 - (25 * 3),
            200 - (25 * 4)
          ),
          label = tma_area_abstract$market_area
        ),
        color = "black",
        fill = "white",
        size = 5

        # data = cities,
        #            aes(label = stringr::str_wrap(city,10)),
        #            color = "white",
        #            lineheight = 0.8,
        #            family = "Arial Narrow",
        #            size = 5
      ) +
      coord_sf(
        # xlim = c(20, 360),
        # ylim = c(15, 360),
        expand = F
      ) +
      scale_fill_manual(values = c(
        "#0054A4",
        "#0069cc",
        "#0084ff",
        "#339cff",
        "#b3daff"
      )) +
      labs(fill = "") +
      app_theme() +
      theme(legend.position = "bottom")
  })
}

## To be copied in the UI
# mod_plot_tma_abstract_ui("plot_tma_abstract_ui_1")

## To be copied in the server
# callModule(mod_plot_tma_abstract_server, "plot_tma_abstract_ui_1")
