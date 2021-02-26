#' @title Custom ggplot2 theme
#'
#' @return a ggplot2 theme object
#' @export
#'
#' @import ggplot2
#' @import councilR
#'
app_theme <- function(
  font_sizes_ = font_sizes,
  font_families_ = font_families,
  size_margin_ = size_margin) {

  base_size <- font_sizes_$font_size_base
  base_line_size <- base_size / 22
  base_rect_size <- base_size / 22

  half_line <- base_size / 2

  ggplot2::theme(
    line = element_blank(),
    rect = element_blank(),
    text = element_text(
      family = font_families_$font_family_base,
      face = "plain",
      colour = councilR::colors$suppBlack,
      size = font_sizes_$font_size_base,
      lineheight = 0.9,
      hjust = 0.5,
      vjust = 0.5,
      angle = 0,
      margin = margin(),
      debug = FALSE
    ),
    axis.text = element_blank(),
    axis.title = element_blank(),
    axis.ticks.length = unit(0, "pt"),
    axis.ticks.length.x = NULL,
    axis.ticks.length.x.top = NULL,
    axis.ticks.length.x.bottom = NULL,
    axis.ticks.length.y = NULL,
    axis.ticks.length.y.left = NULL,
    axis.ticks.length.y.right = NULL,
    legend.box = NULL,
    legend.key.size = unit(1.2, "lines"),
    legend.position = "right",
    legend.text = element_text(
      size = font_sizes_$font_size_legend_text,
      family = font_families_$font_family_title
    ),
    legend.title = element_text(
      family = font_families_$font_family_title,
      size = font_sizes_$font_size_legend_title,
      hjust = 0
    ),
    strip.text = element_text(
      size = font_sizes_$font_size_strip_title,
      family = font_families$font_family_title
    ),
    strip.switch.pad.grid = unit(
      half_line / 2,
      "pt"
    ),
    strip.switch.pad.wrap = unit(
      half_line / 2,
      "pt"
    ),
    panel.ontop = FALSE,
    panel.spacing = unit(
      half_line,
      "pt"
    ),
    plot.margin = ggplot2::margin(size_margin_, size_margin_, size_margin_, size_margin_, "pt"),
    plot.title = element_text(
      size = font_sizes_$font_size_plot_title,
      family = font_families_$font_family_title,
      margin = margin(t = half_line)
    ),
    plot.title.position = "plot",
    plot.subtitle = element_text(hjust = 0, vjust = 1, margin = margin(t = half_line)),
    plot.caption = element_text(
      size = font_sizes_$font_size_caption,
      hjust = 1,
      vjust = 1,
      margin = margin(t = half_line)
    ),
    plot.caption.position = "panel",
    plot.tag = element_text(
      size = rel(1.2),
      hjust = 0.5,
      vjust = 0.5
    ),
    plot.tag.position = "topleft",
    complete = TRUE
  )
}
