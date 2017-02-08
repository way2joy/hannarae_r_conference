library(shiny)
numberDisplayUI <- function(Id, label) {
  ns <- NS(Id)
  tagList(
    sliderInput(ns("inputNum"), label, min = 1, max = 100, value = 50),
    textOutput(ns("outputNum"))
  )
}

numberDisplay <- function(input, output, session, outputLabel) {
  output$outputNum <- renderText({
    paste(outputLabel, ":" , input$inputNum)
  })
  reactive({input$inputNum})
}

ui <- fluidPage(
  numberDisplayUI("firstId", label = "첫 번째 값 선택"),
  numberDisplayUI("secondId", label = "두 번째 값 선택"),
  h2(textOutput("value"))
)

server <- function(input, output) {
  num1 <- callModule(numberDisplay, "firstId", outputLabel ="첫 번째 선택된 값")
  num2 <- callModule(numberDisplay, "secondId", outputLabel = "두 번째 선택된 값")
  output$value <- renderText({
    paste("두 값의 합은", num1() + num2(), "이다.")
  })
}
shinyApp(ui, server)
