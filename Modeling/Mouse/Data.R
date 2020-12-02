library(tidyverse)
library(plotly)
library(zoo)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
indiv <- read.csv('Mouse_individual.csv', header = T, stringsAsFactors = F)
head(indiv)
Time <- colnames(indiv)[-c(1,2)]
Time <- parse_number(Time)
Time
head(indiv)
indiv <- indiv %>%
    mutate(SEQ = rep(1:6, 2))
colnames(indiv)[3:length(colnames(indiv))] <- Time
plasma <- indiv[1:6,] %>%
    gather("Time", "DV", -c(CMT, ADM, SEQ)) %>%
    arrange(CMT, ADM, Time) %>%
    mutate(ID = 1:length(.$CMT))
head(plasma)
plasma2<-plasma %>%
    select(-c(CMT, DV))
head(plasma2)
head(liv)
liv <- indiv[7:12, ] %>%
    gather("Time", "DV", -c(CMT, ADM, SEQ)) %>%
    arrange(CMT, ADM, Time)
data <- full_join(plasma2, liv) %>%
    arrange(ID, CMT, Time) %>%
    filter(!is.na(DV)) %>%
    rbind(plasma) %>%
    arrange(ID, Time)

head(data)

liver <- read.csv('Mouse_individual_liver.csv', header = T, stringsAsFactors = F)
head(liver)
Time <- colnames(liver)[-c(1,2)]
Time <- parse_number(Time)
Time
liver <- liver %>%
    mutate(SEQ = rep(1:6, 2))
colnames(liver)[3:length(colnames(liver))] <- Time

plasma <- liver[1:6,] %>%
    gather("Time", "WT", -c(CMT, ADM, SEQ)) %>%
    arrange(CMT, ADM, Time) %>%
    mutate(ID = 1:length(.$CMT))

plasma2<-plasma %>%
    select(-c(CMT))
liv <- liver[7:12, ] %>%
    gather("Time", "LIW", -c(CMT, ADM, SEQ)) %>%
    arrange(CMT, ADM, Time)
data2 <- full_join(plasma2, liv) %>%
    arrange(ID, CMT, Time) %>%
    select(-CMT)
data2$LIW <- na.locf(data2$LIW, fromLast = T)

total <- full_join(data, data2, by = c("ID", "Time", "SEQ", "ADM"))

total <- total %>%
    filter(!is.na(DV)) %>%
    mutate(DV = ifelse(DV == 0, NA, DV), MDV = ifelse(is.na(DV), 1, 0), BLQ = MDV)
DM <- total %>%
    group_by(ID) %>%
    slice(1) %>%
    ungroup()
DM2 <- DM %>%
    mutate(MDV = 1, Time = 0, AMT = 10, CMT = ifelse(ADM == 1, 3, 1), DV = NA)
total2 <- total %>%
    mutate(AMT = NA) %>%
    rbind(DM2) %>%
    arrange(ID, Time, MDV, CMT) %>%
    mutate(ADDL = NA, II = NA, SPECIES = 1, DOSE = 10, FORMULATION = 1, TAD = Time) %>%
    rename(ROUTE = ADM, BQL = BLQ, LVW = LIW, TIME = Time) %>%
    select(ID, TIME, AMT, DV, MDV, CMT, ADDL, II, SPECIES, DOSE, ROUTE, FORMULATION, TAD, BQL, WT, LVW) %>%
    mutate(AMT = AMT * WT * 1000)

head(total2)

write.csv(total2, "Mouse_lowdose_individual.csv", row.names = F, na= ".")



raw <- read.csv('Mouse_total_lowdose.csv', header = T, stringsAsFactors = F)
head(raw)
c(9, 10, 10, 9, 11, 11)
c(5, 5, 5, 5, 5, 5)
c(0.5, 1, 2, 4, 8)

raw %>%
    mutate(ID = as.numeric(as.factor(ID))) %>%
    rename(BQL = BLQ) %>%
    #mutate(TYPE = ifelse(BQL == 0, 1, 2), MDV = ifelse(BQL == 1, 0, MDV), DV = ifelse(BQL == 1, 0.1, DV)) %>%
    left_join(WT) %>%
    as.data.frame() %>%
    filter(!(ROUTE == 2 & TIME == 0 &MDV == 0)) %>%
    mutate(DV = ifelse(MDV == 0 & TIME == 0, 0, DV)) %>%
    mutate(AMT2 = AMT, AMT = as.numeric(AMT2) * WT) %>%
    select(-c(AMT2, CMT2)) %>%
    write.csv('Mouse_total_lowdose.csv', row.names = F, na = ".")


