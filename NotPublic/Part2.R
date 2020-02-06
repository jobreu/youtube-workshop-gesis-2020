# TEST
---
  # TEST2
  ---

  # TEST3
  ---

  # Screensraping with RSelenium

  - test

```{r eval= TRUE, collapse = FALSE}

# Open remote connection
remDr$open()

# Navigate to website
remDr$navigate("https://www.youtube.com/watch?v=4PqdqWWSHJY")

# take screenshot
remDr$screenshot(display = TRUE)

```
- test

---
  # Screenscraping with RSelenium

  - test

```{r eval= TRUE, collapse = FALSE}

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

```

- test

---
  # Screenscraping with RSelenium

  - test

```{r eval= TRUE, collapse = FALSE}


# navigating to description element
xp2 <- '//*[@id="description"]/yt-formatted-string'
element2 <- remDr$findElement(using = 'xpath', xp2)

# get element text
unlist(element2$getElementText())

```
- test

---
  # API-harvesting

  - An **A**pplication **P**rogramming **I**nterface:
  - system build for developers
- directly communicate with the database
- Voluntary service of the website
- they can dictate what information is accessible, to whom, how, and in which quantities.

![plot](Images/API_harvesting.png)

---
  # API-harvesting

  - APIs can be used to:

  - embed content in other applications
- create Bots that do something automatically
- scheduling/moderation for content creators
- collect data for (market) research purposes


