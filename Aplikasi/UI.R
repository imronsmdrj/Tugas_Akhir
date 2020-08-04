library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
#library(ggplot2)
#library(readxl)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Optimasi Nilai Pendapatan"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard1", icon=icon("dashboard")),
        menuSubItem("Menampilkan Data", tabName = "mentahan", icon=icon("file-excel")),
        menuSubItem("Menampilkan Chart", tabName = "hasil", icon=icon("chart-pie")),
        menuItem("Regresi Berganda", tabName = "rlb", icon=icon("edit")),
        
        sliderInput("bins",
                    "Number of bins:", min=1, max=50, value=20)
      )),
    dashboardBody(
      tabItems(
        #Page 1
        tabItem(tabName = "dashboard1",
                h1("Dashboard Utama"),
                br(),
                fluidRow(infoBoxOutput("min_", width = 3),
                         infoBoxOutput("max_", width = 3),
                         infoBoxOutput("sd_", width = 3),
                         infoBoxOutput("mean_", width = 3)),
               #secnd row
               fluidRow(box(title = "Box with a plot",plotOutput("plot1", height = 500)),
                        box(title = "Box with a plot", plotOutput("plot2", height = 500))),
               
               #third row
               fluidRow(box(title = "Plot Pendapatan", plotOutput("plot3", height = 500))),
        ),
               
        
        #Page 2
        tabItem(tabName = "mentahan",
                h1("Dashboard Untuk Menampilkan Data"),
                fluidPage(
                  fileInput(
                    inputId = "filedata",
                    label = "Upload data. Choose csv file",
                    accept = c(".csv")
                  ),
                  
                mainPanel(
                  DTOutput(outputId = "table")
                ))
        ),
        
        #Page 3
        tabItem(tabName = "hasil",
                fluidRow(
                  box(title = "Histogram Pendapatan", status = "primary", solidHeader = T, plotOutput("dataset1")),
                  box(title = "Histogram Jumlah Pelanggan", status = "primary", solidHeader = T, plotOutput("dataset2"))
                ),
                
                #fluidRow(
                  #box(title = "Histogram Jumlah Pelanggan", status = "primary", solidHeader = T, tableOutput("dataset3"))
                ),
        
        #Page 4
        tabItem(tabName = "rlb",
                sidebarPanel(
                  selectInput("vardep", label = h3("Variabel Dependen"),
                              choices = list("pendapatan" = "pendapatan", 'jumlah_pelanggan' = 'jumlah_pelanggan', 'jumlah_produk' = 'jumlah_produk')),
                  selectInput("varindep", label = h3("Variabel Independen"),
                              choices = list("jumlah_pelanggan"="jumlah_pelanggan", "jumlah_produk"="jumlah_produk",'pendapatan'='pendatan'))
                ),
                mainPanel(
                  tabsetPanel(type = "tabs",
                              tabPanel("Scatterplot", plotOutput("scatterplot")),
                              tabPanel("Ringkasan Model", verbatimTextOutput("summary")),#output regresi
                              tabPanel("Data", DT::dataTableOutput('dataset4')))
                )
            )
      )
    )
  )
)