raw %>%

a <- read.csv('Monkey_plasma_dual.csv', header = T, stringsAsFactors = F)
head(a)
unique(a$)
ID <- 1:12
WT2 <- c(28.19, 27.85, 28.50, 28.21, 28.60, 28.03, 27.89, 28.31, 27.74, 28.08, 28.73, 28.69)
LVW <- rep(c(1.54, 1.48, 1.48, 1.43, 1.48, 1.5), 2)
WT <- data.frame(ID = ID, WT = WT2, LVW = LVW)
mean(WT[3:length(WT)])

a %>%
    filter(!(ROUTE == 2 & TIME == 0 & MDV == 0)) %>%
    mutate(DV = ifelse(MDV == 0 & TIME == 0, 0, DV)) %>%
    rename(BQL = BLQ) %>%
    mutate(TYPE = ifelse(BQL == 0, 1, 2), MDV = ifelse(BQL == 1, 0, MDV), DV = ifelse(BQL == 1, 0.5, DV)) %>%
    left_join(WT, by = 'ID') %>%
    mutate(AMT2 = AMT, AMT = as.numeric(AMT2) * WT) %>%

getwd()
setwd(paste0(getwd(), "/Modeling/Monkey/CTL"))
sdtab <- read.table('Modeling/Monkey/CTL/sdtab002', stringsAsFactors = F, header = T, skip =1)
patab <- read.table('patab002', stringsAsFactors = F, header = T, skip =1)
patab %>%
    group_by(ID) %>%
    slice(1)
xpose4()
library(xpose4)
head(sdtab)
head(sdtab, 30)
sdtab %>%
    filter(ID == 1)
p1 <- sdtab %>%
    filter(MDV == 0, TIME != 0, BQL == 0) %>%
    ggplot(aes(x = DV, y = PRED, col = ID)) +
    geom_point() +
    geom_smooth() +
    geom_abline(intercept = 0, slope = 1)

p2 <- sdtab %>%
    filter(MDV == 0, TIME != 0, BQL == 0) %>%
    ggplot(aes(x = IPRED, y = IWRES, col = ID)) +
    geom_point() +
    stat_smooth(span = 1) +
    geom_abline(intercept = 0, slope = 0)
ggplotly(p2)
ggplotly(p1)
xpose4()
patab %>%
    group_by(ID) %>%
    slice(1)


### 2020_11_01 iv 10mpk, po 10mpk, po 25mpk  ###

library(fs)
library(EnvStats)
library(pastecs)

exp <- read_csv(csv_files[4], na = ".")
data <- read_csv('Data2020_11_05.csv', na = ".")
# exp[exp == '.'] <- NA

time <- data$TIME
time <- time[!is.na(time)]
time <- rep(time, each = 3)
data$TIME <- time
data2 <- data %>%
    mutate(ID = 67:(66 + nrow(.)), AMT = NA, DOSE = na.locf(DOSE), ROUTE = na.locf(ROUTE), MDV = 0, CMT = 3, ADDL = NA, II = NA, SPECIES = 1, FORMULATION = 1, TAD = TIME, BQL = ifelse(is.na(DV), 1, 0), WT = 28, LVW = 1.4)
data2 %>%
    bind_rows(data2 %>%
        mutate(TIME = 0, DV = NA, MDV = 1, CMT = ifelse(ROUTE == 2, 3, 1), AMT = WT * DOSE * 1000)) %>%
    select(colnames(exp)) %>%
    bind_rows(exp) %>%
    arrange(ID, TIME, MDV) %>%
    write.csv("Plasma_individual.csv", row.names = F, na = ".")data2[1,]
data[is.na(data)] <- 1

new <- read_csv('Modeling/Mouse/Plasma_individual.csv', na = ".")
colnames(new)
firstrow <- new %>%
  filter(ROUTE == 2) %>%
  group_by(ID) %>%
  slice(1)

head(firstrow)

add1 <- firstrow  %>%
  mutate(AMT = NA, DV = 0, MDV = 0, CMT = 3) %>%
  bind_rows(new) %>%
  arrange(ID, TIME, desc(AMT))

