library(shiny)
library(tidyverse)
library(ggplot2)

data<-readRDS("D:/example/MAT_F.rds")

result <- data[-1]
row.names(result) <- data$시도명
result

vars<-setdiff(names(result), c("인구수","상업수_3월", "상업수_12월", "상업수_4월"))




# Define UI for application that draws a histogram
ui <- fluidPage(
    
    headerPanel("월별 코로나"),
    sidebarPanel(
        selectInput("region", "Region", c("강원도", "경기도", "경상남도", "경상북도", "광주광역시", "대구광역시", "대전광역시","부산광역시", "서울특별시", "세종특별자치시","울산광역시", "인천광역시","전라남도","전라북도","제주특별자치도","충청남도","충청북도"))
    ),
    mainPanel(
        plotOutput('plot1')
    )
    
    
)



server <- function(input, output){
    selectedData <- reactive({
       as.numeric(result[input$region, vars])## 확인해보기
    })
    
    output$plot1 <- renderPlot({
        dat <- data.frame(x = as.vector(vars), y = as.vector(selectedData()))
        barplot(dat$y, names.arg = dat$x, ylab = "코로나수",ylim=c(0,40000),xlab = "월")
        par(new=TRUE)
        plot(dat$y, names.arg = dat$x, ylab = "코로나수",ylim=c(0,40000),xlab = "월",type = 'l', col = 2,axes=F)
    })
}






shinyApp(ui, server)