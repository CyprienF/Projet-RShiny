
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  obs <- reactive({
    obs <- seq(0,input$nb,1)
  })
  
  xBinom <- reactive({
    x <- rbinom(obs(),input$n,input$proba)
  })
  
  N <- reactive({
    N <- seq(0,input$nbPoisson,1)
  })
  
  xPoiss <- reactive({
    x <- rpois(N(), input$lambdaPoisson)
  })

  output$dispBinomiale <- renderPlot({
        hist(xBinom(),probability = TRUE,
             xlim=c(min(xBinom()),max(xBinom())), nclass=max(xBinom())-min(xBinom())+1, 
             col='lightblue',
             main=paste('Loi binomiale n = ',input$n, 'p = ',input$proba))
        lines(density(xBinom(),bw=1), col='red', lwd=3)
        
  })
  
  output$summaryBinomiale <- renderPrint({
    summary(xBinom())
  })
  
  output$tableBino <- renderTable({
    summary <- table(xBinom())
  })
  
  output$dispPoisson <- renderPlot({
    hist(xPoiss(), 
         xlim=c(min(xPoiss()),max(xPoiss())), probability=T, nclass=max(xPoiss())-min(xPoiss())+1, 
         col='lightblue',
         main=paste('Loi de Poisson, lambda = ',input$lambdaPoisson))
    lines(density(xPoiss(),bw=1), col='red', lwd=3)
  })
  
  output$summaryPoisson <- renderPrint({
    summary(xPoiss())
  })
  
  output$tablePois <- renderTable({
    summary <- table(xPoiss())
  })
  
  z <- reactive({
    obs <- seq(0,input$nb,1)
    v <- rbinom(obs,input$n,input$proba)
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("test", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(z(), file, row.names = FALSE)
    }
  )

})
