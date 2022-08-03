ui <- fluidPage(
  tags$head(
    # Listen for background-color messages
    tags$script("
      Shiny.addCustomMessageHandler('background-color', function(color) {
        document.body.style.backgroundColor = color;
        document.body.innerText = color;
      });
    "),
    
    # A little CSS never hurt anyone
    tags$style("body { font-size: 40pt; text-align: center; }")
  )
)
