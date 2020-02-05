# Function to replace Emoji in the comments

ReplaceEmoji <- function(x) {

  # install packages

  if ("devtools" %in% installed.packages() != TRUE) {
    install.packages("devtools")
  }
  if ("qdabRegex" %in% installed.packages() != TRUE) {
    install.packages("qdabRegex")
  }
  if ("emo" %in% installed.packages() != TRUE) {
    devtools::install_github("hadley/emo")
  }

  # attach packages
  library(qdapRegex)
  library(emo)

  # source helper functions
  source("CamelCase.R")

  # import emoji list
  EmoticonList <- jis

  ListedEmojis <- as.list(jis[,4])
  CamelCaseEmojis <- lapply(jis$name, simpleCap)
  CollapsedEmojis <- lapply(CamelCaseEmojis, function(x){gsub(" ", "", x, fixed = TRUE)})
  EmoticonList[,4]$name <- unlist(CollapsedEmojis)

  # order the list by the length of the string to avoid partial matching of shorter strings
  EmoticonList <- EmoticonList[rev(order(nchar(jis$emoji))),]

  # assign x to a new variable so we can save the progress in the for-loop (see below)
  New <- x

  # rm_default throws a useless warning on each iteration that we can ignore
  oldw <- getOption("warn")
  options(warn = -1)

  # cycle through the list and replace everything
  # we have to add clean = FALSE and trim = FALSE to avoid deleting whitespaces that are part of the pattern

  for (i in 1:dim(EmoticonList)[1]){

    New <- rm_default(New, pattern=EmoticonList[i,3],replacement= paste0("EMOJI_", EmoticonList[i,4]$name, " "), fixed = TRUE, clean = FALSE, trim = FALSE)

  }

  # turn warning messages back on
  options(warn = oldw)

  # output result
  return(New)

}