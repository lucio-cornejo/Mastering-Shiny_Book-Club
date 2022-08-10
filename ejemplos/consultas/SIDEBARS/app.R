library(shiny)

ui <- fluidPage(
  titlePanel("Teorema del Límite Central"),
  tabsetPanel(
    tabPanel("Panel 1",
      sidebarLayout(
        sidebarPanel(
          numericInput("m", "Tamaño de las muestras:", value = 2, min = 11, max = 100)
        ),
        mainPanel(
          plotOutput("hist")
        )
      )
    ),
    tabPanel("Panel 2",
      sidebarLayout(
        sidebarPanel(
          numericInput("m", "Muestras de tamaño:", value = 2, min = 11, max = 100)
        ),
        mainPanel(
          plotOutput("histo")
        )
      )
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
