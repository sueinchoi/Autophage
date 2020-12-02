library(tidyverse)
library(zoo)
library(readxl)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

data <- map_dfr(1:3, function(i)read_excel("Metabolite.xlsx", sheet = i))

data %>%
  gather("Dose", "DV", -c("M", "Time")) %>%
  mutate(dose = parse_number(Dose)) %>%
  as.data.frame() %>%
  split(.$dose) %>%
  map(~tblNCA(.x, key = c("M", "Dose"), colTime = "Time", colConc = "DV", dose = unique(.$dose), adm = "Extravascular", dur = 0, R2ADJ = -10) %>%
        arrange(M)) 

