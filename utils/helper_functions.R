tracts <- justviz::acs |>
  dplyr::filter(
    level == "tract",
    county %in% c("Frederick County", "Montgomery County", "Carroll County", "Washington County", "Howard County")
  )


# add fonts
# georgia in windows, libre franklin is close enough hopefully
font_add_google("Libre Franklin", "franklin", regular.wt = 400, bold.wt = 600)
font_add("georgia",
         regular    = "georgia.ttf",
         bold       = "georgiab.ttf",
         italic     = "georgiai.ttf",
         bolditalic = "georgiaz.ttf")
showtext_auto()
showtext_opts(dpi = 96)

main_font <- "franklin"
sub_font  <- "georgia"


# styleguide uses px as unit, ggplot uses pt and linewidth. dpi is 100 so a 650px (standard post in stylegiuide) graphic = 6.5in for easy conversions
dpi <- 100
px_pt <- function(px) px * 72 / dpi
# px -> linewidth
px_lw <- function(px) px * (96 / dpi) / .pt
# px -> size for annotate/geom_text (which is in mm)
px_mm <- function(px) px_pt(px) / .pt


# defining larger theme so i dont have to do it within the chart itself
# documentation : https://rpubs.com/mclaire19/ggplot2-custom-themes
sunlight <- function () {
  main_font = "franklin"
  sub_font = "georgia"
  
  theme_minimal() %+replace%
    theme(
      # backgrounds
      plot.background = element_rect(fill = sunlight_pal$bg,
                                     color = sunlight_pal$line_grey,
                                     linewidth = px_lw(1)),
      panel.background = element_rect(fill = sunlight_pal$bg,
                                      color = NA),
      
      # grids
      panel.grid.major = element_line(color = sunlight_pal$line_white,
                                      linewidth = px_lw(1)),
      panel.grid.minor = element_blank(),
      axis.ticks       = element_blank(),
      axis.line        = element_blank(),
      
      # text
      # title/headers
      # title + subtitle in ONE box bc seperately it was beoing weird
      plot.title = element_textbox_simple(family = main_font,
                                          size = px_pt(20),
                                          color = sunlight_pal$text_main,
                                          fill = sunlight_pal$bg_light,
                                          width = unit(1, "npc"),
                                          padding = margin(22, 22, 22, 22),
                                          margin = margin(0, 0, 22, 0)),
      plot.subtitle = element_blank(),
      # caption
      plot.caption = element_textbox_simple(family = sub_font,
                                            size = px_pt(8),
                                            color = sunlight_pal$text_light,
                                            fill = sunlight_pal$bg_dark,
                                            halign = 0,
                                            padding = margin(8, 12, 8, 12),
                                            margin = margin(t = 22)),
      # axes
      axis.text    = element_text(family = main_font,
                                  face = "bold",
                                  size = px_pt(12),
                                  color = sunlight_pal$text_main),
      axis.text.x  = element_text(margin = margin(t = 5)),
      axis.text.y  = element_text(margin = margin(r = 5),
                                  hjust = 1),
      axis.title   = element_text(family = main_font,
                                  size = px_pt(12),
                                  color = sunlight_pal$text_main),
      axis.title.x = element_text(margin = margin(t = 22)),
      axis.title.y = element_text(margin = margin(r = 22),
                                  angle = 90),
      
      plot.title.position   = "plot",
      plot.caption.position = "plot",
      plot.margin = margin(22, 22, 0, 22)
    )
}