#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mytable = renderDataTable({
    diamonds
  })
  
  data <- reactive({
    diamonds[sample(nrow(diamonds), input$sampleSize),]
  })
  
  output$myplot = renderPlotly({
    
    type <- input$geom
    
    if (input$geom=="bar") {
       p <- ggplot(data(), aes_string(x = input$x, y = input$y, color = input$color)) + geom_bar(stat="identity")
    } else if (input$geom=="scatter") {
       p <- ggplot(data(), aes_string(x = input$x, y = input$y, color = input$color)) + geom_point()
    }
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .') p <- p + facet_grid(facets)
    
    ggplotly(p) %>% 
      layout(autosize=TRUE)
    
    
  })
  
  
})
