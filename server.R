
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$dispBinomiale <- renderPlot({
        obs <- seq(0,input$nb,1)
        x <- rbinom(obs,input$n,input$proba)
        hist(x,probability = TRUE,
             xlim=c(min(x),max(x)), nclass=max(x)-min(x)+1, 
             col='lightblue',
             main=paste('Loi binomiale n = ',input$n, 'p = ',input$proba))
        lines(density(x,bw=1), col='red', lwd=3)
        
  })
  
  output$summaryBinomiale <- renderPrint({
    obs <- seq(0,input$nb,1)
    v <- rbinom(obs,input$n,input$proba)
    summary(v)
  })
  
  output$tableBino <- renderTable({
    
  })
  
  output$dispPoisson <- renderPlot({
    N <- seq(0,input$nbPoisson,1)
    x <- rpois(N, input$lambdaPoisson)
    hist(x, 
         xlim=c(min(x),max(x)), probability=T, nclass=max(x)-min(x)+1, 
         col='lightblue',
         main=paste('Loi de Poisson, lambda = ',input$lambdaPoisson))
    lines(density(x,bw=1), col='red', lwd=3)
  })
  
  output$summaryPoisson <- renderPrint({
    N <- seq(0,input$nbPoisson,1)
    x <- rpois(N, input$lambdaPoisson)
    summary(x)
  })
  
  output$tablePois <- renderTable({
    
  })

})
