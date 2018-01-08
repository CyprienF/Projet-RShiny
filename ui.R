
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  navbarPage("Lois de probabilité",
             tabPanel("Loi Binomiale",
                      # Application title
                      titlePanel("Loi Binomiale"),
                      
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("nb",
                                      "Nombre d'observations",
                                      min = 1,
                                      max = 5000,
                                      value = 100),
                          sliderInput("n","Nombre d'essais",min = 0,max = 1000, value = 100),
                          sliderInput("proba","Probabilité",min = 0, max = 1, value = 0.5),
                          downloadButton("downloadData", "Sauvegarder les valeurs")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                      tabPanel("Graphique", plotOutput("dispBinomiale")),
                                      tabPanel("Résumé", verbatimTextOutput("summaryBinomiale")),
                                      tabPanel("Boxplot", plotOutput("boxplotBinomiale")),
                                      tabPanel("Table des valeurs", tableOutput("tableBino"))
                        )
                      )
                      )
             ),
             tabPanel("Loi de Poisson",
                      # Application title
                      titlePanel("Loi de Poisson"),
                      
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("nbPoisson",
                                      "Nombre d'observations",
                                      min = 1,
                                      max = 5000,
                                      value = 2500),
                          sliderInput("lambdaPoisson",
                                      "Lambda",
                                      min = 0,
                                      max = 20,
                                      step = 0.1,
                                      value = 10),
                         downloadButton("downloadData1", "Sauvegarder les valeurs")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                      tabPanel("Graphique", plotOutput("dispPoisson")),
                                      tabPanel("Résumé", verbatimTextOutput("summaryPoisson")),
                                      tabPanel("Boxplot", plotOutput("boxplotPoisson")),
                                      tabPanel("Table des valeurs", tableOutput("tablePois"))
                          )
                        )
                      )
             ),
             tabPanel("Loi exponentielle",
                      # Application title
                      titlePanel("Loi exponentielle"),
                      
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("nbExponentielle",
                                      "Nombre d'observations",
                                      min = 1,
                                      max = 5000,
                                      value = 2500),
                          sliderInput("lambdaExponentielle",
                                      "Lambda",
                                      min = 1,
                                      max = 20,
                                      step = 0.1,
                                      value = 10),
                          downloadButton("downloadData2", "Sauvegarder les valeurs"),
                          actionButton('save_inputs', 'Save inputs')
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                      tabPanel("Graphique", plotOutput("dispExponentielle")),
                                      tabPanel("Résumé", verbatimTextOutput("summaryExponentielle")),
                                      tabPanel("Boxplot", plotOutput("boxplotExp")),
                                      tabPanel("Table des valeurs", tableOutput("tableExp"))
                                      
                          )
                        )
                      )
             ),
             tabPanel("Loi normale centrée réduite",
                      # Application title
                      titlePanel("Loi normale centrée réduite"),
                      
                      # Sidebar with a slider input for number of bins
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("nbNorm",
                                      "Nombre d'observations",
                                      min = 1,
                                      max = 5000,
                                      value = 2500),
                          downloadButton("downloadData3", "Sauvegarder les valeurs")
                        ),
                        
                        # Show a plot of the generated distribution
                        mainPanel(
                          tabsetPanel(type = "tabs",
                                      tabPanel("Graphique", plotOutput("dispNormale")),
                                      tabPanel("Résumé", verbatimTextOutput("summaryNormale")),
                                      tabPanel("Boxplot", plotOutput("boxplotNorm")),
                                      tabPanel("Table des valeurs", tableOutput("tableNorm"))
                          )
                        )
                      )
             )

  )
))
