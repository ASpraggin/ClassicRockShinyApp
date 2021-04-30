library(shiny)

shinyUI(fillPage(

    # Application title
    titlePanel("Final Project: Graphs Visualising the Classic Rock Dataset"),
        
    tabsetPanel(
        tabPanel('Graph of Songs by Year',sidebarLayout(
                sidebarPanel(sliderInput("songYear","Year:",min=1955,max=2014,value=c(1973,1988))),
                mainPanel(plotOutput("yearGraph"))
        )),
        tabPanel('Graph of Songs by Popularity', sidebarLayout(
                sidebarPanel(sliderInput("playCount","Plays:",min=100,max=142,value=100)),
                mainPanel(plotOutput("popGraph"))
        )),
        tabPanel('Most Popular Artists', sidebarLayout(
                sidebarPanel(sliderInput("songCount","Songs:",min=10,max=100,value=10)),
                mainPanel(plotOutput("artistGraph"))
        )),
        tabPanel('Data',DT::dataTableOutput("csvHead"))
    )
))