- Not every website has their own API. However, most large Social Media Websites do
- [Facebook](https://developers.facebook.com/docs/graph-api?locale=de_DE)
- [Twitter](https://developer.twitter.com/en/docs/basics/getting-started)
- [Instagram](https://www.instagram.com/developer/)
- [Wikipedia](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API)
- [Google Maps](https://www.programmableweb.com/api/google-maps-places)

---

  # Screenscraping vs. API-harvesting

  - Which way you should use depends on multiple factors, as both of their unique
advantages and disadvantages

---

  # ScreenScraping

  - Advantages of Screenscraping:
  + You can access everything that you are able to access from your browser
+ You are (theoretically) not restricted in how much data you can get
+ (Theoretically) Independent from API-restrictions

- Disadvantages of Screenscraping:
  - Extremely tedious to get information out of HTML-pages (They can't be parsed with
    regex, you need an XML-parser)
  - You have to manually look up the Xpaths/CSS/HTML containers to get specific information
  - Reproducibility: The website might be tailored to stuff in your Cache, Cookies, Accounts etc.
  - There is no guarantee that even pages that look the same have the same underlying HTML structure
  - You have to manually check the website and your data to make sure that you're getting what you want
                                                            - If the website changes anything in their styling, your scripts won't work anymore
  - Legal Gray Area (recent court decision though)

---

# API-harvesting

- Advantages of API-harvesting:
  + No need to interact with HTML files, you only get the information you asked for
  + The data you get is already nicely formatted (usually JSON files)
  + You can be sure that what you do is perfectly legal and in line with ToS

- Disadvantages of API-harvesting:
  - Not every website has an API
  - You can only get what the company allows you to get
  - There are often restricting quotas (querys per day)
  - there is no standard language to make querys, you have to check the documentation
  - Not every API has a documentation

---
- It can be used to:

  - embed content in other applications
  - create Bots that do something automatically
  - scheduling/moderation for content creators
  - collect data for (market) research purposes


- Not every website has
  their own API. However, most large Social Media Websites do
    - [Facebook](https://developers.facebook.com/docs/graph-api?locale=de_DE)
    - [Twitter](https://developer.twitter.com/en/docs/basics/getting-started)
    - [Instagram](https://www.instagram.com/developer/)
    - [Wikipedia](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API)
    - [Google Maps](https://www.programmableweb.com/api/google-maps-places)

---

- What is an [API](https://en.wikipedia.org/wiki/Application_programming_interface)?
    - application Programming Interface. It's a system build for developers
                                                            that allows them to interact with a websites content (upload automatically, embed in other websites,
                                                                                                                  use data, link accounts etc.)
                                                            - Its a service of the website where they can dictate what information is accessible, to whom, how, and and which quantities

                                                            - Both Methods have their adavantages and Disadvantages

                                                            ---

                                                              # How does YouTube work?

                                                              - Important: There are static websites (only change when Users click on sth.) and dynamic websites
                                                            (Content is updated constantly even if users do nothing)

                                                            - Almost all Social Media Websites (Facebook, Twitter, Instagram) are dynamic

                                                            - Dynamic Websites are usually more difficult to interact with

                                                            - Before we can try to get data out of YouTube, it's important to understand
how the website works first.

![plot](Images/YT_draft.png)

---


---
class: inverse, middle, center

# Wat Do?

If you can, use an API, if you must, use Screenscraping instead

---
class: center, middle

# The YouTube API

---

# Overview

- Fortunately, YouTube has their own, well-documented API
  that developers can use to interact with their database (Most Google Services do)

- To find an API for a given website, [Programmable Web](https://www.programmableweb.com) is
  a good starting point

- Some prominent APIs:
  - [Google Maps](https://www.programmableweb.com/api/google-maps-places)
  - [Facebook](https://developers.facebook.com/docs/graph-api?locale=de_DE)
  - [Twitter](https://developer.twitter.com/en/docs/basics/getting-started)
  - [Instagram](https://www.instagram.com/developer/)
  - [Wikipedia](https://de.wikipedia.org/wiki/Wikipedia:Technik/Datenbank/API)

- We will use the [YouTube API](https://developers.google.com/youtube/v3/docs) today

---

# Getting started

- First of all, we need a Google account.
  - You can use an already existing one
  - you can create a new one
  - For safety reasons, we advise you to create a new account
    (If you accidentally share your login credentials, people using the credentials only
     have access to your Bot account and not your personal or work account)
  - You can create a new account [here](https://accounts.google.com/signup/v2/webcreateaccount?service=mail&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ltmpl=googlemail&gmb=exp&biz=false&flowName=GlifWebSignIn&flowEntry=SignUp)

- Second, we need to:
  - Sign up for the Google developer console
  - Create a new Project
  - Activate the YouTube Data API
  - Create Authentification Credentials

---

# Google Developer Console

- Go to the [Developer Console](https://console.developers.google.com) and log in with your (new) Google Account

- Create a new Project by clicking on the "Create" button on the top right Corner

![plot](Images/CreateProject.png)

---

# Let op

- You only have a limited number of Projects that you can create, so be carefull not
  to constantly delete and create new ones

- More information can be found [here](https://support.google.com/cloud/answer/6330231)


---

# Creating a New Project

- Specify a Project Name (you do not have to indicate an organisation) and click on create once you are done

![plot](Images/ProjectName.png)
---

# Activate the YouTube Data v3 API

- click on the button to "Activate APIs"

![plot](Images/ActivateAPI.png)

---

# Activate the YouTube Data and Analytics APIs

- Enter "YouTube" in the search bar, click on the data API and then activate it by clicking on the "Activate" button

![plot](Images/APIs.png)

---

 ![plot](Images/Activate.png)

---


 ![plot](Images/AuthentificationButton.png)


---

 ![plot](Images/UserAgreement.png)

---

 ![plot](Images/CreateOAuth.png)

---

 ![plot](Images/OtherApplication.png)

---
# DONE!
---

# What can we do with these Credentials now?

- We can see what the API allows us to do in the [Google API Explorer](https://developers.google.com/apis-explorer/#p/)

- Basically, you can automate any action and see all data that you
  also would be able to see when logged into YT with your Google account

- Fortunately for us, the YouTube API is very [well documented](https://developers.google.com/youtube/v3/docs/)

---

# Test

---

# Have a slide with an overview of most common parameters and which ones we are going to use

---

# Have a slide explaining what a GET Request it, how to execute it from the terminal and
# how to execute it from R

---




################## UP NEXT




---
# Screensraping with RSelenium

- We can then navigate to the website and print a screenshot

```{r eval= TRUE}

# Open remote connection
remDr$open()

# Navigate to website
remDr$navigate("https://www.youtube.com/watch?v=4PqdqWWSHJY")

# take screenshot
remDr$screenshot(display = TRUE)

```
---
# Screenscraping with RSelenium

 - We can then navigate to the "show more" button, and click it

```{r eval= TRUE, collapse = FALSE}

# Xpath of "show more" button
xp <- '//*[@id="more"]/yt-formatted-string'

# navigating to button element
element <- remDr$findElement(using = 'xpath', xp)

# click on button
element$clickElement()

# take screenshot (we can see that the description box is now expanded)
remDr$screenshot(display = TRUE, useViewer = TRUE)

```
---

# Screenscraping with RSelenium

```{r collapse = TRUE}

#navigating to description element
xp2 <- '//*[@id="description"]/yt-formatted-string'
element2 <- remDr$findElement(using = 'xpath', xp2)

# get element text
unlist(element2$getElementText())

```


########## UP NEXT TRUE






# Screenscraping with ```RSelenium```

```{r}

# We first have to configure docker and open a docker container:
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
```
---

class: center, middle

# API-Harvesting

---
# test
---
# Screenscraping with ```RSelenium```

- We can then navigate to the website and print a screenshot

```{r}

# Open remote connection
remDr$open()

# Navigate to website
remDr$navigate("https://www.youtube.com/watch?v=4PqdqWWSHJY")

# take screenshot
remDr$screenshot(display = TRUE)

```