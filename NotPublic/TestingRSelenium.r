# We first have to download and configure docker:
# https://callumgwtaylor.github.io/blog/2018/02/01/using-rselenium-and-docker-to-webscrape-in-r-using-the-who-snake-database/

# installing packages
if ("RSelenium" %in% installed.packages() != TRUE) {
  install.packages("RSelenium")
}

# attaching package
library(RSelenium)

# opening new docker container from system (Beware: kills already running container)
check <- system2("docker", args = "ps", stdout = TRUE)

if (length(check) == 1) {

  #start new container
  system2("docker", args = c("run", "-d", "-p", "4445:4444", "selenium/standalone-chrome"))

} else {

  # kill old container
  DockerName <- trimws(strsplit(check[2],"tcp")[[1]][2])
  system2("docker", args = c("kill",DockerName))

  # start new container
  system2("docker", args = c("run", "-d", "-p", "4445:4444", "selenium/standalone-chrome"))

}

# Assigning google chrome docker session
remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost",
                                 port = 4445L,
                                 browserName = "chrome")

# Waiting for 5 seconds to finish initialization of docker session
Sys.sleep(5)

# Open remote connection
remDr$open()

# Navigate to website
remDr$navigate("https://www.youtube.com/watch?v=4PqdqWWSHJY")

# take screenshot
remDr$screenshot(display = TRUE)

# saving Screenshot
remDr$screenshot(file = 'Images/RSeleniumScreenshot.png')

# Xpath of "show more" button (using inspect element in Browser)
xp <- '//*[@id="more"]/yt-formatted-string'

# navigating to button element
element <- remDr$findElement(using = 'xpath', xp)

# click on button
element$clickElement()

# take screenshot (we can see that the description box is now expanded)
remDr$screenshot(display = TRUE, useViewer = TRUE)

#save Screenshot
remDr$screenshot(file = 'Images/RSeleniumScreenshot2.png')

#navigating to description element
xp2 <- '//*[@id="description"]/yt-formatted-string'
element2 <- remDr$findElement(using = 'xpath', xp2)

# get element text
unlist(element2$getElementText())