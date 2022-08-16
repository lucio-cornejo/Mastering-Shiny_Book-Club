# Link asociado a la data por leer
url <- "https://docs.google.com/spreadsheets/d/1jFY04uD5Rp8ZR-_YeCck50bfT5UmY1tJV1xd91G9T6c/"

# Base de datos usada para crear el data frame "temperaturas":
# nottem (Average Monthly Temperatures at Nottingham, 1920-1939)
temperaturas <- googlesheets4::read_sheet(url)

# Fijar un año
# Años posibles (inicialmente): 1920 a 1939
anio <- 1930

# Diagrama de barras
temperatura_anual <- temperaturas[temperaturas$anio == anio,]
temperatura_anual <- unlist(temperatura_anual)[-1]

barplot(
  height = temperatura_anual, col ="skyblue",
  xlab = "", ylab = "Temperatura promedio",
  main = paste0("Año ", anio),
  names = names(temperatura_anual), las = 2
)

# Meses de mínima y máxima temperatura
mes_max_temperatura <- colnames(temperaturas)[1+which.max(temperatura_anual)]
mes_min_temperatura <- colnames(temperaturas)[1+which.min(temperatura_anual)]

mes_max_temperatura
mes_min_temperatura
