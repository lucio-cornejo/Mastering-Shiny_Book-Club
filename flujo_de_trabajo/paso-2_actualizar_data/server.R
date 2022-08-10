library(shiny)

temperaturas <- read.csv("data/temperaturas.csv")

server <- function(input, output) {
    observeEvent(input$nuevo_anio, {
      updateSliderInput(inputId = "anio", max = input$nuevo_anio)
    })
  
    data <- eventReactive(input$carga, {
      req(input$carga)
      
      # Extensión del archivo cargado
      ext <- tools::file_ext(input$carga$name)
      if (ext == "csv") {
        datos_cargados <- read.csv(input$carga$datapath)
        nombres_columnas <- c("anio", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "setiembre", "octubre", "noviembre", "diciembre")
        if (colnames(datos_cargados) == nombres_columnas) {
          datos_cargados$anio <- input$nuevo_anio

          # Leer data "temperaturas" actual 
          # (tras posible actualización previa)
          temperaturas <- read.csv("data/temperaturas.csv")

          data_actualizada <- rbind(temperaturas, datos_cargados)
          
          # Eliminar duplicados por año, salvo por la última instancia
          data_actualizada <- data_actualizada[!rev(duplicated(rev(data_actualizada$anio))),]
          
          # Guardar data actualizada
          write.csv(data_actualizada, "data/temperaturas.csv", row.names = FALSE)
          
          data_actualizada
        }
      } else {
        validate("Solo aceptamos archivos de tipo .csv")
      }
    })
  
  temp_anual <- reactive({
    anio <- input$anio
    temperatura_anual <- data()[data()$anio == anio,]
    temperatura_anual <- unlist(temperatura_anual)[-1]
    temperatura_anual
  })

  output$barras <- renderPlot({
    barplot(
      height = temp_anual(), col ="skyblue",
      xlab = "", ylab = "Temperatura promedio",
      main = paste0("Año ", input$anio),
      names = colnames(temp_anual())[-1], las = 2
    )
  })

  output$min_max <- renderPrint({
    mes_max_temperatura <- colnames(data())[1+which.max(temp_anual())]
    mes_min_temperatura <- colnames(data())[1+which.min(temp_anual())]
    print(paste0("Temperatura máxima: ", mes_max_temperatura))
    print(paste0("Temperatura mínima: ", mes_min_temperatura))
  })
}




# nueva_data <- data.frame(
#   anio = 1940,
#   enero = 40,
#   febrero = 41,
#   marzo = 42,
#   abril = 43,
#   mayo = 44,
#   junio = 45,
#   julio = 46,
#   agosto = 47,
#   setiembre = 48,
#   octubre = 49,
#   noviembre = 50,
#   diciembre = 51
# )
# 
# write.csv(nueva_data, "data/nueva_data.csv", row.nomaes = FALSE)
