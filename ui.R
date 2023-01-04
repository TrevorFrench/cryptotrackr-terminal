library(shiny)
library(plotly)
library(cryptotrackr)

ui <- fluidPage(
  selectizeInput(
    inputId = "symbol", 
    label = "Select a symbol", 
    choices = unique(list('btcusdt', 'ethbtc')), 
    selected = "btcusdt",
    multiple = FALSE
  ),
  checkboxInput('rangeSlider', 'Range Slider', value = FALSE, width = NULL),
  plotlyOutput(outputId = "p")
)

