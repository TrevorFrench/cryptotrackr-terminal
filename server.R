#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(dplyr)

server <- function(input, output, ...) {
  output$generatedStyle <- renderUI({
    dynamic_style(input$style)
  })
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
  
  output$p <- renderPlotly({
    day_candles <-
      huobi_candles(period = '1day',
                    size = '2000',
                    symbol = input$symbol)
    
    fig <-
      day_candles %>% plot_ly(
        x = ~ as.POSIXct(id, origin = "1970-01-01"),
        type = "candlestick",
        open = ~ open,
        close = ~ close,
        high = ~ high,
        low = ~ low
      )
    print(dynamic_plot(input$style))
    fig <- fig %>% layout(title = "BTC-USDT",
                          xaxis = list(title = "Date", rangeslider = list(visible = input$rangeSlider)),
                          paper_bgcolor = dynamic_plot(input$style),
                          plot_bgcolor = dynamic_plot(input$style))
  })
}