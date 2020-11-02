library(tidyverse)
library(PKPDmisc)
library(plotly)
if(!require(readxl)) install.packages('readxl'); library(readxl)
if(!require(NonCompart)) install.packages('NonCompart'); library(NonCompart)
if(!require(textclean)) install.packages('textclean'); library(textclean)
install.packages('RColorBrewer')
library(RColorBrewer)
getwd()
raw <- read.csv("PKTK_dataset_20201029.csv", stringsAsFactors = F, header = T)
Clean_raw <- raw %>%
  mutate_at(vars(ID : II), function(x)ifelse(x == '.', NA, x) %>% as.numeric)

Clean_raw <- Clean_raw %>%
  mutate_at(vars(ID, SPECIES : FORMULATION), as.factor) %>%
  mutate(SEX = factor(SEX, levels = c(1, 2), labels = c("M", "F")), ROUTE = factor(ROUTE, levels = c(1, 2), labels = c('PO', 'IV')))

## Analysis per species

Clean_animal <- Clean_raw %>%
  split(.$SPECIES)
names(Clean_animal) <- c('Mouse', 'Rat', 'Dog', 'Monkey')
Clean_animal <- map(1:4, function(i){
  Clean_animal[[i]] %>% mutate(name = names(Clean_animal)[i])})

# Number of animals
Clean_animal %>%
  map(function(x){x %>% filter(TIME == 0, MDV == 1) %>% group_by(DOSE, ROUTE) %>% summarise(n = n())})


