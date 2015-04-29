library('ReadImages') 

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

setA <- read.csv("SetA.csv", header=F, sep=",")
setB <- read.csv("SetB.csv", header=F, sep=",")
setC <- read.csv("SetC.csv", header=F, sep=",")
names(setA) <- c("x", "y")
names(setB) <- c("x", "y")
names(setC) <- c("x", "y")

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
