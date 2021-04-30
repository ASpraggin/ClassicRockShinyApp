library(shiny)
library (readr)
library(DT)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {
    
    urlfile="https://raw.githubusercontent.com/ASpraggin/classicRockcsvs/master/classic%20rock%20all.csv"
    classicRockCsv<-read_csv(url(urlfile))
    classicRockCsv=classicRockCsv[,-c(5,6,8)]

    output$csvHead<-DT::renderDataTable({classicRockCsv})
    
    classicRockByYear=reactive(filter(classicRockCsv,between(`Release Year`,input$songYear[1],input$songYear[2])))
    output$yearGraph<-renderPlot({hist(classicRockByYear()$`Release Year`,main="Histogram of how many songs were from what years",ylab="Release Year")})
    
    classicRockByPop=reactive(filter(classicRockCsv,PlayCount>=input$playCount))
    shift_trans = function(d = 0) {scales::trans_new("shift", transform = function(x) x - d, inverse = function(x) x + d)} 
    output$popGraph=renderPlot({ggplot(classicRockByPop(),aes(x=classicRockByPop()$`COMBINED`,y=classicRockByPop()$`PlayCount`))+geom_bar(stat = 'identity')+
        theme(axis.text.x = element_text(angle = 90))+scale_y_continuous(trans=shift_trans(100))+xlab("Song Title and Artist")+ylab("Play Count")})
    
    classicRockArtists=classicRockCsv[2]
    classicRockArtists=classicRockArtists%>%count(`ARTIST CLEAN`)
    classicArtists=reactive(filter(classicRockArtists,n>input$songCount))
    output$artistGraph=renderPlot({ggplot(classicArtists(),aes(x=`ARTIST CLEAN`,y=n))+geom_bar(stat='identity')+theme(axis.text.x = element_text(angle = 90))})
})