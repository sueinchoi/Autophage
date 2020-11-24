library(tidyverse)
library(zoo)
library(plotly)
library(fs)
library(htmlwidgets)


csv_files <- fs::dir_ls('Modeling/Mouse', regexp = "\\.csv$")
data <- read_csv(csv_files[length(csv_files)], na= ".")

head(data)

arranged_data <- data %>%
  filter(DOSE == 50, ROUTE == 2, MDV == 0) %>%
  group_by(TIME, CMT) %>%
  summarise(mean = mean(DV), sd = sd(DV))

cmt.labs <- c("Liver", "Plasma")
names(cmt.labs) <- c("2", "3")
dose50 <- data %>%
  filter(DOSE == 50, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none")

dose50_log <- data %>%
  filter(DOSE == 50, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_y_continuous(trans = 'log10')


p1 <- ggplotly(dose50)
p2 <- ggplotly(dose50_log)

saveWidget(p1, '50mpk.html', selfcontained = F, libdir = "lib")
saveWidget(p2, '50mpk_log.html', selfcontained = F, libdir = "lib")

getwd()



arranged_data <- data %>%
  filter(DOSE == 25, ROUTE == 2, MDV == 0) %>%
  group_by(TIME, CMT) %>%
  summarise(mean = mean(DV), sd = sd(DV))

cmt.labs <- c("Liver", "Plasma")
names(cmt.labs) <- c("2", "3")
dose25 <- data %>%
  filter(DOSE == 25, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none")

dose25_log <- data %>%
  filter(DOSE == 25, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_y_continuous(trans = 'log10')


p1 <- ggplotly(dose25)
p2 <- ggplotly(dose25_log)

saveWidget(p1, '25mpk.html', selfcontained = F, libdir = "lib")
saveWidget(p2, '25mpk_log.html', selfcontained = F, libdir = "lib")

arranged_data <- data %>%
  filter(DOSE == 10, ROUTE == 2, MDV == 0) %>%
  group_by(TIME, CMT) %>%
  summarise(mean = mean(DV), sd = sd(DV))

cmt.labs <- c("Liver", "Plasma")
names(cmt.labs) <- c("2", "3")
dose10 <- data %>%
  filter(DOSE == 10, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none")

dose10_log <- data %>%
  filter(DOSE == 10, ROUTE == 2, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_y_continuous(trans = 'log10')


p1 <- ggplotly(dose10)
p2 <- ggplotly(dose10_log)

saveWidget(p1, '10mpk.html', selfcontained = F, libdir = "lib")
saveWidget(p2, '10mpk_log.html', selfcontained = F, libdir = "lib")



arranged_data <- data %>%
  filter(DOSE == 10, ROUTE == 1, MDV == 0) %>%
  group_by(TIME, CMT) %>%
  summarise(mean = mean(DV), sd = sd(DV))

cmt.labs <- c("Liver", "Plasma")
names(cmt.labs) <- c("2", "3")
dose10_iv <- data %>%
  filter(DOSE == 10, ROUTE == 1, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none")

dose10_log_iv <- data %>%
  filter(DOSE == 10, ROUTE == 1, MDV == 0) %>%
  ggplot() +
  geom_point(aes(x = TIME, y = DV, col = as.factor(ID), alpha = 0.8))+
  geom_point(data = arranged_data, aes(x = TIME, y = mean)) +
  geom_errorbar(data = arranged_data, aes(x = TIME, ymax = mean + sd, ymin = mean), alpha = 0.8) +
  geom_line(data = arranged_data, aes(x = TIME, y = mean), alpha= 0.8) +
  facet_wrap(vars(CMT), scales = "free", labeller = labeller(CMT = cmt.labs)) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_y_continuous(trans=  'log10')
dose10_log_iv

p1 <- ggplotly(dose10_iv)
p2 <- ggplotly(dose10_log_iv)
p2
getwd()
setwd(paste0(getwd(), '/Data_Exploration/Mouse'))
saveWidget(p1, '10mpk_iv.html', selfcontained = F, libdir = "lib")
saveWidget(p2, '10mpk_log_iv.html', selfcontained = F, libdir = "lib")
10
