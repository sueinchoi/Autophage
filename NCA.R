library(tidyverse)
library(PKPDmisc)
library(NonCompart)
library(readxl)
install.packages("textclean")
library(textclean)
raw <- read_excel('PKTK_dataset_201015.xlsx', sheet = 1)
head(raw)

unique(Clean_raw[, 9])
Clean_raw <- raw %>%
  mutate_at(vars(ID : II), function(x)ifelse(x == '.', NA, x))

// Charateristics

# a <- str_replace(names(Clean_raw), "\r\n\\(.*\\)", "")
# a <- str_replace(a, "\\(.*\\)", "")

names(Clean_raw) <- names(Clean_raw)  %>%
  strip(lower.case = FALSE)  %>%
  word(1) %>%
  toupper

Clean_animal <- Clean_raw %>%
  split(.$SPECIES) %>%
  map(function(x){x %>% group_by(ID) %>% slice(1) %>% ungroup()})

Clean_animal %>%
  map(function(x){x %>% group_by(DOSE, ROUTE) %>% summarise(n = n())})
