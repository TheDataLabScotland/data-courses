msc.courses <- read.csv("./www/msc_courses.csv", check.names=FALSE)
bsc.courses <- read.csv("./www/bsc_courses.csv", check.names=FALSE)
scholar <- read.csv("./www/scholarships.csv", check.names=FALSE)

# Create a list of the taught languages on all courses
## Found in format as a comma seperated list, so is split
## and duplicates removed
language.list <- sort(c(unique(unlist(strsplit(
  as.character(msc.courses$"Programming Languages Taught"),
  split=", ")))))

scholarLinks <- msc.courses$"Scholarships Available"

j <- strsplit(
  as.character(msc.courses$"Scholarships Available"),
  split=", ")

# Replace list of available scholarships with hyperlinked versions
library(plyr)
e <- as.character(scholar$"Scholarship Name")
d <- as.character(scholar$"HTML Format Link")
urlList <- function(x) {
  return(mapvalues(unlist(x), e, d, warn_missing = FALSE))
}
reComma <- function(x) {
  return(paste(x, collapse = ',\n \n '))
}

k <- lapply(lapply(j, urlList), reComma)
msc.courses$Sc.Links <- k

# Replace all £ signs with Unicode version
scholar$`Amount Given` <- gsub("£", "\U00A3", scholar$`Amount Given`)
