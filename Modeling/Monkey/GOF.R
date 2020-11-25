library(xpose4)
library(devtools)
install_version("xpose4", version = "4.6.1", repos = "http://cran.us.r-project.org")
xpose4()
getwd()
table <- read.table('sdtab2_14.txt', skip = 1, header = T)
head(table)
table %>%
  filter(MDV == 0) %>%
  ggplot(aes(x = IPRED, y = DV, label = as.factor(ID))) +
  #geom_point() +
  stat_smooth(span = 0.2) +
  geom_abline(intercept = 0, slope = 1) +
  geom_text(aes(label = as.factor(ID)))

table %>%
  filter(MDV == 0, BQL != 1) %>%
  ggplot(aes(x = IPRED, y = IWRES, label = as.factor(ID))) +
  #geom_point() +
  geom_smooth(span = 0.1) +
  geom_text(aes(label = as.factor(ID)))

table %>%
  filter(ID %in% c(6, 8))
