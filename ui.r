library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    dashboardHeader(
      title = "Pie Chart Selection"
    ),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
      uiOutput("PieCharts")
    )
  )
)
    
    
