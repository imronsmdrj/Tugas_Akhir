library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(gganimate)
library(dplyr)
library(plotly)
library(hrbrthemes)
library(GA)

#use the below code options if you wish to increase the file input limit
#options(shiny.maxRequestSize = 9*1024^2)

#Generate 50 random numbers
s = sample(10:60, 25)

shinyServer(function(input,output,session){
  
  #Page 1
  output$min_ <- renderInfoBox({
    infoBox(title = "Minimun",
            value = min(s),
            subtitle = "Minimum value in dataset",
            fill = TRUE)
  })
  
  output$max_ <- renderInfoBox({
    infoBox(title = "Maximum",
            value = max(s),
            subtitle = "Maximum value in dataset",
            fill = T, color = "yellow")
  })
  
  output$sd_ <- renderInfoBox({
    infoBox(title = "SD",
            value = round(sd(s), 2),
            subtitle = "Standard Deviation", icon("arrow-up"))
  })
  
  output$mean_ <- renderInfoBox({
    infoBox(title = "Mean",
            value = mean(s),
            subtitle = "Mean of dataset values",
            icon = icon("angle-double-right"))
  })
  
  #plot jumlah Pelanggan
  output$plot1 <- renderPlot({
    ggplot(bisa, aes(x=bulan, y=jumlah_produk)) + 
      geom_line(color = "grey") + 
      geom_point(shape=21, color="skyblue", fill="#69b3a2", size=6) +
      theme_ipsum()
  })
  
  
  #plot jumlah produk
  output$plot2 <- renderPlot({
    ggplot(bisa, aes(x=bulan, y=jumlah_pelanggan)) +
      geom_line(color="blue") +
      geom_point(shape=21, color="green", fill="#69b3a2", size=6) +
      theme_ipsum()
  })
  
  #plot pendapatan
  output$plot3 <- renderPlot({
    ggplot(bisa, aes(x=bulan, y=pendapatan)) +
      geom_line(color="red") +
      geom_point(shape=21, color="yellow", fill="#69b3a2", size=5) +
      theme_ipsum()
  })
  
  
  #Page 2
  data <- reactive({
    req(input$filedata)
    read.csv(input$filedata$datapath)
  })
  
  output$table <- renderDT(data())
  
  #Page 3
  output$dataset1 <- renderPlot({
    ggplot(dataset, aes(x=pendapatan)) + geom_histogram(colour = "blue")
    #bins <- seq(min(dataset), max(dataset), length.out = input$bins)
  })
  
  output$dataset2 <- renderPlot({
    ggplot(dataset, aes(x=jumlah_pelanggan, y=jumlah_produk)) + geom_area(fill="#69b3a2", alpha=0.5) +
      geom_line(color="#69b3a2") + ylab("Jumlah Pelanggan") +
      xlab("Jumlah Produk") + theme_ipsum()
  })
  
  output$dataset3 <- renderTable({
    head(dataset)
    pairs(dataset[1:3])
    model <- lm(pendapatan ~ jumlah_pelanggan + jumlah_produk, dataset)
    spend_value <- predict(model, dataset)
    spend_value
    #bins <- seq(min(dataset), max(dataset), length.out = input$bins)
  })
  
  
  #Page 4
  #Output Regresi
  output$summary <- renderPrint({
    model <- lm(pendapatan ~ jumlah_pelanggan + jumlah_produk, dataset)
    spend_value <- predict(model, dataset)
    spend_value
    summary(model)
  })
  
  #Output Data
  output$dataset4 = DT::renderDataTable({
    DT::datatable(lihat, options = list(lengthChange = FALSE))
  })
  
  #Output Scatterplot
  output$scatterplot <- renderPlot({
    plot(lihat[,input$varindep1], lihat[,input$vardep], main="Scatter Plot",
         xlab=input$varindep1, ylab=input$vardep, pch=10)
    
    abline(lm(lihat[,input$vardep] ~ lihat[,input$varindep1]), col="red")
    
    lines(lowess(lihat[,input$varindep1], lihat[,input$vardep]), col="blue")
  }, height = 400)
  
  
  observeEvent(input$hitung,{
    z <- as.numeric(input$satu)
    a <- as.numeric(input$dua)
    
    #reactive expression
    k <- 38698.09 + 9.01*z + 14438.94*a
    
    output$less <- renderPrint(k)
  
  })
    
  observeEvent(input$proses,{
    b <- as.numeric(input$hasilY)
    c <- as.numeric(input$y)
    
    #reactive expression
    d <- b - c
    
    output$error <- renderPrint(d)
    
  })
  
  
  #Page 5
  output$model <- renderPrint({
    Rastrigin <- function(x1, x2)
    {
      y = 38698.09 + x1*9.01 + x2*14438.94
    }
    
    x1 <- x2 <- seq(-5, 5, by = 0.1)
    
    f <- outer(x1, x2, Rastrigin)
    
    GA <- ga(type = "real-valued", pcrossover = 0.1, fitness = function(x) -Rastrigin(x[1], x[2]),
             lower = c(18, 20), upper = c(20, 21),
             seed = 123, elitism = 30, popSize = 50, maxiter = 100, run = 30)
    
    summary(GA)
  })
})