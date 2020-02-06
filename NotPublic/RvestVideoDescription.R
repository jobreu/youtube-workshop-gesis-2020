library(rvest)
library(magrittr)
url <- "https://www.youtube.com/watch?v=4PqdqWWSHJY"
url %>%
  read_html %>%
  html_nodes(xpath = "//*[@id = 'eow-description']") %>%
  html_text