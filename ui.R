library(shiny)
shinyUI(pageWithSidebar(
    headerPanel('Predict the MPG consumption of car based on 10 parameters'),
    sidebarPanel(
        h3('Instructions'),
        p('Enter each parameter for your car (hp, cyl, wt, disp, drat, qsec, vs, am, gear and carb).  The predicted MPG will be shown to the right.'),
        h3('Please enter predictors of MPG below.'),
        numericInput('hp', 'Gross horsepower:', 140, min = 50, max = 330, step = 10), # example of numeric input
        radioButtons('cyl', 'Number of cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'), # example of radio button input
        numericInput('wt', 'Weight (lbs):', 3200, min = 1500, max = 5500, step = 100),
		numericInput('disp', 'Displacement (cu.in.):', 200, min = 70, max = 480, step = 10), 
		numericInput('drat', 'Rear axle ratio:', 3.6, min = 2.5, max = 5, step = 0.1), 
		numericInput('qsec', '1/4 mile time (sec):', 18, min = 14, max = 23, step = 0.5), 
		radioButtons('vs', 'V/S:', c('1' = 1, '0' = 0), selected = '1'), 
		radioButtons('am', 'Type of transmission:', c('manual' = 1, 'automatic' = 0), selected = 'automatic'), 
		radioButtons('gear', 'Number of forward gears:', c('3' = 3, '4' = 4, '5'=5), selected = '5'),
		radioButtons('carb', 'Number of carburators:', c('1' = 1, '2' = 2,'3' = 3, '4' = 4, '5'=5, '6' = 6, '7' = 7, '8'=8), selected = '4')
    ),
    mainPanel(
        h6('Course Project by Stephane MASSON'),
        h3('Predicted MPG'),
        h4('You entered:'),
        verbatimTextOutput("inputValues"),
        h4('Which resulted in a prediction of:'),
        verbatimTextOutput("prediction"),
        h4('MPG relative to cars in mtcars data set'),
        plotOutput('plots'),
        h3('Data'),
        p('The data that have been used in order to estimate the MPG consumption is the mtcars R dataset, released by Henderson and Velleman (1981) in "Building multiple regression models interactively. Biometrics, 37, 391–411".'),
        h3('Model'),
        p('A linear model is fitted to the dataset, modeling the effect of every parameters on the mpg.'),
		h3('Rules'),	
		p('1. Since the number of cylinders, V/S, type of transmissions, number of gears and number of carburators in the dataset are categorical variables the choice of possible values is limited using radio buttons.'),
        p('2. For the weight, reactive() is used to convert the user input weight into the units used by the model, lb/1000.'),
        p('3. Finally, a pre-set function using the linear model is used to predict the mpg based on the variables input by the user.')        
    )
))