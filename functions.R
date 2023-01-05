# GENERATE STYLE DYNAMICALLY
dynamic_style <- function(style) {
  sheet <- if_else(style == TRUE, "dark", "light")
  return(tags$head(tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = paste(sheet, ".css", sep = "")
  ))
  )}

# GENERATE PLOT DYNAMICALLY
dynamic_plot <- function(style) {
  chart_color <- if_else(style == TRUE, "black", "#FFF")
  return(chart_color)
}