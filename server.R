library(shiny)
library(DT)
require(plyr)
require(dplyr)
source("./tags.R")

shinyServer(function(input, output, session) {
  
  # Output the MSc courses data table
  ## Javascript code to set title bar colour
  output$msc.coursesTable <- DT::renderDataTable(
    DT::datatable(m.courseData(), rownames= FALSE,
                  options = list(paging = FALSE,
                                               initComplete = JS(
                                                 "function(settings, json) {",
                                                 "$(this.api().table().header()).css({'background-color': '#3bc5bd', 'color': '#fff'});",
                                                 "}")),
                  escape = FALSE)
  )
  
  # Output the BSc courses data table
  output$bsc.coursesTable <- DT::renderDataTable(
    DT::datatable(b.courseData(), rownames= FALSE,
                  options = list(paging = FALSE,
                                 initComplete = JS(
                                   "function(settings, json) {",
                                   "$(this.api().table().header()).css({'background-color': '#f4ba07', 'color': '#fff'});",
                                   "}")),
                  escape = FALSE)
  )

  # Output the scholarship data table
  output$schol <- DT::renderDataTable(
    DT::datatable(scholarData(), rownames= FALSE,
                  options = list(paging = FALSE,
                                 initComplete = JS(
                                   "function(settings, json) {",
                                   "$(this.api().table().header()).css({'background-color': '#f40071', 'color': '#fff'});",
                                   "}")),
                  escape = FALSE))

  
  # Filter the courses based on the language checkboxes
  ## A regular expression is used to filter
  m.courseData <- reactive({
    scholarLinks <- msc.courses$"Scholarships Available"
    
    df <- data.frame(
      "Course Title" = msc.courses$"HTML Format Link", 
      University = msc.courses$University,
      Prerequisites = msc.courses$"Degree Required",
      "Minimum Entry Requirements" = msc.courses$"Minimum Entry Requirements",
      "Industry Placement" = msc.courses$"Industry Placement",
      "Tools Taught" = msc.courses$"Programming Languages Taught",
      "Data Lab MSc" = msc.courses$"Data Lab MSc",
      "Core Modules Taught" = msc.courses$"Core Modules Taught",
      check.names=FALSE
    )
    df$Scholarships <- msc.courses$Sc.Links
    # Turn the chosen checkbox vector into a regex readable format
    ## The +'s in C++ cause a problem in the regex, so it is replaced with an escaped version
    selections <- replace(input$languages, input$languages=="C++", "C\\+\\+")
    selections <- paste(selections, collapse = '|')
    
    
    # This selects courses in the data frame who offer the selected languages
    ## grep returns the row numbers
    df <- df[grep(paste0("(^|, )(",
                               selections,
                               ")(,|$)"),
                  df$"Tools Taught"),]
  })
  
  b.courseData <- reactive({
    #scholarLinks <- courses$"Scholarships Available"
    
    df <- data.frame(
      "Course Title"=bsc.courses$`URL`,
      "University"=bsc.courses$University,
      "Duration (full-time)"=bsc.courses$`Duration (full-time)`,
      "Minimum Entry Requirements"=bsc.courses$`Minimum Entry Requirements`,
      "Prerequisite Highers"=bsc.courses$`Prerequisite Highers`,
      "Data Science Elements"=bsc.courses$`Data Science Elements`,
      "Industry Placement"=bsc.courses$`Industry Placement`,
      "Online Only"=bsc.courses$`Online only`,
      "Other"=bsc.courses$Other,
      check.names=FALSE
    )
  })
  
  # Filter the scholarships based on the course checkboxes
  scholarData <- reactive({
    df <- data.frame(
      "Scholarship Name"=scholar$"HTML Format Link",
      University=scholar$University,
      "Amount Given (£)"=scholar$"Amount Given",
      Eligibility=scholar$Eligibility,
      check.names=FALSE
    )
  })    
  # MScs: Change Language checkboxes on button press
  ## Seperate observe's for each button, since unified versions caused problems
  observe({
    if (input$clear.tools) {
        updateCheckboxGroupInput(
          session, "languages", choices = language.list,
          selected = "None described"
        )
    } 
  })
  observe({
    if (input$all.tools) {
      updateCheckboxGroupInput(
        session, "languages", choices = language.list,
        selected = language.list
      )
    }
  })
              
})