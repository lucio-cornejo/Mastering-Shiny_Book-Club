# ::::::::::::::::::::::::::::::::::::::::::
# Guardemos la data inicial en Google Sheets
# ::::::::::::::::::::::::::::::::::::::::::
url <- "https://docs.google.com/spreadsheets/d/1F1Uupju6kkJhwALZWMypdlT5b1VWsh3ZHadVQiFdsZ8"

# googlesheets4::sheet_write(
#   read.csv("./temperaturas.csv"),
#   ss = url,
#   sheet = "temperaturas" # Primero cambiar manualmente el nombre de la hoja
# )

# Guardar las credenciales en una carpeta .secrets
# googlesheets4::gs4_auth(
#   cache = ".secrets",
#   email = "luciocornejo11@gmail.com"
# )

# library(shiny)
# library(googlesheets4)

temperaturas <- googlesheets4::read_sheet(url)

# :::::::::::::::::::
# Interfaz de usuario
# :::::::::::::::::::
ui <- fluidPage(
  titlePanel("Temperatura promedio mensual en Nottingham"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("anio", label = "Año", min = 1920, max = 1939, value = 1930),
      fileInput("carga", NULL, buttonLabel = "Cargar archivo .csv", accept = ".csv")
    ),
    mainPanel(
      plotOutput("barras"),
      verbatimTextOutput("min_max")
    )
  )
)

# ::::::::::::::::
# Función servidor
# ::::::::::::::::
server <- function(input, output) {
  data <- eventReactive(input$carga, {
    req(input$carga)

    # Extensión del archivo cargado
    ext <- tools::file_ext(input$carga$name)

    if (ext == "csv") {
      # Cargar data subida por el usuario
      datos_cargados <- read.csv(input$carga$datapath)
      
      # Data actualizada
      data_actualizada <- rbind(
        googlesheets4::read_sheet(url),
        datos_cargados
      )

      # Solo no eliminar las últimas filas con año no duplicado
      data_actualizada <- data_actualizada[!rev(duplicated(rev(data_actualizada$anio))),]

      # Actualizar año máximo en el deslizador
      updateSliderInput(
        inputId = "anio", 
        max = max(data_actualizada$anio)
      )

      # Actualizar data en Google Sheets
      googlesheets4::sheet_write(
        data_actualizada,
        ss = url,
        sheet = "temperaturas" 
      )

      # Devolver la data actualizada
      data_actualizada
    } else {
      validate("Solo aceptamos archivos de tipo .csv")
    }
  })
  
  temp_anual <- eventReactive(input$anio, {
    anio <- input$anio
    temperatura_anual <- data()[data()$anio == anio,]
    temperatura_anual <- unlist(temperatura_anual)[-1]
    temperatura_anual
  })

  output$barras <- renderPlot({
    barplot(
      height = temp_anual(), col = "skyblue", 
      xlab = "", ylab = "Temperatura promedio",
      main = paste0("Año ", input$anio),
      names = names(temp_anual()), las = 2
    )
  })

  output$min_max <- renderPrint({
    mes_max_temperatura <- colnames(data())[1+which.max(temp_anual())]
    mes_min_temperatura <- colnames(data())[1+which.min(temp_anual())]
    print(mes_max_temperatura)
    print(mes_min_temperatura)
  })
}

shinyApp(ui, server)
