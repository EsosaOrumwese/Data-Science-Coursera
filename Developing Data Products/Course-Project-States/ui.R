
library(shiny)


shinyUI(fluidPage(
    ## Main title of the UI
    titlePanel("Areas of US States"),
    
    ## Layout of the sidebar panel
    sidebarLayout(sidebarPanel(
            h3("Pick an area range"), ## sub header 
            
            ## Slider input parameters
            sliderInput(inputId = "area", label = "Square miles", 
                        min = 1200, max = 600000,
                        value = c(10000, 40000)),
            
            h3("Regions"), ## sub header
            
            ## checkbox parameters
            checkboxInput(inputId = "NE", label = "Northeast", value=T),
            checkboxInput(inputId = "NC", label = "North Central", value=T),
            checkboxInput(inputId = "S", label = "South", value=T),
            checkboxInput(inputId = "W", label = "West", value=T)),
    
    ## main panel to display plot
    mainPanel(htmlOutput(outputId = "plot1"))
    )
))
