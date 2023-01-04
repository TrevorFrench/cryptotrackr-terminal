#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(shiny)
library(shinyWidgets)
library(plotly)
library(cryptotrackr)

#-------------------------------------------------------------------------------
#----------------------------------UI FUNCTION----------------------------------
#-------------------------------------------------------------------------------
ui <- fluidPage(
  # DEFINE CSS
  uiOutput("generatedStyle"),
  materialSwitch(inputId = "style", 
                 label = "Style", 
                 status = "danger", 
                 value = FALSE),
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

