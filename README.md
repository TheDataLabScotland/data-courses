# Data-Courses

R Shiny Web App, displaying Data Science Courses available in Scotland

A side project of Summer 2016 Interns at [The Data Lab Scotland](http://www.thedatalab.com/)

# Files

+-- www <br />
&ensp; |   +-- bootstrap.css     &ensp;# CSS file for Shiny App theme (modified version of [Cosmo] (http://bootswatch.com/cosmo/)) <br />
&ensp; |   +-- tdl-alpha.png	  &ensp;  # The Data Lab logo <br />
&ensp; |   +-- TDL_logo.html   &ensp;&ensp;  # HTML code for hyperlinked The Data Lab logo <br />
&ensp; |   +-- courses.csv     &ensp;&ensp;&ensp;  # CSV file storing data on courses <br />
&ensp; |   +-- scholarships.csv&ensp;&ensp;  # CSV file storing data on scholarships <br />
+-- dropdownButton.R  # Code for dropdown checkboxes UI element <br />
+-- tags.R  &ensp;&ensp; # Split up tag lists in CSVs, replace some with hyperlinks <br />
+-- server.R &ensp;&ensp; # Shiny Server <br />
+-- ui.R &ensp;&ensp; # Shiny UI <br />
