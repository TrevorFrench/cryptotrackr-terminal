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
shinyUI(fluidPage(
  # DEFINE CSS
  uiOutput("generatedStyle"),
  # PAGE CONTENT
  fluidRow(
    column(9, "cryptotrackr-terminal", style='font-size:25px;'),
    column(3,
           materialSwitch(inputId = "style",
                          label = "Style",
                          status = "danger",
                          value = FALSE)
           ),
    style='padding:5px;'),
  fluidRow(    
    column(12, 
      selectizeInput(
        inputId = "symbol",
        label = "Select a symbol",
        choices = unique(list('btcusdt', 'ethbtc')),
        selected = "btcusdt",
        multiple = FALSE
      ),
      checkboxInput('rangeSlider', 'Range Slider', value = FALSE, width = NULL)
    )
  ),
  fluidRow(
    column(12,
           plotlyOutput(outputId = "p")
           )
  )
  # navbarPage("cryptotrackr-terminal",
  #            materialSwitch(inputId = "style", 
  #                           label = "Style", 
  #                           status = "danger", 
  #                           value = FALSE),
  #            selectizeInput(
  #              inputId = "symbol", 
  #              label = "Select a symbol", 
  #              choices = unique(list('btcusdt', 'ethbtc')), 
  #              selected = "btcusdt",
  #              multiple = FALSE
  #            ),
  #           checkboxInput('rangeSlider', 'Range Slider', value = FALSE, width = NULL),
  #           mainPanel(
  #             plotlyOutput(outputId = "p")
  #           )
  # )
  
)
)
