server <- function(input, output, session) {
  pos <- 0L

  # Returns a hex color string, e.g. "#FF0073"
  nextColor <- function() {
    # Choose the next color, wrapping around to the start if necessary
    pos <<- (pos %% length(colors)) + 1L
    colors[[pos]]
  }

  
  observe({
    # Send the next color to the browser
    session$sendCustomMessage("background-color", nextColor())

    # Update the color every 100 milliseconds
    invalidateLater(1000)
  })
}
