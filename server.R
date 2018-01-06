
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  # Variables de la loi binomiale
  obs <- reactive({
    obs <- seq(1,input$nb,1)
  })
  
  xBinom <- reactive({
    x <- rbinom(obs(),input$n,input$proba)
  })
  
  # Variable de la loi de poisson
  N <- reactive({
    N <- seq(1,input$nbPoisson,1)
  })
  
  xPoiss <- reactive({
    x <- rpois(N(), input$lambdaPoisson)
  })

  # Graphique de la loi binomiale
  output$dispBinomiale <- renderPlot({
        hist(xBinom(),probability = TRUE,
             xlim=c(min(xBinom()),max(xBinom())), nclass=max(xBinom())-min(xBinom())+1, 
             col='lightblue',
             main=paste('Loi binomiale n = ',input$n, 'p = ',input$proba))
        lines(density(xBinom(),bw=1), col='red', lwd=3)
        
  })
  
  # Résumé de la loi binomiale
  output$summaryBinomiale <- renderPrint({
    summary(xBinom())
  })
  
  # Table des valeurs de la loi binomiale
  output$tableBino <- renderTable({
    summary <- table(xBinom())
  })
  
  # Boxplot de la loi binomiale
  output$boxplotBinomiale <- renderPlot({
    boxplot(xBinom())
  })
  
  # Graphique de la loi de poisson
  output$dispPoisson <- renderPlot({
    hist(xPoiss(), 
         xlim=c(min(xPoiss()),max(xPoiss())), probability=T, nclass=max(xPoiss())-min(xPoiss())+1, 
         col='lightblue',
         main=paste('Loi de Poisson, lambda = ',input$lambdaPoisson))
    lines(density(xPoiss(),bw=1), col='red', lwd=3)
  })
  
  # Résumé de la loi de poisson
  output$summaryPoisson <- renderPrint({
    summary(xPoiss())
  })
  
  # Table des valeurs de la loi de poisson
  output$tablePois <- renderTable({
    summary <- table(xPoiss())
  })
  
  # Boxplot de la loi de poisson
  output$boxplotPoisson <- renderPlot({
    boxplot(xPoiss())
  })
  
  # Téléchargement du fichier de la loi binomiale
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("table_valeurs_binom", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(xBinom(), file, row.names = FALSE)
    }
  )
  
  # Téléchargement du fichier de la loi de poisson
  output$downloadData1 <- downloadHandler(
    filename = function() {
      paste("table_valeurs_poiss", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(xPoiss(), file, row.names = FALSE)
    }
  )

})
