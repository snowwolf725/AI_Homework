library(shiny)
shinyUI(pageWithSidebar(headerPanel("Data science!"),
                        sidebarPanel(h3('K-Means')),
                        mainPanel(
                          fileInput("fileA", label = h3("Set A File input")),
                          hr(),
                          fileInput("fileB", label = h3("Set B File input")),
                          hr(),
                          fileInput("fileC", label = h3("Set C File input")),
                          hr(),
                          actionButton("action", label = "Action"),
                          hr(),
                          plotOutput("myPlot"),
                          hr(),
                          plotOutput("resultPlot")
                        )))