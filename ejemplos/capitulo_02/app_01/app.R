library(shiny)

# :::::::::::::::::
# Texto libre
# :::::::::::::::::
ui <- fluidPage(
  textInput("ejemplo1", "¿Cómo te llamas?"),
  passwordInput("ejemplo2", "¿Cuál es tu contraseña?"),
  textAreaInput("ejemplo3", "Cuéntame sobre ti ...", rows = 3),

  verbatimTextOutput("seleccion")
)

# :::::::::::::::::
# Inputs numéricos
# :::::::::::::::::
ui <- fluidPage(
  numericInput("ejemplo1", "Número uno", value = 0, min = 0, max = 100),
  sliderInput("ejemplo2", "Número dos", value = 50, min = 0, max = 100),
  sliderInput("ejemplo3", "Rango", value = c(10, 20), min = 0, max = 100),

  verbatimTextOutput("seleccion")
)

# :::::::::::::::::
# Fechas
# :::::::::::::::::
ui <- fluidPage(
  # Adquiere una fecha
  dateInput("ejemplo1", "¿Cuándo naciste?"),
  # Adquiere un rango de fechas
  dateRangeInput("ejemplo2", "¿Cuándo son tus vacaciones?"),

  verbatimTextOutput("seleccion")
)

# :::::::::::::::::
# Lista de opciones
# :::::::::::::::::
animales <- c("Perro", "Gato", "Ratón", "Odio a los animales")

ui <- fluidPage(
  selectInput("ejemplo1", "¿Cuál es tu estado favorito de EEUU?", state.name),
  selectInput(
    "ejemplo2", "¿Cuál es tu estado favorito de EEUU?", 
    state.name, multiple = TRUE
  ),
  
  radioButtons("ejemplo3", "¿Cuál es tu animal favorito?", animales),

  checkboxGroupInput("ejemplo4", "¿Qué animales no odias?", animales),
  checkboxInput("ejemplo5", "¿Se entiende?", value = TRUE),
  checkboxInput("ejemplo6", "¿Muchos ejemplos ya?"),

  verbatimTextOutput("seleccion")
)

# :::::::::::::::::
# Botones de acción
# :::::::::::::::::
ui <- fluidPage(
  fluidRow(
    actionButton("ejemplo1", "¡Presiona aquí!", class = "btn-success"),
    actionLink("ejemplo2", "¿Aguita?", icon = icon("cocktail"))
  ),
  fluidRow(
    actionButton(
      "ejemplo3", class = c("btn-danger", "btn-block"),
      label = "¡¡ERES NUESTRO VISITANTE 1.000.000!!"
    )
  ), 
  verbatimTextOutput("seleccion")
)

server <- function(input, output, session) {
  output$seleccion <- renderPrint({
    input$ejemplo1
  })
}

shinyApp(ui, server)
