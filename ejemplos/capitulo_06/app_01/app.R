library(shiny)

ui <- fluidPage(
  titlePanel("Teorema del Límite Central"),
  sidebarLayout(
    sidebarPanel(
      numericInput("m", "Tamaño de las muestras:", 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output, session) {
  output$hist <- renderPlot({
    medias <- replicate(1e4, mean(runif(input$m)))
    hist(medias, breaks = 20, main = "Histograma de las medias")
  }, res = 96)
}

shinyApp(ui, server)