liverrow <- new %>%
  filter(CMT == 2) %>%
  group_by(ID) %>%
  slice(1)
add2 <- liverrow %>%
  mutate(AMT = NA, DV = 0, TIME = 0, MDV = 0, CMT = 2) %>%
  bind_rows(add1) %>%
  arrange(ID, TIME, desc(AMT))

write.csv(add2, "Modeling/Mouse/Plasma_individual2.csv", row.names = F, na = ".")



#### 2020_11_19 50mpk data ####
library(tidyverse)
library(zoo)


csv_files <- fs::dir_ls('Modeling/Mouse', regexp = "\\.csv$")
prevdataname <- csv_files[length(csv_files)-5]

prevdata <- read_csv(prevdataname, na = ".")
prevdata1 <- prevdata %>%
    filter(!(DOSE == 50 & CMT == 2))
prevdata1 %>%
    filter(DOSE == 50, CMT == 2)
data <- read_csv('Modeling/Mouse/Data2020_12_01.csv', na = ".")
# exp[exp == '.'] <- NA
time <- data$TIME
time <- time[!is.na(time)]
time
time <- rep(time, 4)
data$TIME <- time
nrow(data)
data
ID = rep(160:(159 + 112/2), 2)
ID
data2 <- data %>%
    mutate(ID = rep(160:(159 + nrow(.))), AMT = NA, DOSE = na.locf(DOSE), ROUTE = na.locf(ROUTE), MDV = 0, CMT = na.locf(CMT), ADDL = NA, II = NA, SPECIES = 1, FORMULATION = 1, TAD = TIME, BQL = ifelse(is.na(DV), 1, 0), WT = 28, LVW = 1.4)
data2
prevdata1 %>%
 filter(DOSE == 50, CMT == 2)
data2 %>%
    bind_rows(data2 %>%
        mutate(TIME = 0, DV = NA, MDV = 1, CMT = ifelse(ROUTE == 2, 1, 3), AMT = WT * DOSE * 1000) %>%
        slice(seq(0.5*n()))) %>%
    select(colnames(prevdata1)) %>%
    bind_rows(data2 %>%
      filter(CMT == 2) %>%
      group_by(ID) %>%
      slice(1)  %>%
      ungroup() %>% 
      mutate(AMT = NA, DV = 0, TIME = 0, MDV = 0, CMT = 2)) %>%
    arrange(ID, TIME, desc(MDV), CMT) %>%
    bind_rows(prevdata1) %>%
    arrange(ID, TIME, desc(MDV), CMT) %>%
    write.csv("Modeling/Mouse/Plasma_individual20201201.csv", row.names = F, na = ".")

#### NCA

library(NonCompart)
datatidy <- data %>%
    group_by(TIME) %>%
    summarise(mean = mean(DV), med = median(DV)) %>%
    ungroup() %>%
    gather('Parameter', 'DV', -c("TIME")) %>%
    as.data.frame()

tblNCA(datatidy, key = "Parameter", colTime = "TIME", colConc = "DV", dose = 50, adm = "Extravascular", dur = 0, R2ADJ = -10)

data %>%
  gather("Dose", "DV", -c("M", "Time")) %>%
  mutate(dose = parse_number(Dose)) %>%
  as.data.frame() %>%
  split(.$dose) %>%
  map(~tblNCA(.x, key = c("M", "Dose"), colTime = "Time", colConc = "DV", dose = unique(.$dose), adm = "Extravascular", dur = 0, R2ADJ = -10) %>%
        arrange(M)) 

####  Data exploration
new <- read_csv('Modeling/Mouse/Plasma_individual3.csv', na = ".")
colnames(new)
firstrow <- new %>%
  filter(ROUTE == 2) %>%
  group_by(ID) %>%
  slice(1)

head(firstrow)

add1 <- firstrow  %>%
  mutate(AMT = NA, DV = 0, MDV = 0, CMT = 3) %>%
  bind_rows(new) %>%
  arrange(ID, TIME, desc(AMT))

liverrow <- new %>%
  filter(CMT == 2) %>%
  group_by(ID) %>%
  slice(1)
add2 <- liverrow %>%
  mutate(AMT = NA, DV = 0, TIME = 0, MDV = 0, CMT = 2) %>%
  bind_rows(add1) %>%
  arrange(ID, TIME, desc(AMT))

write.csv(add2, "Modeling/Mouse/Plasma_individual2.csv", row.names = F, na = ".")
