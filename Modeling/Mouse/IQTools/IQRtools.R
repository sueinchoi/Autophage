library(IQRtools)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
model <- IQRsysModel(model = "Mouse_simple.cpp",
                     dosing = IQRdosing(TIME = 0, ADM = 1, AMT = 1))
sysModel <- sim_IQRsysModel(model, simtime = 1:24, FLAGoutputsOnly = FALSE)
plot_IQRsysModel(sysModel)
pars <- getPars_IQRsysModel(sysModel)

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
dataSys <- import_IQRsysData("Plasma_individual4_iqr.csv")
write.csv(dataSys, "Plasma_individual4_sys.csv")

sysModel <- IQRsysModel("Mouse_simple.cpp",
                         data = list(datafile = "Plasma_inidividual4_sys.csv"))
sysModel <- sim_IQRsysModel(sysModel)
plot_IQRsysModel(sysModel)
