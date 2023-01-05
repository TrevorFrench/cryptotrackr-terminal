#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(dplyr)

#-------------------------------------------------------------------------------
#------------------------------------SOURCES------------------------------------
#-------------------------------------------------------------------------------
source("functions.R")
# sourceDir("convertors/")

#-------------------------------------------------------------------------------
#--------------------------------SERVER FUNCTION--------------------------------
#-------------------------------------------------------------------------------
server <- function(input, output, ...) {
  output$generatedStyle <- renderUI({
    dynamic_style(input$style)
  })
  
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

    fig <- fig %>% layout(title = list(text = "BTC-USDT", font = list(color = '#FFF')),
                          xaxis = list(title = "Date", 
                                       rangeslider = list(visible = input$rangeSlider)),
                          paper_bgcolor = dynamic_plot(input$style),
                          plot_bgcolor = dynamic_plot(input$style))
  })
}