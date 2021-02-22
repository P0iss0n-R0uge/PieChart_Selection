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

# selection issue of highcharts select & unselect 
# https://stackoverflow.com/questions/60190866/event-to-capture-unselect-category
    
    
