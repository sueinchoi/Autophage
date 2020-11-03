library(tidyverse)
library(plotly)
library(zoo)

getwd()
setwd(paste0(getwd(), "/Modeling/Monkey"))

raw <- read.csv('Monkey_raw.csv', header = T, stringsAsFactors = F)
head(raw)
length(unique(raw$ID))
raw %>%
    rename(BQL = BLQ) %>%
    mutate(TYPE = ifelse(BQL == 0, 1, 2), MDV = ifelse(BQL == 1, 0, MDV), DV = ifelse(BQL == 1, 0.1, DV)) %>%
    full_join(WT) %>%
    as.data.frame() %>%
    filter(!(ROUTE == 2 & TIME == 0 &MDV == 0)) %>%
    mutate(DV = ifelse(MDV == 0 & TIME == 0, 0, DV))

a <- read.csv('Monkey_plasma_dual.csv', header = T, stringsAsFactors = F)
head(a)

ID <- 1:21
WT2 <- c(2.32, 2.32, 2.18, 2.38, 2.44, 2.18, 2.38, 2.44, 2.19, 2.35, 2.62, 2.15, 2.23, 2.58, 2.27, 2.15, 2.49, 2.08, 2.32, 2.18, 2.46)
WT <- data.frame(ID = ID, WT = WT2)
mean(WT[3:length(WT)])

a %>%
    filter(!(ROUTE == 2 & TIME == 0 & MDV == 0)) %>%
    mutate(DV = ifelse(MDV == 0 & TIME == 0, 0, DV)) %>%
    rename(BQL = BLQ) %>%
    mutate(TYPE = ifelse(BQL == 0, 1, 2), MDV = ifelse(BQL == 1, 0, MDV), DV = ifelse(BQL == 1, 0.5, DV)) %>%
    left_join(WT, by = 'ID') %>%
    mutate(AMT2 = AMT, AMT = as.numeric(AMT2) * WT) %>%
    write.csv('Monkey_plasma_dual_m3.csv', row.names = F, na = ".")

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

?geom_smooth