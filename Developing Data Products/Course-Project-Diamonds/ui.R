## This is the user interface for the shiny app. It'll be used to determine diamond price based on carat, cut, color and clarity. 

## Loading the necessary packages
library(shiny)
library(ggplot2) # "diamonds" data set is in this package


## Load data
data("diamonds")

## Define UI for the application
shinyUI(fluidPage(
    titlePanel("Diamonds - Cost depends on Carat, Cut, Color and Clarity"),
    
    # Sidebar with slider input for number of variables
    sidebarLayout(
            sidebarPanel(h4("Choose Diamond Factors"),
                               selectInput(inputId="cut", label="Cut", choices=sort(unique(diamonds$cut), decreasing=TRUE)),
                               selectInput(inputId="color", label="Color", choices=sort(unique(diamonds$color))),
                               selectInput(inputId="clarity", label="Clarity", choices=sort(unique(diamonds$clarity), decreasing=T)),
                               sliderInput(inputId="lm", label="Carat",
                                           min = min(diamonds$carat), max = max(diamonds$carat),
                                           value = max(diamonds$carat)/2, step = 0.1),
                               h4("Predicted Price"), verbatimTextOutput("predict"), width = 4
                               ),
            
            # Show a plot of carat to price relationship
            mainPanel("Price/Carat Relationship", plotOutput("distPlot"))
                  )
))
