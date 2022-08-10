library(shiny)

# Data inicial
# write.csv(iris, "./iris.csv", row.names = FALSE)

ui <- fluidPage(
  tableOutput("iris"),
  actionButton("actualizar", label = "Insertar una fila de ejemplo al dataset")
)

server <- function(input, output, session) {
  output$iris <- renderTable({
    if (input$actualizar > 0) {
      # Leer dataset actual
      datos <- read.csv("./iris.csv")
      
      # Crear fila por añadir al dataset
      temp <- data.frame(
        Sepal.Length = 0,
        Sepal.Width = 0,
        Petal.Length = 0,
        Petal.Width = 0,
        Species = "setosa"
      )
      datos <- rbind(temp, datos)
      
      # Guardar nuevo dataset
      write.csv(datos, "./iris.csv", row.names = FALSE)
      
      # Mostrar nuevo dataset
      head(datos)
    }
  })
}

shinyApp(ui, server)
