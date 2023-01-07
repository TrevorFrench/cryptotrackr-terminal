#-------------------------------------------------------------------------------
#-----------------------------------LIBRARIES-----------------------------------
#-------------------------------------------------------------------------------
library(shiny)
library(plotly)
library(shinyWidgets)
library("quantmod")
library(gridlayout)

#-------------------------------------------------------------------------------
#----------------------------------UI FUNCTION----------------------------------
#-------------------------------------------------------------------------------
navbarPage(
  title = "cryptotrackr + quantmod",
  selected = "Cryptocurrencies",
  collapsible = TRUE,
  theme = bslib::bs_theme(),
  tabPanel(
    title = "Cryptocurrencies",
    uiOutput(outputId = "generatedStyle"),
    grid_container(
      layout = "crypto_options crypto_plot",
      row_sizes = "1fr",
      col_sizes = c(
        "250px",
        "1fr"
      ),
      gap_size = "10px",
      grid_card_plot(area = "crypto_plot"),
      grid_card(
        area = "crypto_options",
        selectInput(
          inputId = "crypto_symbol",
          label = "Select a Symbol",
          choices = list(
            `BTC - USDT` = "btcusdt",
            `ETH - BTC` = "ethbtc"
          )
        )
      )
    )
  ),
  tabPanel(
    title = "Equities",
    grid_container(
      layout = "area1 equity_plot",
      row_sizes = "1fr",
      col_sizes = c(
        "0.44fr",
        "1.56fr"
      ),
      gap_size = "10px",
      grid_card_plot(area = "equity_plot"),
      grid_card(
        area = "area1",
        textInput(
          inputId = "equity_symbol",
          label = "Ticker",
          value = "AMZN"
        ),
        textInput(
          inputId = "equity_from",
          label = "Beginning Date",
          value = "2020-01-01"
        ),
        textInput(
          inputId = "equity_to",
          label = "Ending Date",
          value = "2021-03-17"
        ),
        textInput(
          inputId = "equity_periodicity",
          label = "Periodicity",
          value = "daily"
        )
      )
    )
  ),
  tabPanel(
    title = "Settings",
    materialSwitch(
      inputId = "style",
      label = "Style",
      status = "danger",
      value = FALSE
    )
    )
)
