library(shiny)

shinyUI(navbarPage("",
                   tabPanel("Classifier",
                            
                            # Application title
                            titlePanel("Classification of NBA Rookies"),
                            
                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                              sidebarPanel(
                                #sliderInput("k",
                                            #"some number to choose",
                                            #min = 1,
                                            #max = 20,
                                            #value = 5),
                                checkboxGroupInput("checkGroup", label = h3("Dataset Features"), 
                                                   choices = feature.list, inline = F,
                                                   selected = names(feature.list))
                                 
                              ),
                              
                              # Display  results
                              mainPanel(
                                h3("Confusion matrix"),
                                dataTableOutput('confusionMatrix'),
                                h3("Accuracy of model"),
                                verbatimTextOutput("accuracy"),
                                plotOutput("ROC"),
                                h3("Summary of model"),
                                verbatimTextOutput('summary')
                                
                              )
                            ) ),
                   tabPanel("Visualize Features",
                            fluidRow(                           
                              column(4, selectInput("featureDisplay_x", 
                                                    label = h3("select 1st Feature"), 
                                                    choices = feature.list,
                                                    selected = feature.list[1])),
                              column(4, selectInput("featureDisplay_y", 
                                                    label = h3("select 2nd Feature"), 
                                                    choices = feature.list,
                                                    selected = feature.list[2]))
                              
                            ),
                            fluidRow(
                              column(4,
                                     plotOutput("distPlotA")
                              ),                              
                              column(4,
                                     plotOutput("distPlotB")      
                              ),
                              column(4,
                                     plotOutput("ScatterPlot")
                              )
                            )
                            
                            
                   )#tab panel close
                
))
                   

