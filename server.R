#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(dplyr)
library(cryptotrackr)

#-------------------------------------------------------------------------------
#------------------------------------SOURCES------------------------------------
#-------------------------------------------------------------------------------
source("functions.R")

#-------------------------------------------------------------------------------
#--------------------------------SERVER FUNCTION--------------------------------
#-------------------------------------------------------------------------------
server <- function(input, output) {
  output$generatedStyle <- renderUI({
    dynamic_style(input$style)
  })
  
  observeEvent(input$show_crypto, {
    showModal(
      modalDialog(
        title = "Crypto Data",
        size = 'l',
        numericInput(
          "n_crypto",
          "Rows",
          value = 5,
          min = 1,
          step = 1
        ),
        downloadButton("download_crypto_table", "Download Table"),
        tableOutput("crypto_table"),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })
  
  observeEvent(input$show_equity, {
    showModal(
      modalDialog(
        title = "Equity Data",
        size = 'l',
        numericInput(
          "n_equity",
          "Rows",
          value = 5,
          min = 1,
          step = 1
        ),
        downloadButton("download_equity_table", "Download Table"),
        tableOutput("equity_table"),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })
  
  output$crypto_table <- renderTable(rownames = TRUE, {
    head(crypto_data(), input$n_crypto)
  })
  
  output$equity_table <- renderTable(rownames = TRUE, {
    head(equity_data(), input$n_equity)
  })
  
  crypto_data <- function() {
    day_candles <-
      huobi_candles(
        period = input$crypto_period,
        size = input$crypto_results,
        symbol = input$crypto_symbol
      )
    
    rownames(day_candles) <-
      as.POSIXct(day_candles$id, origin = "1970-01-01")
    day_candles <- rename(day_candles, "Volume" = "vol")
    day_candles <- select(day_candles,
                          open, high, low, close, Volume)
    xts_candles <- as.xts(day_candles)
    return(xts_candles)
  }
  
  crypto_plot = function() {
    chartSeries(crypto_data(),
                name = "cryptotrackr",
                theme = dynamic_plot(input$style))
  }
  equity_data <- function() {
    equities <- getSymbols(
      input$equity_symbol,
      from = input$equity_from,
      to = input$equity_to,
      periodicity = input$equity_periodicity,
      auto.assign = FALSE
    )
    return(equities)
  }
  equity_plot = function() {
    chartSeries(equity_data(),
                name = "quantmod",
                theme = dynamic_plot(input$style))
  }
  output$download_equity = downloadHandler(
    filename = 'equity_plot.jpg',
    content = function(file) {
      png(file)
      equity_plot()
      dev.off()
    }
  )
  
  output$download_crypto = downloadHandler(
    filename = 'crypto_plot.jpg',
    content = function(file) {
      png(file)
      crypto_plot()
      dev.off()
    }
  )
  
  output$download_crypto_table = downloadHandler(
    filename = 'crypto_table.csv',
    content = function(file) {
      write.zoo(
        head(crypto_data(), input$n_crypto),
        file,
        index.name = "Index",
        row.names = FALSE,
        sep = ","
      )
    }
  )
  
  output$download_equity_table = downloadHandler(
    filename = 'equity_table.csv',
    content = function(file) {
      write.zoo(
        head(equity_data(), input$n_equity),
        file,
        index.name = "Index",
        row.names = FALSE,
        sep = ","
      )
    }
  )
  
  output$crypto_plot <- renderPlot({
    crypto_plot()
  })
  
  output$equity_plot <- renderPlot({
    equity_plot()
  })
  
}