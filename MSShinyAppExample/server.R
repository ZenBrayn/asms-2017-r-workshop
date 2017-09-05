
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(mzR)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
  
  # Read in the example mzML file
  # Get the headers
  # Pull out the spetra by MS level
  msdata <- openMSfile("../Example2/input_data/lfq_spikein_dilution_1.mzML", backend = "pwiz")
  scan_headers <- header(msdata)
  ms1_scan_headers <- scan_headers %>% filter(msLevel == 1)
  ms2_scan_headers <- scan_headers %>% filter(msLevel == 2)

  ms1_peaks <- peaks(msdata, ms1_scan_headers$seqNum)
  ms2_peaks <- peaks(msdata, ms2_scan_headers$seqNum)
  
  output$spectrum_plot <- renderPlot({
    ms_lvl <- NA
    sel_peaks <- NA
    if (input$ms_lvl == "MS1") {
      ms_lvl <- 1
      sel_peaks <- ms1_peaks
    } else {
      ms_lvl <- 2
      sel_peaks <- ms2_peaks
    }
    
    plot_spectrum(input$spec_num, ms_lvl, sel_peaks)
  })
  
  output$spec_num_slider <- renderUI({
    max_num <- ifelse(input$ms_lvl == "MS1", length(ms1_peaks), length(ms2_peaks))
    sliderInput("spec_num", 
                "Spectrum Number",
                min = 1,
                max = max_num,
                value = 1,
                step = 1,
                animate = TRUE)
  })

})
