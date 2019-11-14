# Script for getting a Video description with Webscraping using Rvest

# installing packages
if ("rvest" %in% installed.packages() != TRUE) {
  install.packages("rvest")
}

# attaching packages
library(rvest)

# defining website
page <- "https://www.youtube.com/watch?v=4PqdqWWSHJY"

# setting Xpath
Xp <- '/html/body/div[2]/div[4]/div/div[5]/div[2]/div[2]/div/div[2]/meta[2]'

# getting page
Website <- read_html(page)

# getting node containing the description
Description <- html_nodes(Website, xpath = Xp)

# printing description
html_attr(Description, name = "content")
