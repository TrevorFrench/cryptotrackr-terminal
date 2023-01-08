#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(dplyr)
library(cryptotrackr)

#-------------------------------------------------------------------------------
#------------------------------------SOURCES------------------------------------
#-------------------------------------------------------------------------------
source("functions.R")
# sourceDir("example/")

#-------------------------------------------------------------------------------
#--------------------------------SERVER FUNCTION--------------------------------
#-------------------------------------------------------------------------------
server <- function(input, output) {
  output$generatedStyle <- renderUI({
    dynamic_style(input$style)
  })
  
  output$crypto_plot <- renderPlot({
    day_candles <-
      huobi_candles(period = input$crypto_period,
                    size = input$crypto_results,
                    symbol = input$crypto_symbol)
    
    rownames(day_candles) <- as.POSIXct(day_candles$id, origin = "1970-01-01")
    day_candles <- rename(day_candles, "Volume" = "vol")
    day_candles <- select(day_candles,
                          open, high, low, close, Volume)
    xts_candles <- as.xts(day_candles)
    chartSeries(xts_candles, name = "cryptotrackr", theme = dynamic_plot(input$style))
  })
  
  output$equity_plot <- renderPlot({
    equities <- getSymbols(input$equity_symbol, 
                       from = input$equity_from, 
                       to = input$equity_to,
                       periodicity = input$equity_periodicity,
                       auto.assign=FALSE)
    
    chartSeries(equities, name = "quantmod", theme = dynamic_plot(input$style))
  })
  
  output$global <- renderText({
    global <- coingecko_global_data()
    global_df <- data.frame(global$market_cap_percentage)
    other <- 100 - sum(global_df[1,])
    global_list <- c(global_df[1,], list('other' = other))
    global_vec <- unlist(global_list)
    global_vec
  })
}