#' ---
#' title: "Untitled"
#' author: "JJayes"
#' date: "16/11/2021"
#' output: html_document
#' ---
#' 
## ----setup, include=FALSE----------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)

library(tidyverse)
library(rvest)

# run this before export to github actions
# knitr::purl("code/stockholm_archive_scraper.Rmd", documentation = 2)

#' 
#' ## Purpose
#' 
#' Start with ingesting the data from the website.
#' 
#' ### Robots.txt
#' 
## ----------------------------------------------------------------------------------------------------------
# library(robotstxt)
# get_robotstxt("https://stadsarkivet.stockholm/")

#' 
#' There's nothing here, so we can proceed.
#' 
#' ### Trying for mantalsregister 1909
#' 
#' Want to get the table with the first elements - function
#' 
## ----------------------------------------------------------------------------------------------------------
# url <- "https://sok.stadsarkivet.stockholm.se/Databas/mantalsregister-1909/Sok?sidindex=20"

get_table_data <- function(url) {
  html <- read_html(url)
  
  message(paste0("Getting data from", url))
  
  table <- html %>%
    html_node(".table") %>%
    html_table()

  table <- table %>%
    janitor::clean_names() %>%
    filter(between(row_number(), 4, 13))

  table <- table %>%
    rename(
      file = x1,
      surname = x2,
      first_name = x3,
      born = x4,
      title = x5,
      address = x6,
      mantal_number = x7,
      other = x8
    ) %>%
    select(1:8)
  
  # sleep a little between each request
  # Sys.sleep(rnorm(1, 2, .2))
  
  table
}

# test
# get_table_data("https://sok.stadsarkivet.stockholm.se/Databas/mantalsregister-1909/Sok?sidindex=30")


#' 
#' List of all the links
#' 
## ----------------------------------------------------------------------------------------------------------
start_page <- 0
n_pages <- 11679

list_of_pages <- tibble(url = paste0("https://sok.stadsarkivet.stockholm.se/Databas/mantalsregister-1909/Sok?sidindex=",
                                     start_page:n_pages),
                        # make a page number just in case we want to check back later
                        # store it just as a number as this is small for file size sake.
                        page = start_page:n_pages)

#' 
#' purrr::map takes our url and applies the function to it methodically.
#' 
## ----------------------------------------------------------------------------------------------------------
df <- list_of_pages %>% 
  head(3) %>%
  mutate(data = map(url, possibly(get_table_data, "failed"))) %>% 
  # we don't have to keep the url as it provides no more information than page.
  select(!url)

#' 
#' Save data!
#' 
## ----------------------------------------------------------------------------------------------------------
df %>% write_rds("data/df.rds", compress = "gz")

#' 
