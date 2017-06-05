
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Spectrum Viewer"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("ms_lvl",
                  "MS Level",
                  choices = c("MS1", "MS2")),
      
      uiOutput("spec_num_slider")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("spectrum_plot")
    )
  )
))
