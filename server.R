library(shiny)
data(mtcars)

modelFit <- lm(mpg ~ hp + cyl + wt + disp + drat + qsec + vs + am + gear + carb, data=mtcars)

mpg <- function(hp, cyl, wt, disp, drat, qsec, vs, am, gear, carb) {
    modelFit$coefficients[1] + modelFit$coefficients[2] * hp + 
        modelFit$coefficients[3] * cyl + modelFit$coefficients[4] * wt + modelFit$coefficients[5] * disp +
		modelFit$coefficients[6] * drat + modelFit$coefficients[7] * qsec + modelFit$coefficients[8] * vs +
		modelFit$coefficients[9] * am + modelFit$coefficients[10] * gear + modelFit$coefficients[11] * carb
}

shinyServer(
    function(input, output) {
        adjusted_weight <- reactive({input$wt/1000})
		predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adjusted_weight(), 
		as.numeric(input$disp), 
		as.numeric(input$drat), 
		as.numeric(input$qsec), 
		as.numeric(input$vs),
		as.numeric(input$am), 
		as.numeric(input$gear), 
		as.numeric(input$carb))})
        output$inputValues <- renderPrint({paste(input$cyl, "cylinders, ",
                                                 input$hp, "horsepower, ",
                                                 input$wt, "lbs, ",
												 input$disp, "cubic inches displacement, ",
												 input$drat,"Rear axle ratio, ",
												 input$qsec,"seconds in quarter mile, ",
												 input$vs,"V/S, " ,
												 "Type of transmission (0 = automatic, 1 = manual=): ", input$am, ", ",
												 input$gear," forward gears, ",
												 input$carb," carburators")})
        output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), "miles per gallon")})
        output$plots <- renderPlot({
            par(mfrow = c(3, 4))
            # (1, 1)
            with(mtcars, plot(hp, mpg,
                              xlab='Gross horsepower',
                              ylab='MPG',
                              main='MPG vs horsepower'))
            points(input$hp, predicted_mpg(), col='red', cex=3)                 
            # (1, 2)
            with(mtcars, plot(cyl, mpg,
                              xlab='Number of cylinders',
                              ylab='MPG',
                              main='MPG vs cylinders'))
            points(as.numeric(input$cyl), predicted_mpg(), col='red', cex=3)  
            # (1, 3)
            with(mtcars, plot(wt, mpg,
                              xlab='Weight (lb/1000)',
                              ylab='MPG',
                              main='MPG vs weight'))
            points(adjusted_weight(), predicted_mpg(), col='red', cex=3)  
			 # (2, 1)
            with(mtcars, plot(disp, mpg,
                              xlab='disp',
                              ylab='MPG',
                              main='MPG vs Displacement (cu.in.)'))
            points(as.numeric(input$disp), predicted_mpg(), col='red', cex=3)  
			 # (2, 2)
            with(mtcars, plot(drat, mpg,
                              xlab='drat',
                              ylab='MPG',
                              main='MPG vs Rear axle ratio'))
            points(as.numeric(input$drat), predicted_mpg(), col='red', cex=3)  
			 # (2, 3)
            with(mtcars, plot(qsec, mpg,
                              xlab='qsec',
                              ylab='MPG',
                              main='MPG vs 1/4 mile time (sec)'))
            points(as.numeric(input$qsec), predicted_mpg(), col='red', cex=3)  
			 # (3, 1)
            with(mtcars, plot(vs, mpg,
                              xlab='vs',
                              ylab='MPG',
                              main='MPG vs V/S'))
            points(as.numeric(input$vs), predicted_mpg(), col='red', cex=3) 
			 # (3, 2)
            with(mtcars, plot(am, mpg,
                              xlab='am',
                              ylab='MPG',
                              main='MPG vs transmission type'))
            points(as.numeric(input$am), predicted_mpg(), col='red', cex=3)  			  
			 # (3, 3)
            with(mtcars, plot(gear, mpg,
                              xlab='gear',
                              ylab='MPG',
                              main='MPG vs number of forward gears'))
            points(as.numeric(input$gear), predicted_mpg(), col='red', cex=3)  
			 # (4, 1)
            with(mtcars, plot(carb, mpg,
                              xlab='carb',
                              ylab='MPG',
                              main='MPG vs number of carburators'))
            points(as.numeric(input$carb), predicted_mpg(), col='red', cex=3)  
        })
    }
)