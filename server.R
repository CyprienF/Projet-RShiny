
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  # Variables de la loi binomiale
  obsBinomiale <- reactive({
    obs <- seq(1,input$nb,1)
  })
  
  xBinom <- reactive({
    x <- rbinom(obsBinomiale(),input$n,input$proba)
  })
  
  # Variables de la loi de poisson
  obsPoisson <- reactive({
    obs <- seq(1,input$nbPoisson,1)
  })
  
  xPoiss <- reactive({
    x <- rpois(obsPoisson(), input$lambdaPoisson)
  })
  
  # Variables de la loi exponentielle
  obsExponentielle <- reactive({
    obs <- seq(1,input$nbExponentielle,1)
  })
  
  xExponentielle <- reactive({
    x <- rexp(obsExponentielle(), input$lambdaExponentielle)
  })
  
  #Variables de la loi normale centrée réduite
  obsNorm <- reactive({
    obs <- seq(1,input$nbNorm,1)
  })
  
  xNorm <- reactive({
    x <- rnorm(input$nbNorm)
  })
  
  output$dispNormale <- renderPlot({
    hist(xNorm(), xlab = "x", ylab = "Fréquence",
         main = "Loi normale centrée réduite",
         col = "skyblue", border = "white")
    lines(density(xNorm(),bw=1), col='red', lwd=3)
    abline(v = mean(xNorm()),
           col = "royalblue",
           lwd = 2)
    abline(v = median(xNorm()),
           col = "green",
           lwd = 2)
    legend(x = "topright",
           c("Densite", "Moyenne", "Mediane"),
           col = c("red", "royalblue", "green"),
           lwd = c(2, 2, 2))
    })
  output$summaryNormale <- renderPrint({
    summary(xNorm())
  })
  
  output$tableNorm <- renderTable({
    summary <- table(xNorm())
  })
  
  # Graphique de la loi binomiale
  output$dispBinomiale <- renderPlot({
        hist(xBinom(),probability = TRUE, xlab = "x",
             xlim=c(min(xBinom()),max(xBinom())), nclass=max(xBinom())-min(xBinom())+1, 
             col='lightblue',
             main=paste('Loi binomiale n = ',input$n, 'p = ',input$proba))
        lines(density(xBinom(),bw=1), col='red', lwd=3)
        abline(v = mean(xBinom()),
               col = "royalblue",
               lwd = 2)
        abline(v = median(xBinom()),
               col = "green",
               lwd = 2)
        legend(x = "topright",
               c("Densite", "Moyenne", "Mediane"),
               col = c("red", "royalblue", "green"),
               lwd = c(2, 2, 2))
        
  })
  
  # Résumé de la loi binomiale
  output$summaryBinomiale <- renderPrint({
    summary(xBinom())
  })
  
  output$boxplotNorm <- renderPlot({
    boxplot(xNorm())
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
    hist(xPoiss(), xlab = "x",
         xlim=c(min(xPoiss()),max(xPoiss())), probability=T, nclass=max(xPoiss())-min(xPoiss())+1, 
         col='lightblue',
         main=paste('Loi de Poisson, lambda = ',input$lambdaPoisson))
    lines(density(xPoiss(),bw=1), col='red', lwd=3)
    abline(v = mean(xPoiss()),
           col = "royalblue",
           lwd = 2)
    abline(v = median(xPoiss()),
           col = "green",
           lwd = 2)
    legend(x = "topright",
           c("Densite", "Moyenne", "Mediane"),
           col = c("red", "royalblue", "green"),
           lwd = c(2, 2, 2))
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
  
  # Graphique de la loi exponentielle
  output$dispExponentielle <- renderPlot({
    hist(xExponentielle(), probability=T,
         col='light blue', main=paste('Loi exponentielle, lambda = ',input$lambdaExponentielle))
    lines(density(xExponentielle(),bw=1), col='red', lwd=3)
    abline(v = mean(xExponentielle()),
           col = "royalblue",
           lwd = 2)
    abline(v = median(xExponentielle()),
           col = "green",
           lwd = 2)
    legend(x = "topright",
           c("Densite", "Moyenne", "Mediane"),
           col = c("red", "royalblue", "green"),
           lwd = c(2, 2, 2))
  })
  
  # Résumé de la loi exponentielle
  output$summaryExponentielle <- renderPrint({
    summary(xExponentielle())
  })
  
  output$tableExp <- renderTable({
    summary <- table(xExponentielle())
  })
  
  output$boxplotExp <- renderPlot({
    boxplot(xExponentielle())
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
  
  # Téléchargement du fichier de la loi exponentielle
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste("table_valeurs_expo", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(xExponentielle(), file, row.names = FALSE)
    }
  )
  
  # Téléchargement du fichier de la loi normale
  output$downloadData3 <- downloadHandler(
    filename = function() {
      paste("table_valeurs_norm", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(xNorm(), file, row.names = FALSE)
    }
  )

})
