library(tidyverse)
library(plotly)
dat <- read.table (file='Modeling/Mouse/Simple/sdtab1_1.txt', skip=1, header=T)
head(dat)

gof1<- dat %>%
    filter(MDV == 0, ROUTE == 2) %>%
    filter(!(ID %in% c(164, 178))) %>%
    ggplot(aes(x = IPRED, y = DV)) +
    geom_point(aes(x = IPRED, y = DV, col = as.factor(ID), shape = as.factor(DOSE))) +
    stat_smooth(span = 0.7) +
    geom_abline(intercept = 0, slope = 1)
ggplotly(gof1)

gof1<- dat %>%
    filter(MDV == 0, ROUTE == 2) %>%
    filter(!(ID %in% c(164, 178, 175, 156, 205, 191, 177, 176, 192, 139))) %>%
    ggplot(aes(x = TIME, y = CWRES)) +
    geom_point(aes(x = TIME, y = CWRES, col = as.factor(ID), shape = as.factor(DOSE))) +
    stat_smooth(span = 0.7) +
    geom_abline(intercept = 0, slope = 0)
ggplotly(gof1)


dat %>%
    filter(ID == 46)