
library(shiny)
library(dplyr)
suppressPackageStartupMessages(library(googleVis))


## Build data frame for creating plot
states <- data.frame(state.name, state.area, state.region,
                     hover=paste0(state.name, ": ", state.area, " square miles"))

states$hover <- as.character(states$hover)


shinyServer(function(input, output) {
        output$plot1 <- renderGvis({
                
                # assign slider values to a variable
                minarea <- input$area[1]
                maxarea <- input$area[2]
                
                # create vector containing values from check boxes
                regions <- vector(length = 4)
                
                ## if the inputId is found label is added to the "regions" vector, else "" is added
                regions[1] <- ifelse(input$NE, "Northeast", "")
                regions[2] <- ifelse(input$NC, "North Central", "")
                regions[3] <- ifelse(input$S, "South", "")
                regions[4] <- ifelse(input$W, "West", "")
                
                # filter data using slider and check box input
                plotdata <- states %>%
                        filter(state.area>minarea, state.area<maxarea) %>%  ## selected rows within range of required area
                        filter(state.region %in% regions) ## then selected out rows in the required region
                
                # plot map
                gvisGeoChart(plotdata,
                             locationvar = "state.name", hovervar = "hover",
                             options = list(region="US", displayMode="regions",
                                            resolution="provinces",
                                            width=800, height=600)
                )
        })
})