# NCA & DOSE Linearity
data_NCA <- map(Clean_animal, function(set){
  PO <- set %>%
    filter(MDV == 0, LIV == 0, MULTIPLE == 1, ROUTE == 'PO')  %>%
    as.data.frame()  %>%
    mutate(DOSE = as.numeric(as.character(DOSE))) %>%
    mutate(DV = ifelse(is.na(AMT) & MDV == 1, 0.1, DV))

  IV <- set %>%
    filter(MDV == 0, LIV == 0, MULTIPLE == 1, ROUTE == 'IV')  %>%
    as.data.frame() %>%
    mutate(DOSE = as.numeric(as.character(DOSE))) %>%
    mutate(DV = ifelse(is.na(AMT) & MDV == 1, 0.1, DV))
  
  if(length(PO$DV) == 0){
     PO
    } else {
     DM <- PO %>% group_by(ID) %>% slice(1) %>% ungroup()
     NCA_indiv <- tblNCA(PO, key = c("ID", "DOSE", "SEX", "MULTIPLE", "ROUTE", "FORMULATION"), colTime = "TIME", colConc = "DV", dose = DM$DOSE, adm = "Extravascular", dur = 0, concUnit = 'ng/mL', doseUnit = "mg", timeUnit = "h", down = "Linear", R2ADJ = -0.9) %>%
        mutate_at(vars(LAMZHL, CLFO, VZFO), function(x) ifelse(.$R2 < 0.2, NA, x)) %>%
        select(ID, DOSE, SEX, MULTIPLE, ROUTE, FORMULATION, CMAX, AUCLST, TMAX, LAMZHL, CLFO, VZFO) 
     NCA_mean <- NCA_indiv %>%
        group_by(DOSE, SEX) %>%
        summarise_at(vars(CMAX : VZFO), mean, na.rm = T) %>%
        mutate(AUCdose = AUCLST / DOSE) %>%
        ungroup() %>%
        rbind(NCA_indiv %>%
        group_by(DOSE) %>%
        summarise_at(vars(CMAX : VZFO), mean, na.rm = T) %>%
        mutate(AUCdose = AUCLST / DOSE, SEX = as.factor("both")) %>%
        ungroup() %>%
        select(DOSE, SEX, everything())) %>%
        arrange(DOSE)
     NCA_mean %>%
        ggplot(aes(x = DOSE, y = AUCdose)) +
        geom_line() +
        geom_point() +
        theme_bw() +
        facet_wrap(~SEX)
      ggsave(paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_PO_AUCdose.png"), device = "png")
      write.csv(NCA_indiv, paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_PO_NCAindiv.csv"))
      
      if(length(IV$DV) == 0){
        IV
      } else {
        DM <- IV %>% group_by(ID) %>% slice(1) %>% ungroup()
        NCA_indiv2 <- tblNCA(IV, key = c("ID", "DOSE", "SEX", "MULTIPLE", "ROUTE", "FORMULATION"), colTime = "TIME", colConc = "DV", dose = DM$DOSE, adm = "Bolus", dur = 0, concUnit = 'ng/mL', doseUnit = "mg", timeUnit = "h", down = "Linear", R2ADJ = -0.9) %>%
          mutate_at(vars(LAMZHL, CLO, VZO), function(x) ifelse(.$R2 < 0.2, NA, x)) %>% 
          select(ID, DOSE, SEX, MULTIPLE, ROUTE, FORMULATION, CMAX, AUCLST, TMAX, LAMZHL, CLO, VZO)
        NCA_mean2 <- NCA_indiv2 %>%
          group_by(DOSE, SEX) %>%
          summarise_at(vars(CMAX : VZO), mean, na.rm = T) %>%
          mutate(AUCdose = AUCLST / DOSE) %>%
          ungroup() %>%
          rbind(NCA_indiv2 %>%
                  group_by(DOSE) %>%
                  summarise_at(vars(CMAX : VZO), mean, na.rm = T) %>%
                  mutate(AUCdose = AUCLST / DOSE, SEX = as.factor("both")) %>%
                  ungroup() %>%
                  select(DOSE, SEX, everything())) %>%
          arrange(DOSE)
        write.csv(NCA_indiv2, paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_IV_NCAindiv.csv"))
        write.csv(NCA_mean2, paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_IV_NCAmean.csv"))
        
        NCA_mean <- NCA_mean %>%
          mutate(BIO = AUCdose / unique(NCA_mean2$AUCdose) * 100)
        write.csv(NCA_mean, paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_PO_NCAmean.csv"))
      }
      write.csv(NCA_mean, paste0("Data_Exploration/", unique(set$name), "/NCA/",unique(set$name), "_PO_NCAmean.csv"))
      }

    
    
})

# Individual figures
figure_dose <- map(Clean_animal, function(set){

  PO <- set %>% filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'PO')
  IV <- set %>% filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'IV')
  LPO <- set %>% filter(MDV == 0, CMT == 3, MULTIPLE == 1, ROUTE == 'PO')
  LIV <- set %>% filter(MDV == 0, CMT == 3, MULTIPLE == 1, ROUTE == 'IV')

  if(length(PO$DV) == 0){
      PO
    } else {
    p1 <- ggplot(data = PO, aes(x = TIME, y = DV, col = ID)) +
      geom_line() +
      geom_point(alpha = 0.5, size = 0.8) +
      facet_grid(SEX ~ DOSE, scale = "free") +
      theme_bw() +
      theme(legend.position = "none")
    p1
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_PO_freey.png"), device = "png", width = 8, height = 4)
    p1 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_PO_freey_log10.png"), device = "png", width = 8, height = 4)
    }

  if(length(IV$DV) == 0){
      IV
    } else {
    p2 <- ggplot(data = IV, aes(x = TIME, y = DV, col = ID)) +
      geom_line() +
      geom_point(alpha = 0.5, size = 0.8) +
      facet_grid(SEX ~ DOSE, scale = "free_y") +
      theme_bw() +
      theme(legend.position = "none")
    p2
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_IV_freey.png"), device = "png")
    p2 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_IV_freey_log10.png"), device = "png")
    }

  if(length(LPO$DV) == 0){
      LPO
    } else {
    p3 <- ggplot(data = LPO, aes(x = TIME, y = DV, col = ID)) +
      geom_line() +
      geom_point(alpha = 0.5, size = 0.8) +
      facet_grid(SEX ~ DOSE, scale = "free") +
      theme_bw() +
      theme(legend.position = "none")
    p3
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_PO_liver.png"), device = "png")
    p3 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_PO_liver_log10.png"), device = "png")
    }

  if(length(LIV$DV) == 0){
       LIV
     } else {
     p4 <- ggplot(data = LIV, aes(x = TIME, y = DV, col = ID)) +
       geom_line() +
       geom_point(alpha = 0.5, size = 0.8) +
       facet_grid(SEX ~ DOSE, scale = "free_y") +
       theme_bw() +
       theme(legend.position = "none")
     p4
     ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_IV_liver.png"), device = "png")
     p4 + scale_y_continuous(trans = 'log10')
     ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_IV_liver_log10.png"), device = "png")
    }
})

Clean_animal %>%
  map(function(set){
    Mean_data <- set %>%
      filter(MDV == 0) %>%
      group_by(DOSE, TIME, CMT, MULTIPLE, ROUTE) %>%
      summarise(mean = mean(DV, na.rm = T), sd = sd(DV, na.rm = T)) %>%
      arrange(ROUTE, CMT, MULTIPLE, DOSE, TIME)
    p1<- Mean_data %>%
      filter(CMT == 2, MULTIPLE == 1) %>%
      ggplot() +
      geom_line(aes(x = TIME, y = mean)) +
      geom_point(aes(x = TIME, y = mean)) +
      geom_errorbar(aes(x = TIME, ymax = mean + sd, ymin = mean - sd), alpha = 0.5) +
      theme_bw() +
      facet_grid(ROUTE ~ DOSE, scale = "free_y")
    p1
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/", unique(set$name), "_POIV_mean.png"), device = "png", width = 8, height = 4)
    p1 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/", unique(set$name), "_POIV_mean_log10.png"), device = "png", width = 8, height = 4)
    p2 <- Mean_data %>%
      filter(CMT == 3, MULTIPLE == 1) %>%
      ggplot() +
      geom_line(aes(x = TIME, y = mean)) +
      geom_point(aes(x = TIME, y = mean)) +
      geom_errorbar(aes(x = TIME, ymax = mean + sd, ymin = mean - sd), alpha = 0.5) +
      theme_bw()
      if(unique(set$name) %in% c("Dog", "Monkey")){
         p3 <- p2 + ggtitle(unique(Mean_data[Mean_data$CMT == 3,]$ROUTE))
       } else {
         p3 <- p2 + facet_grid(ROUTE ~ DOSE)
       }
    p3
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/", unique(set$name), "_POIV_mean_liver.png"), device = "png" )
    p3 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/", unique(set$name), "_POIV_mean_liver_log10.png"), device = "png" )
  })

figure_dose <- map(Clean_animal, function(set){

  PO <- set %>% filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'PO')
  IV <- set %>% filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'IV')
  LPO <- set %>% filter(MDV == 0, CMT == 3, MULTIPLE == 1, ROUTE == 'PO')
  LIV <- set %>% filter(MDV == 0, CMT == 3, MULTIPLE == 1, ROUTE == 'IV')

  if(length(PO$DV) == 0){
      PO
    } else {
    p1 <- ggplot(data = PO, aes(x = TIME, y = DV)) +
      geom_line() +
      geom_point() +
      facet_grid(DOSE ~ SEX, scale = "free_y") +
      theme_bw() +
      theme(legend.position = "none")
    p1
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_PO_freey.png"), device = "png")
    p1 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_PO_freey_log10.png"), device = "png")
    }

  if(length(IV$DV) == 0){
      IV
    } else {
    p2 <- ggplot(data = IV, aes(x = TIME, y = DV, col = ID)) +
      geom_line() +
      geom_point() +
      facet_grid(DOSE ~ SEX, scale = "free_y") +
      theme_bw() +
      theme(legend.position = "none")
    p2
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_IV_freey.png"), device = "png")
    p2 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Plasma/",unique(set$name), "_IV_freey_log10.png"), device = "png")
    }

  if(length(LPO$DV) == 0){
      LPO
    } else {
    p3 <- ggplot(data = LPO, aes(x = TIME, y = DV, col = ID)) +
      geom_line() +
      geom_point() +
      facet_grid(DOSE ~ SEX) +
      theme_bw() +
      theme(legend.position = "none")
    p3
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_PO_liver.png"), device = "png")
    p3 + scale_y_continuous(trans = 'log10')
    ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_PO_liver_log10.png"), device = "png")
    }

  if(length(LIV$DV) == 0){
       LIV
     } else {
     p4 <- ggplot(data = LIV, aes(x = TIME, y = DV, col = ID)) +
       geom_line() +
       geom_point() +
       facet_grid(DOSE ~ SEX) +
       theme_bw() +
       theme(legend.position = "none")
     p4
     ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_IV_liver.png"), device = "png")
     p4 + scale_y_continuous(trans = 'log10')
     ggsave(paste0("Data_Exploration/", unique(set$name), "/Liver/",unique(set$name), "_IV_liver_log10.png"), device = "png")
    }
})


## Plotly analysis
install.packages('wesanderson')
library(wesanderson)
names(wes_palettes)


Clean_animal %>%
  map(function(set){
    colourCount <- length(unique(set$ID))
    getPalette = colorRampPalette(brewer.pal(9, "Set1"))
    p1 <- set %>%
     filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'PO') %>%
      ggplot(aes(x = TIME, y = DV, col = as.factor(ID))) +
      scale_colour_manual(values = wes_palette("GrandBudapest1", n = colourCount)) +
      geom_line() +
      geom_point() +
      facet_wrap(~DOSE, scale = 'free_y') +
      scale_y_continuous(trans = 'log10')
    
    p <- ggplotly(p1)
    saveWidget(p, paste0(unique(set$name), "_PO_log.html"), selfcontained = F, libdir = "lib")
  })
