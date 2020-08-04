








library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Optimasi Nilai Pendapatan"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard1"),
        menuSubItem("Menampilkan Data", tabName = "mentahan"),
        menuSubItem("Menampilkan Chart", tabName = "hasil")
      )),
    dashboardBody(
      navbarPage(
        title = 'DataTable Options',
        tabPanel('Display length',     DT::dataTableOutput('ex1')),
        tabPanel('Length menu',        DT::dataTableOutput('ex2')),
        tabPanel('No pagination',      DT::dataTableOutput('ex3')),
        tabPanel('No filtering',       DT::dataTableOutput('ex4')),
        tabPanel('Function callback',  DT::dataTableOutput('ex5'))
      )
    )
  )
)