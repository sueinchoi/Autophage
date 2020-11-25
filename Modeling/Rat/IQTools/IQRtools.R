library(IQRtools)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
model <- IQRsysModel(model = "Rat_simple.cpp",
                     dosing = IQRdosing(TIME = 0, ADM = 1, AMT = 1))
sysModel <- sim_IQRsysModel(model, simtime = 1:24, FLAGoutputsOnly = FALSE)
plot_IQRsysModel(sysModel)
pars <- getPars_IQRsysModel(sysModel)
pars
sysModel <- setPars_IQRsysModel(model, CL = 20)   # Paramter  changes !!
sysModel <- sim_IQRsysModel(sysModel, 1:24, FLAGoutputsOnly = TRUE)
plot_IQRsysModel(sysModel)

plot_IQRsysModel(sim_IQRsysModel(sysModel,   # changed only for simulation
                                 1:24,
                               parameters = c(CL = 10),
                             FLAGoutputsOnly = TRUE))

mspec <- modelSpec_IQRsysEst(
  POPvalues0 = c(
    CL = 20,
    V2 = 100
  ),
  LOCmodel = list(
    Q = c("Qlow", "Qhigh")
  ),
  LOCvalues0 = list(
    Q = c(Qlow = 20, Qhigh = 200)
  ),
  LOCestimate = list(
    Q = c(Qlow = 0, Qhigh = 0)
  )
)

sysModel <- IQRsysModel(
  model = "Mouse_simple.cpp",
  modelSpec=mspec,
  dosing = IQRdosing(TIME = 0, ADM = 1, AMT = 1)
)

getPars_IQRsysModel(sysModel)
plot_IQRsysModel(sim_IQRsysModel(sysModel,
                simtime = 1:24,
                parameters = c(Q_Qlow = 10)), FLAGerror = FALSE)
getPars_IQRsysModel(sysModel, "CL", "Q")
dataSys <- import_IQRsysData("Rat_plasma_raw.csv")
write.csv(dataSys, "Rat_plasma_sys.csv")
file.edit("Rat_simple.cpp")
library(tidyverse)
data <- read_csv("Rat_plasma_sys.csv")
head(data)
data <- data %>%
  filter(ROUTE == 2)
sysModel <- IQRsysModel("Rat_simple.cpp",
                         data = list(datafile = data))
sysModel <- sim_IQRsysModel(sysModel)
plot_IQRsysModel(sysModel)

sysModel <- setPars_IQRsysModel(sysModel,
                                error_ADD1 = 0.1)
sysModel <- sim_IQRsysModel(sysModel, simtime = 1: 24)
plot(sysModel)

est <- as_IQRsysEst(
  sysModel,
  modelSpec = list(
    POPvalues0= c(
      CL = 4,
      V2 = 10,
      V3 = 10,
      Q = 10,
      KA = 3,
      FP = 1,
      Tlag1 = 0.2
    ),
    POPestimate= c(
      CL = 1,
      V2 = 1,
      V3 = 1,
      Q = 1,
      KA = 0,
      FP = 0,
      Tlag1 = 0
    ),
    errorModel = list(
      OUTPUT1 = c(type = "absrel", 0.001, 1.5)
    )
  )
)

proj <- IQRsysProject(est, "RUN3_ivonly", opt.nfits = 24, opt.sd = 4)
sysModel <- run_IQRsysProject(proj, ncores = 8)
plotPars_IQRsysModel(sysModel)
plotWaterfall_IQRsysModel(sysModel)
plotPred_IQRsysModel(sysModel)
plotDVPRED_IQRsysModel(sysModel)
