# IQRsysProject generated with IQRtools
# 
# ==PROJECT HEADER START===================================================
# COMMENT             = ''
# TOOL                = 'IQRtools SYSFIT'
# TOOLVERSION         = '1.3.2'
# FILE                = 'project_sysfit.R'
# METHOD              = 'trust-region'
# DATA                = './Plasma_inidividual4_sys.csv'
# DOSINGTYPES         = 'BOLUS'
# COVNAMES            = ''
# CATNAMES            = ''
# REGRESSIONNAMES     = ''
# OUTPUTS             = 'Cc'
# ERRORMODELS         = 'abs'
# ERRORNAMES          = 'error_ADD1'
# PARAMNAMES          = 'GUT,CENT,PERI,TIME1_1,TINF1_1,AMT1_1,KA,Q,V2,V3,CL,INPUT1,Tlag1'
# PARAMTRANS          = '(phi),(phi),(phi),(phi),(phi),(phi),exp(phi),exp(phi),exp(phi),exp(phi),exp(phi),(phi),(phi)'
# PARAMINVTRANS       = '(psi),(psi),(psi),(psi),(psi),(psi),log(psi),log(psi),log(psi),log(psi),log(psi),(psi),(psi)'
# LOCPARAMNAMES       = ''
# LOCPARAMTRANS       = ''
# LOCPARAMINVTRANS    = ''
# LOCPARAMESTIMATE    = ''
# COVARIATENAMES      = ''
# COVARIATESUSED      = ''
# BETACOVNAMES        = ''
# BETACOVTRANS        = ''
# BETACATNAMES        = ''
# BETACATREFERENCE    = ''
# BETACATCATEGORIES   = ''
# THETANAMES          = 'GUT,CENT,PERI,TIME1_1,TINF1_1,AMT1_1,KA,Q,V2,V3,CL,INPUT1,Tlag1,error_ADD1'
# THETAESTIMATE       = '0,0,0,0,0,0,1,1,1,1,1,0,0,1'
# ETANAMES            = 'omega(GUT),omega(CENT),omega(PERI),omega(TIME1_1),omega(TINF1_1),omega(AMT1_1),omega(KA),omega(Q),omega(V2),omega(V3),omega(CL),omega(INPUT1),omega(Tlag1)'
# ETAESTIMATE         = '0,0,0,0,0,0,0,0,0,0,0,0,0'
# CORRELATIONNAMES    = ''
# CORRESTIMATE        = ''
# NROBSERVATIONS      = '344'
# NRPARAM_ESTIMATED   = '6'
# RESIDUAL_NAMES_USED = 'XPRED,XRES,XWRES'
# RESIDUAL_NAMES_ORIG = 'XPRED,XRES,XWRES'
# ==PROJECT HEADER END=====================================================

# ----------------------------------------
# 1. 0. Libraries ---- 
# ----------------------------------------
suppressMessages(require("IQRtools",quietly=TRUE,character.only = TRUE))
suppressMessages(require("dMod",quietly=TRUE,character.only = TRUE))
suppressMessages(require("deSolve",quietly=TRUE,character.only = TRUE))
# ----------------------------------------
# 1. Read in est-object 
# ----------------------------------------
est <- readRDS("project.est")
# ----------------------------------------
# 2. Convert nlmeEst object to dMod format ---- 
# ----------------------------------------
mymodel <- dMod_nlmeEst2dModFrame(est = est,
 SIMOPT.method = "lsodes",
 SIMOPT.atol = 1e-06,
 SIMOPT.rtol = 1e-06,
 SIMOPT.hmin = 0,
 SIMOPT.hini = 0,
 SIMOPT.maxsteps = 5000,
 SIMOPT.nauxtimes = 0,
 SIMOPT.cores = 1,
 opt.method = "trust",
 opt.nfits = 24,
 opt.sd = 1,
 opt.rinit = 1,
 opt.rmax = 10,
 opt.iterlim = 100,
 opt.prior_sigma = 10,
 algOpt.SEED = 123456)
saveRDS(mymodel, "project_model.sysfit")
# ----------------------------------------
# 3. Run computations ---- 
# ----------------------------------------
# Set default values for project if the project script is sourced outside of run_IQRsysProject()
if (!exists("ncores")) ncores <- 1
if (!exists("FLAGrequireConverged")) FLAGrequireConverged <- TRUE
setwd("RESULTSORIG")
modelname(mymodel$obj[[1]]) <- file.path(tempdirIQR(), modelname(mymodel$obj[[1]]))
mymodel <- dMod_sysProject_computations(mymodel,
  ncores = ncores,
  FLAGkeepFits = FALSE,
  FLAGchecks = TRUE,
  FLAGrequireConverged = FLAGrequireConverged,
  FLAGprofileLL = FALSE)
saveRDS(mymodel, file = "project_result.sysfit")
suppressWarnings(detach("package:dMod", unload=TRUE, character.only = TRUE))
suppressWarnings(detach("package:cOde", unload=TRUE, character.only = TRUE))
suppressWarnings(detach("package:deSolve", unload=TRUE, character.only = TRUE))






