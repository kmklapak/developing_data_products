#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)
geomls <- ls(pattern = '^geom_', env = as.environment('package:ggplot2'))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Explore Diamond Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(diamonds),
                 value=min(1000, nrow(diamonds)), step=500, round=0),
      
      selectInput('x', 'X', names(diamonds)),
      selectInput('y', 'Y', names(diamonds), names(diamonds)[[2]]),
      selectInput('color', 'Color', c(names(diamonds))),
      
      selectInput('facet_row', 'Facet Row', c(None='.', names(diamonds))),
      selectInput('facet_col', 'Facet Column', c(None='.', names(diamonds))),
      selectInput('geom', 'Graph type', c("bar","scatter"))
      
      
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      p("Use the drop-down menus in the side-panel on the right side to change how the data is displayed in the chart. 
        You can also interact with the chart, as it is created with Plotly. Hover over it to see actions avaiable.
        Lastly, you can also click the Dataset tab below to browse the data in table format.  "),
      tabsetPanel(
        tabPanel("Visualize Data", icon = icon("bar-chart"), plotlyOutput("myplot")),
        tabPanel("Dataset", dataTableOutput('mytable'), icon = icon("table"))
      )
    )
  )
))