p1 <- Clean_animal[[1]] %>%
  filter(MDV == 0, CMT == 2, MULTIPLE == 1, ROUTE == 'PO', DOSE %in% c(10, 125, 250)) %>%
  ggplot(aes(x = TIME, y = DV, col = as.factor(ID))) +
  geom_line() +
  geom_point() +
  facet_wrap(~DOSE, scale = 'free_y') +
  scale_y_continuous(trans = 'log10')+
  scale_color_brewer('ID', palette = "Set1")

p <- ggplotly(p1)
saveWidget(p, 'p1.html', selfcontained = F, libdir = "lib")
p
Mean_data <- Clean_animal[[1]] %>%
    filter(MDV == 0) %>%
    group_by(DOSE, TIME, CMT, MULTIPLE, ROUTE) %>%
    summarise(mean = mean(DV, na.rm = T), sd = sd(DV, na.rm = T)) %>%
    arrange(ROUTE, CMT, MULTIPLE, DOSE, TIME)
p1<- Mean_data %>%
  filter(CMT == 2, MULTIPLE == 1) %>%
  ggplot() +
  geom_line(aes(x = TIME, y = mean)) +
  geom_point(aes(x = TIME, y = mean)) +
  geom_errorbar(aes(x = TIME, ymax = mean + sd, ymin = mean - sd), alpha = 0.5) +
  theme_bw() +
  facet_grid(ROUTE ~ DOSE, scale = "free_y") 
p1
