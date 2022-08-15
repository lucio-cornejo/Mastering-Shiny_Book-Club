# Ejecutar antes de publicar la aplicación
# googlesheets4::gs4_auth(
#   email = "luciocornejo11@gmail.com", 
#   cache = ".secrets"
# )

# En RStudio, cambiar de directorio antes de correr la app

library(shiny)
library(googlesheets4)

googlesheets4::gs4_auth(
  cache = ".secrets", 
  email = "luciocornejo11@gmail.com"
)

# Link de la base de datos
url <- "https://docs.google.com/spreadsheets/d/18ahz7Js6V3gwcO1R4T-8jLCVxQoSQs2uAiARnfhfgSM/"

ui <- fluidPage(
  tableOutput("iris"),
  actionButton("actualizar", label = "Insertar una fila de ejemplo al dataset")
)

server <- function(input, output) {
  output$iris <- renderTable({
    if (input$actualizar > 0) {
      # Leer dataset actual
      datos <- googlesheets4::read_sheet(url)

      # Crear fila por añadir al dataset
      temp <- data.frame(
        Sepal.Length = 0,
        Sepal.Width = 0,
        Petal.Length = 0,
        Petal.Width = 0,
        Species = "setosa"
      )
      # Guardar nuevo dataset
      googlesheets4::sheet_append(url, temp)
      # Mostrar nuevo dataset
      tail(googlesheets4::read_sheet(url))
    }
  })
}

shinyApp(ui, server)
