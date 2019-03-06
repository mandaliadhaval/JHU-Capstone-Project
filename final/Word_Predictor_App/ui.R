#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(navbarPage("Text Predictor",
                   tabPanel("Predict",
                            fluidRow(
                              column(4,
                                     h3('Input'), 
                                     tags$textarea(id="text_in", rows=6, cols=60),
                                     h4('Prediction Parameters'), 
                                     sliderInput("suggestions", "Word Suggestions", 
                                                 value=1.0, min=1.0, max=5.0, step=1.0)
                              ),
                              column(2,
                                     h3("Current Word"),
                                     HTML("<br>"),
                                     verbatimTextOutput('word.current')
                              ),
                              column(2,
                                     h3("Next Word"),
                                     HTML("<br>"),
                                     verbatimTextOutput('word.next')
                              )
                            )
                   ),
                   tabPanel("About", HTML("Created by: Dhaval Mandalia")
                   )
))
