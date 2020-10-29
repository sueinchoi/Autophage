library(tidyverse)
library(PKPDmisc)
library(plotly)
if(!require(readxl)) install.packages('readxl'); library(readxl)
if(!require(NonCompart)) install.packages('NonCompart'); library(NonCompart)
if(!require(textclean)) install.packages('textclean'); library(textclean)

raw <- read_excel('PKTK_dataset_201015.xlsx', sheet = 1)

Clean_raw <- raw %>%
  mutate_at(vars(ID : II), function(x)ifelse(x == '.', NA, x) %>% as.numeric)

names(Clean_raw) <- names(Clean_raw)  %>%
  strip(lower.case = FALSE)  %>%
  word(1) %>%
  toupper

Revised_data <- Clean_raw %>%
  mutate(II = ifelse(ADDL == 0, NA, II), AMT = 1000 * AMT, TAD = TIME, TIME = ifelse(MULTIPLE == 2, TIME + 24*27, TIME))  %>%
  filter(!(TIME == 24*27 & MDV == 0)) %>%
  mutate(TIME = ifelse(MULTIPLE == 2 & TIME == 648, 0, TIME)) %>%
  arrange(SPECIES, ID, TIME, AMT) %>%
  filter(!(SPECIES == 3 & TIME == 0 & ADDL == 0)) %>%
  mutate(BLQ = ifelse(TIME != 0 & MDV == 1, 1, 0)) %>%
  split(.$SPECIES) %>%
  map(function(set){
    LivID <- set %>%
      filter(CMT == 3) %>% 
      distinct(ID) %>% 
      unlist()
    set %>%
      mutate(LIV = ifelse(ID %in% LivID, 1, 0))
  })

names(Revised_data) <- c("Mouse", "Rat", "Dog", "Monkey")


MonkeyNA1 <- Revised_data[[4]] %>%
  filter(LIV == 0) %>%
  group_by(ID) %>%
  slice(n()) %>%
  ungroup() %>%
  filter(TIME < 12) %>%
  mutate(TIME = 12, DV = NA, MDV = 1, BLQ = 1) %>%
  rbind(Revised_data[[4]]) %>%
  arrange(ID, TIME, AMT)

  
Revised_data[[4]] <- MonkeyNA1 %>%
  filter(LIV == 0) %>%
  group_by(ID) %>%
  slice(n()) %>%
  ungroup() %>%
  filter(TIME < 24) %>%
  mutate(TIME = 24, DV = NA, MDV = 1, BLQ = 1) %>%
  rbind(MonkeyNA1) %>%
  arrange(ID, TIME, AMT)

# Total raw type dataset

Revised_data %>%
  names(.) %>%
  map(~write.csv(Revised_data[[.]], paste0("Modeling/", ., "/", ., "_raw.csv"), row.names = F, na = "."))

write.csv(do.call(rbind, Revised_data), "PKTK_dataset_20201029.csv", row.names = F, na = ".")


# Plasma dataset

Save_data3<- Revised_data %>%
  map(~.x %>% filter(LIV==0)) 

Save_data3 %>%
  names(.) %>%
  map(~write.csv(Save_data3[[.]], paste0("Modeling/", ., "/", ., "_plasma.csv"), row.names = F, na = "."))

  
# Zero-order

Zero_data <- Save_data3 %>%
  map(~.x %>% mutate(RATE = ifelse(CMT == 1, -2, 0), CMT = 1) %>% mutate(RATE = ifelse(is.na(AMT), NA, RATE)))


Zero_data %>%
  names(.) %>%
  map(~write.csv(Zero_data[[.]], paste0("Modeling/", ., "/", ., "_plasma_zero.csv"), row.names = F, na = "."))

# Dual absorption

Dual_data <- Save_data3 %>%
  map(~.x %>%
        filter(!is.na(AMT) & CMT == 1) %>%
        mutate(CMT = 2, RATE = -2) %>%
        rbind(.x %>% mutate(RATE = 0)) %>%
        arrange(ID, TIME, AMT, CMT) %>%
        mutate(RATE = ifelse(is.na(AMT), NA, RATE)))

Dual_data %>%
  names(.) %>%
  map(~write.csv(Dual_data[[.]], paste0("Modeling/", ., "/", ., "_plasma_dual.csv"), row.names = F, na = "."))

# Liver-analysis (CMT1 = GUT, CMT2 = Liver, CMT3 = Plasma)

Total_data <- Revised_data %>%
  map(~.x %>%
        mutate(CMT2 = case_when(CMT == 3 ~ 2,
                                CMT == 2 ~ 3,
                                TRUE ~ CMT), CMT = CMT2))
Total_data %>%
  names(.) %>%
  map(~write.csv(Total_data[[.]], paste0("Modeling/", ., "/", ., "_total.csv"), row.names = F, na = "."))

