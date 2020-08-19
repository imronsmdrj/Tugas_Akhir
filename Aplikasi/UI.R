library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(GA)
#library(ggplot2)
#library(readxl)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Optimasi Nilai Pendapatan"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard1", icon=icon("dashboard")),
        menuSubItem("Menampilkan Data", tabName = "mentahan", icon=icon("file-excel")),
        #menuSubItem("Menampilkan Chart", tabName = "hasil", icon=icon("chart-pie")),
        menuItem("Regresi Linier Berganda", tabName = "rlb", icon=icon("edit")),
        menuItem("Algoritma Genetika", tabName = "ag", icon=icon("edit"))
        
        #sliderInput("bins",
         #           "Number of bins:", min=1, max=50, value=20)
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
                              choices = list("pendapatan (Y)" = "pendapatan", 'Jumlah Pelanggan (X1)' = 'jumlahPelanggan', 'Jumlah Produk (X2)' = 'jumlahProduk')),
                  selectInput("varindep1", label = h3("Variabel Independen"),
                              choices = list("Jumlah Produk (X2)" = "jumlahProduk", "Jumlah Pelanggan (X1)" = "jumlahPelanggan",'Pendapatan (Y)' = 'pendapatan'))
                  #selectInput("varindep2", label = h3("Variabel Independen"),
                              #choices = list("Jumlah Pelanggan (X1)" = "jumlah_pelanggan", "Jumlah Pelanggan (X2)" = "jumlah_produk",'Pendapatan (Y)' = 'pendapatan'))
                ),
                mainPanel(
                  tabsetPanel(type = "tabs",
                              tabPanel("Scatterplot", plotOutput("scatterplot")),
                              tabPanel("Ringkasan Model", verbatimTextOutput("summary")),#output regresi
                              tabPanel("Data", DT::dataTableOutput('dataset4')))
                ),
                sidebarPanel(
                    textInput("satu", "Masukan Nilai X1"),
                    textInput("dua", "Masukan Nilai X2"),
                      actionButton("hitung", "Proses")
                ),
                mainPanel(
                  tags$h3('Hasil :'),
                  verbatimTextOutput("less"),
                  
                  tags$h3('Standard Error Estimate :'),
                  verbatimTextOutput("cross")
                )
                
            ),
        
        #Page 5
        tabItem(tabName = "ag",
                sidebarPanel(
                  selectInput("popuSize", label = h3("Jumlah Populasi"),
                              choices = list(10,20,30,40,50)),
                ),
                mainPanel(
                  tabsetPanel(type = "tabs",
                              tabPanel("Ringkasan Model", verbatimTextOutput("model"))),
                  
                      )
                )
      )
    )
  )
)