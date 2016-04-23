library(shiny)
library(ggplot2)
library(dplyr)

## load the dataset
mpg <- mtcars$mpg
am <- mtcars$am
mycars <- cbind(am,mtcars[,c(2:8,10,11)])
mycars <- mutate(mycars,am=as.factor(am),cyl=as.factor(cyl),vs=as.factor(vs),
                 gear=as.factor(gear),carb=as.factor(carb))

fluidPage(
    ## Provide information and documentation for the app
    titlePanel("The mileage calculator"),
    h3('Documentation'),
    p('This application will estimate the mileage of a car based on a previously
      developed linear regression model. The regression model takes the number 
      of cylinders, the engine displacement, the gross horsepower and the weight 
      of the car as input and provides an estimate for the mileage (miles per 
      gallon) from these predictors.'),
    p('1. Select the number of cylinfers'),
    p('2. Enter the engine displacement'),
    p('3. Enter the gross horsepower'),
    p('4. Enter the weight of the car (mind the decimal seperator if you enter a number by hand)'),
    p('5. Press "Submit"'),
    
    sidebarPanel(
        ## Collect the input
        h4('1. How many cylinders does the car have?'),
        p('4, 6, or 8 cylinders'),
        selectInput('incyl', 'Cylinders', levels(mycars$cyl)),
        
        h4('2. What is the engine displacement (cubic inches)?'),
        p('A value between 50 and 500'),
        numericInput('indisp', 'Displacement (cu in)', 120, min=50, max=500, step=1),
        
        h4('3. What is the gross horsepower of the car?'),
        p('A value between 40 and 400'),
        numericInput('inhp', 'Horsepower', 100, min=40, max=400, step=1),
        
        h4('4. What is the weight of the car in 1000 lbs?'),
        p('A value between 1.00 and 6.00'),
        p('Please try a different decimal seperator "," or "." if you enter a number and get an error.'),
        numericInput('inwt', 'Weight (1000 lbs)', 2.00, min=1.00, max=6.00, step=0.01),
        
        submitButton('Submit')
    ),
    
    mainPanel(
        ## Repeat the input
        h4('Number of cylinders:'),
        verbatimTextOutput("outcyl"),
        h4('Engine displacement in cubic inches'),
        verbatimTextOutput("outdisp"),
        h4('Gross horsepower'),
        verbatimTextOutput("outhp"),
        h4('Weight in 1000 lbs'),
        verbatimTextOutput("outwt"),
        ## Print the model prediction for the input data
        h3('The estimated mileage in miles per gallon is:'),
        verbatimTextOutput("outprediction")
    )
)
