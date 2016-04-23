library(shiny)
library(ggplot2)
library(dplyr)

## Load the data
mpg <- mtcars$mpg
am <- mtcars$am
mycars <- cbind(am,mtcars[,c(2:8,10,11)])
mycars <- mutate(mycars,am=as.factor(am),cyl=as.factor(cyl),vs=as.factor(vs),
                 gear=as.factor(gear),carb=as.factor(carb))
## make the linear regression model
mymodel <- lm(mpg~cyl+disp+hp+wt,data=mycars)

## the reactive function to make the prediction
milespergallon <- function(mycyl,mydisp,myhp,mywt,predmodel){
    indata <- data.frame(cyl=as.factor(mycyl), disp=as.numeric(mydisp), hp=as.numeric(myhp), wt=as.numeric(mywt))
    predict(predmodel,newdata=indata)
}

function(input, output) {
    ## Mirror the input
    output$outcyl <- renderPrint({input$incyl})
    output$outdisp <- renderPrint({input$indisp})
    output$outhp <- renderPrint({input$inhp})
    output$outwt <- renderPrint({input$inwt})
    ## Make the prediction for the output
    output$outprediction <- renderPrint({milespergallon(input$incyl,
                                                        input$indisp,
                                                        input$inhp,
                                                        input$inwt,
                                                        mymodel)})
    
    
}
