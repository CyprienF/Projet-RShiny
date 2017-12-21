
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Application web pour les lois de probabilité"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("nb",
                  "Nombre d'observations",
                  min = 1,
                  max = 5000,
                  value = 100),
      sliderInput("n","Nombre d'essais",min = 0,max = 1000, value = 100),
      sliderInput("proba","Probabilité",min = 0, max = 1, value = 0.5)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
