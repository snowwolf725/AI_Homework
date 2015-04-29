library(shiny)

calDistence <- function(point1, point2) {
  dist <- sqrt((point1$x - point2$x)^2 + (point1$y - point2$y)^2)
  return(dist)
}

calCenterPoint <- function(dataPoints) {
  avg <- data.frame(x= integer(1), y= integer(1))
  avg$x <- sum(dataPoints$x) / length(dataPoints$x)
  avg$x <- as.integer(avg$x)
  avg$y <- sum(dataPoints$y) / length(dataPoints$y)
  avg$y <- as.integer(avg$y)
  return(avg)
}

shinyServer(
  function(input, output) {
    output$myPlot <- renderPlot({
      inFileA <- input$fileA
      inFileB <- input$fileB
      inFileC <- input$fileC
      if (is.null(inFileA) && is.null(inFileB) && is.null(inFileC))
        return(NULL)
      if(is.null(inFileA) == F) {
        setA <- read.csv(inFileA$datapath, header=F, sep=",")
        names(setA) <- c("x", "y")
        plot(setA$x, setA$y, pch=16, col="green")
      }
      if(is.null(inFileB) == F) {
        setB <- read.csv(inFileB$datapath, header=F, sep=",")
        names(setB) <- c("x", "y")
        points(setB$x, setB$y, pch=12, col="red")
      }
      if(is.null(inFileC) == F) {
        setC <- read.csv(inFileC$datapath, header=F, sep=",")
        names(setC) <- c("x", "y")
        points(setC$x, setC$y, pch=6, col="blue")
      }
    })
    output$resultPlot <- renderPlot({
      if (is.null(setA) || is.null(setB) || is.null(setC))
        return(NULL)
      avgA <- calCenterPoint(setA)
      avgB <- calCenterPoint(setB)
      
      for(i in 1:nrow(setC)) {
        pointC <- setC[i,]
        distA <- calDistence(avgA, pointC)
        distB <- calDistence(avgB, pointC)
        if(distA <= distB) {
          setA[nrow(setA) + 1,] <- setC[i,]
        } else {
          setB[nrow(setB) + 1,] <- setC[i,]
        }
      }
      
      plot(setA$x, setA$y, pch=16, col="green")
      points(setB$x, setB$y, pch=11, col="red") 
    })
  }
)