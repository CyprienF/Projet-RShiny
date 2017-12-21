
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
        x <- seq(0,input$nb,1)
        y <- rbinom(x,input$n,input$proba)
        hist(y,probability = TRUE,
             xlim=c(min(y),max(y)), nclass=max(y)-min(y)+1, 
             col='lightblue',
             main=paste('Loi binomiale n = ',input$n, 'p = ',input$proba))
        lines(density(y,bw=1), col='red', lwd=3)
        
  })

})
