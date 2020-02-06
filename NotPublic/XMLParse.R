# Script for getting a Video description with Webscraping using Rvest

# installing packages
if ("rvest" %in% installed.packages() != TRUE) {
  install.packages("rvest")
}

# attaching packages
library(rvest)

# defining website
page <- "https://www.youtube.com/watch?v=4PqdqWWSHJY"

# setting Xpath (go to the website, rightclick on it, select "inspect" if you are using chrome,
# In the new window, you can now hover over the html elements to see which one corresponds to the decsription,
# right-click on the element you are interested in and select "copy Xpath")
Xp <- '/html/body/div[2]/div[4]/div/div[5]/div[2]/div[2]/div/div[2]/meta[2]'

# getting page
Website <- read_html(page)

# getting node containing the description
Description <- html_nodes(Website, xpath = Xp)

# printing description
html_attr(Description, name = "content")

########################## RSELENIUM SOLUTION


# We first have to configure docker and open an docker container:
# https://callumgwtaylor.github.io/blog/2018/02/01/using-rselenium-and-docker-to-webscrape-in-r-using-the-who-snake-database/

# installing packages
if ("RSelenium" %in% installed.packages() != TRUE) {
  install.packages("RSelenium")
}

# attaching packages
library(RSelenium)

# Assigning google chrome docker session
remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")
# Open remote connection
remDr$open()

# Navigate to website
remDr$navigate("https://www.youtube.com/watch?v=4PqdqWWSHJY")

# take screenshot
remDr$screenshot(display = TRUE)

# Xpath of "show more" button
xp <- '//*[@id="more"]/yt-formatted-string'

# navigating to button element
element <- remDr$findElement(using = 'xpath', xp)

# click on button
element$clickElement()

# take screenshot (we can see that the description box is now expanded)
remDr$screenshot(display = TRUE, useViewer = TRUE)

# navigating to description element
xp2 <- '//*[@id="description"]/yt-formatted-string'
element2 <- remDr$findElement(using = 'xpath', xp2)

# get element text
unlist(element2$getElementText())


