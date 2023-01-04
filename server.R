server <- function(input, output, ...) {
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
    
    fig <- fig %>% layout(title = "BTC-USDT",
                          xaxis = list(title = "Date", rangeslider = list(visible = input$rangeSlider)))
  })
}