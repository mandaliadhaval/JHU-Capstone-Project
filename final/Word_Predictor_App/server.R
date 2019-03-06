#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
library(tm)
library(RWeka)
library(stringr)

shinyServer(
  function(input, output, session) {
    source("textPrediction.R") # load the prediction functions
    load("nFreq.Rda") # load the optimized ngram sparse matrices
    
    ## react to text input or prediction parameter events with a prediction
    observe({
      text.in <- as.character(input$text_in)
      count <- input$suggestions
      
      pcw <- NULL
      # if an empty field or a space, predict the word in progress
      if(str_sub(text.in, start=-1) != " " &&
         text.in != "") {
        pcw <- predictCurrentWord(text.in, nf, count)
        output$word.current=renderPrint(cat(pcw, sep="\n"))
      }
      # otherwise blank the current word prediction
      else if(nchar(text.in) > 0) 
        output$word.current=renderPrint(cat(""))
      
      # on space, start predicting the next word
      if(str_sub(text.in, start=-1) == " ") 
        output$word.next=renderPrint(
          cat(cleanPredictNextWord(text.in, nf, count), sep="\n"))
      # if not a space, but matches a word, also predict the next word
      else if(!is.null(pcw) && lastWords(text.in, 1) %in% pcw)
        output$word.next=renderPrint(
          cat(cleanPredictNextWord(text.in, nf, count), sep="\n"))
      # otherwise, blank the next word prediction
      else
        output$word.next=renderPrint(cat(""))
    })
  }
)
