library(tidyverse)
library(mrgsolve)
library(shinydashboard)
library(gridExtra)
library(grid)

mod <- mread_cache('Biliary.cpp')

body <- dashboardBody(
  fluidPage(
    fluidRow(
      column(width = 2,
            tabBox(
                width = 12,
                fileInput("file1", "Upload data", accept = ".csv"),
                tabPanel("Parameter",
                  sliderInput('KA', 'KA', 0, 10, 1.5),
                  sliderInput('VC', 'VC', 1, 1000, 100),
                  sliderInput('VP', 'VP', 1, 1000, 100),
                  sliderInput('CLint', 'CLint', 1, 1000, 800),
                  sliderInput('Q', 'Q', 1, 1000, 40),
                  sliderInput('CLbile', 'CLbile', 1, 100, 40, step = 1),
                  sliderInput('CL', 'CL', 0, 50, 1),
                  sliderInput('Tbil', 'Tbil', 0, 10, 0.25, step = 0.05),
                  numericInput('DOSE', 'DOSE(mpk)', 10, 100, 10),
                  checkboxInput('PO', 'PO'),
                  sliderInput('MTIME1', 'MTIME1', 1, 5, 2.5, step = 0.5),
                  sliderInput('MTIME2', 'MTIME2', 1, 12, 9, step = 0.5),
                  sliderInput('MTIME3', 'MTIME3', 1, 24, 12, step = 0.5),
                  sliderInput('Kp', 'Kp', 1, 20, 5, step = 0.2),
                  sliderInput('KB', 'KB', 1, 20, 10, step = 0.2),
                  sliderInput('F', 'F', 0, 2, 1, step = 0.1)
            ))),
           
      column(8,
             tabsetPanel(position = "below",
                         tabPanel("PK",
                                  fluidRow(
                                    column(12,
                                           plotOutput("result", height = "600"),
                                           verbatimTextOutput('Sim_result_k'),
                                           verbatimTextOutput('Sim_result_kliv')))),
                         tabPanel("All",
                                  fluidRow(
                                    column(12,
                                           plotOutput("resultplot_all", height = "600"))
                                  ))))
      )))
 

sidebar <- dashboardSidebar(
  disable = TRUE
)

ui = dashboardPage(
  dashboardHeader(
    title = "Biliary excretion"
  ),
  sidebar = sidebar,
  body)

# Define server logic required to draw a histogram


server <- function(input, output, session) {

  obs_data <- reactive({
    file <- input$file1
    ext <- tools::file_ext(file$datapath)

    data <- read.csv(file$datapath, header = TRUE)
    colnames(data) <- tolower(colnames(data))
    colnames(data)[(colnames(data) %in% c('dv', 'cp', 'c', 'con', 'conc'))] = "dv"
    colnames(data)[(colnames(data) %in% c('resp', 'res', 'pd', 'tv'))] = "pd"
    data
  })

  evt <- reactive({
    single <- data.frame(ID=1,
                         amt = 1000*28*input$DOSE,
                         cmt= ifelse(input$PO, 1, 4),
                         ii = 0,
                         addl = 0,
                         time = 0,
                         evid = 1,
                         DOSE = input$DOSE,
                         rate = 0
    )

})



  Sim_result <-reactive({
    mod <- param(mod, list(P_F = input$F,
                            KA = input$KA,
                            VC = input$VC,
                            VP = input$VP,
                            CLint = input$CLint,
                            Q = input$Q,
                            CLbile = input$CLbile,
                            CL = input$CL,
                            MTIME1 = input$MTIME1,
                            MTIME2 = input$MTIME2,
                            MTIME3 = input$MTIME3,
                            Tbil = input$Tbil,
                            Kp = input$Kp,
                            KB = input$KB
    ))
      mod  %>%
        Req(CP, Cliv) %>%
        data_set(evt()) %>%
        carry_out(DOSE, evid) %>%
        mrgsim(end = 24) %>%
        as.data.frame()
  })

  output$resultplot_all <- renderPlot({
    mod <- param(mod, list(P_F = input$F,
                           KA = input$KA,
                           VC = input$VC,
                           VP = input$VP,
                           CLint = input$CLint,
                           Q = input$Q,
                           CLbile = input$CLbile,
                           CL = input$CL,
                           MTIME1 = input$MTIME1,
                           MTIME2 = input$MTIME2,
                           MTIME3 = input$MTIME3,
                           Tbil = input$Tbil,
                           Kp = input$Kp,
                           KB = input$KB
    ))
    mod %>%
     # Req(CP, Cliv) %>%
      data_set(evt()) %>%
      carry_out(DOSE) %>%
      mrgsim(end = 24) %>%
      plot()
  })
  
  Sim_result1 <- reactive({

      Sim_result() %>%
        filter(evid == 0) %>%
        mutate(DOSE = as.factor(DOSE)) %>%
        mutate(CP = ifelse(CP < 10^(-10), 0, CP))
  })

  output$Sim_result_k <- renderPrint({
    Sim_result() %>%
      slice((n()-10):n()) %>%
      lm(log(CP) ~ time, .)
  })
  
  output$Sim_result_kliv <- renderPrint({
    Sim_result() %>%
      slice((n()-10):n()) %>%
      lm(log(Cliv) ~ time, .)
  })
  resultplot_pre <- reactive({
    
      p3 <- Sim_result1() %>%
        ggplot() +
        geom_line(aes(x = time, y = CP, col = DOSE)) +
        labs(y = paste0("concentration (", input$y_axis, ")"), x = paste0("time (", input$x_axis, ")"), col = paste0("Dose (", input$dose_unit, ")")) +
        theme_bw() +
        scale_color_brewer(palette = "Dark2")
      if(is.null(input$file1)){
        p3
      } else if (c('dv') %in% colnames(obs_data())){
        p3  + geom_point(data = obs_data(), aes(x = time, y = dv, shape = 'observation'))
      } else {
        p3
      }

  })

  resultplot_pre_liver <- reactive({
    
      p3 <- Sim_result1() %>%
        ggplot() +
        geom_line(aes(x = time, y = Cliv, col = DOSE)) +
        labs(y = paste0("concentration (", input$y_axis, ")"), x = paste0("time (", input$x_axis, ")"), col = paste0("Dose (", input$dose_unit, ")")) +
        theme_bw() +
        scale_color_brewer(palette = "Dark2")
      if(is.null(input$file1)){
        p3
      } else if (c('dv') %in% colnames(obs_data())){
        p3  + geom_point(data = obs_data(), aes(x = time, y = dv2, shape = 'observation'))
      } else {
        p3
      }

  })


  resultplot <- reactive({

      p <- resultplot_pre()
 
      a <- p

    b <- a +      
        scale_y_continuous(trans = "log10") +
        ylab(paste0("log concentration (", input$y_axis, ")"))


     c <- resultplot_pre_liver()
     d <- c +
      scale_y_continuous(trans = "log10") +
      ylab(paste0("log concentration (", input$y_axis, ")"))
    grid.arrange(a, b, c, d, nrow = 2)
    g <- arrangeGrob(a, b, c, d, nrow = 2)
    g
  })


  output$result <- renderPlot({
    resultplot()
  })


}

# Run the application
shinyApp(ui = ui, server = server)
