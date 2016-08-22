library(shiny)
library(DT)
source("./dropdownButton.R")
source("./tags.R")
shinyUI(
  fluidPage(theme = "bootstrap.css",
            title = "Data Science Courses",
    navbarPage(
      title = div(includeHTML("./www/TDL_logo.html"), "Scotland Data Science Courses"),
      tabPanel('MSc',
               fluidRow(
                 column(1,
                        dropdownButton(label = "Tools", status = "default", width = 80,
                                       actionButton("clear.tools", "Clear", icon("close"),
                                                    style="color: #fff; background-color: #e90503; border-color: #e90503"), 

                                       actionButton("all.tools", "All", icon("check-square-o"),
                                                    style="color: #fff; background-color: #389005; border-color: #389005"),
                                       checkboxGroupInput(inputId = "languages",
                                                          label = "Choose",
                                                          choices = language.list,
                                                          selected	= language.list)
                        )
                 )
        
               ),
               DT::dataTableOutput('msc.coursesTable')
      ),
      tabPanel('BSc',
               fluidRow(
                 helpText("NB: Courses may not be purely Data Science related, but will teach skills useful for a future MSc")
               ),
               DT::dataTableOutput('bsc.coursesTable')
      ),
      tabPanel('Scholarships',
               fluidRow(
                 DT::dataTableOutput('schol') 
               )
      )
    )
  )
  
)