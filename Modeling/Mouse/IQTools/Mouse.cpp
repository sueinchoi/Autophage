

********** MODEL NAME

Autophage

********** MODEL NOTES

Autophage
1. Possibly biliary excretion
2. 2-comparment model
3. continuous biliary elimination + temporary EHR 

********** MODEL STATES

d/dt(GUT) = - KA*GUT + BILE*GB/Tbil
d/dt(LIV) = KA*GUT - QH*LIV/V2/Kp - CLint*LIV/V2*fu + QH*CENT/V3 - CLbile*LIV/V2
d/dt(CENT) = QH*LIV/V2/Kp - K34*CENT + K43*PERI - QH*CENT/V3
d/dt(PERI) = K34*CENT - K43*PERI
d/dt(GB) = CLbile*LIV/V2 - BILE *GB/Tbil


********** MODEL PARAMETERS
 

WT = 70
Qpv_kg = 1.04
Vpv_kg = 0.015
Qha_kg = 0.37
Qh_kg = 1.41
Vh_kg = 0.034 # (L) hepatic volume
Qvilli_kg = 0.26

kdeg_3a4 = 0.019 # # (/h) degradation rate constant
kdeg_2c8 = 0.08 # # (/h) degradation rate constant
kdeg_3a4_intestine = 0.029 ## (/h) degradation rate constant

DUMMY1 = 0
DUMMY2 = 0
DUMMY3 = 0

# Imatinib

MW_I = 493.6 # # (g/mol) Molecular weight
logP_I = 1.99 # # Octanol/water partition coefficient
pKa_I = 8.07 # #
fup_I = 0.05 # # fraction unbound in plasma
BP_I = 0.732 # # Blood/plasma ratio
FA_I = 1 # # Fraction absorb
FG_I = 0.99
fu_gut_I_1 = 1 # # Based on Qgut model, set fu_gut as 0.05 or 0.1 (=fu_hep) instead of 1 explains the bioavailability more feasibly)
fu_gut_I_fup = 0.05 ## DUMMY3=1
fu_hep_I = 0.05 # # fraction unbound in liver (Dallphin)
Kp_liver_I = 0.6 # # Tissue-to-plasma parition coefficient (0.1 ~ 7 in simcyp)

KA_I = 0.627 # # (/h) Absorption rate constant
Vc_kg_I = 2.73 # # (L/kg) Central volume
Vp_kg_I = 1.72 # # (L/kg) Peripheral volume
Q_kg_I = 0.277 # # (L/h) Intercompartmental clearance

CLint_3a4_N_I = 56 # # (L/h) Intrinsic clearance to N-DMI(CYP3A4)
CLint_3a4_other_I = 151 # # (L/h) Intrinsic clearance to other metabolite (CYP3A4)
CLint_3a5_N_I = 2 # # (L/h) Intrinsic clearance (CYP3A5)
CLint_3a5_other_I = 0.67 # # (L/h) Intrinsic clearance (CYP3A5)
CLint_2c8_N_I = 127 # # (L/h) Intrinsic clearance to N-DMI (CYP2C8)
CLint_2c8_other_I = 17 # # (L/h) Intrinsic clearance to other metabolite (CYP2C8)
CLint_2b6_I = 2.9 # # (L/h) Intrinsic clearance (CYP2B6)
CLint_2d6_I = 1.5 # # (L/h) Intrinsic clearance (CYP2D6)
CLint_1a2_I = 3.6 # # (L/h) Intrinsic clearance (CYP1A2)
CLint_extra_I = 0.1

CLr_I = 0.5 # (L/h) Renal clearance (can vary, additional systemic clerance 1.8L/h)
CLadd_I = 1.8 # (L/h) Additional clearance

Ki_3a4_uM_I = 23.3 # # Competitive inhibition constant (uM)
kI_3a4_uM_I = 14.3 # # Inhibitor concentration that supports half maximal rate of inactivation (uM)
kinact_3a4_I = 4.32 # # Maximal inactivation rate
fu_mic_3a4_I = 0.9 # # 0.1mg/ml then 0.9, 0.5mg/ml then 0.8
Ki_2c8_uM_I = 8.36 # #  Competitive inhibition constant (uM)
fu_mic_2c8_I = 0.9 # #
Ki_3a5_uM_I = 23.3 # # Competitive inhibition constant (uM)
fu_mic_3a5_I = 0.9 # #
Ki_2d6_uM_I = 7.5  ## Competitive inhibition constant (uM)
fu_mic_2d6_I = 1   ##
Ki_2c9_uM_I = 27  ## Competitive inhibition constant (uM)
fu_mic_2c9_I = 1   ##

Tlag1 = 0.235 # # Absorption lag time

# Imatinib metabolite


MW_NMI = 479.57 # # (g/mol) Molecular weight
logP_NMI = 1.8 # # logP
pKa_NMI = 9.25 # # pKa
fup_NMI = 0.03 # # Fraction unbound
BP_NMI = 0.7725 # # Blood-to-plasma ratio

fu_gut_NMI_1 = 1 # # Fraction unbound in intestine (among 0.03, 0.06, 1)
fu_gut_NMI_fup = 0.03 ##
fu_hep_NMI = 0.03 # # Fraction unbound in liver
Kp_liver_NMI = 0.48 # # Tissue-to-plasma partition coefficient  (Simcyp 0.3 ~ 12)

Vc_kg_NMI = 2.61 # # (L/kg)
Vp_kg_NMI = 21 # # (L/kg)
Q_kg_NMI = 0.713 # # (L/h)

CLint_1a2_NMI = 3.6 # # (L/h) Intrinsic clearance (CYP1A2)
CLint_3a4_NMI = 34 # # (L/h) Intrinsic clearance (CYP3A4)
CLint_3a5_NMI = 3.3 # # (L/h) Intrinsic clearance (CYP3A5)
CLint_2c8_NMI = 9.2 # # (L/h) Intrinsic clearance (CYP2C8)
CLint_2d6_NMI = 1.8 # # (L/h) Intrinsic clearance (CYP2D6)
CLint_extra_NMI = 34.6  ##

CLr_NMI = 1.5 # # (L/h) Renal clearance (Additional : 14L/h)
CLadd_NMI = 42.8  ##

Ki_3a4_uM_NMI = 18.1 # # (uM)
fu_3a4_NMI = 0.9  ##
Ki_2c8_uM_NMI = 12.8 # # (uM)
fu_2c8_NMI = 0.9
Ki_3a5_uM_NMI = 18.1 # # (uM)
fu_3a5_NMI = 0.9  ##
Ki_2d6_uM_NMI = 13.5 ## (uM)
fu_2d6_NMI = 1
Ki_2c9_uM_NMI = 40.3 ## (uM)
fu_2c9_NMI = 1


********** MODEL VARIABLES


Qpv = Qpv_kg * WT
Vpv = Vpv_kg * WT
Qha = Qha_kg * WT
Qh = Qh_kg * WT
Vh = Vh_kg * WT
Qvilli = Qvilli_kg * WT

Vc_I = Vc_kg_I * WT
Vp_I = Vp_kg_I * WT

Vc_NMI = Vc_kg_NMI * WT # # (L/kg)
Vp_NMI = Vp_kg_NMI * WT # # (L/kg)

Q_I = Q_kg_I * WT
Q_NMI = Q_kg_NMI * WT


CLint_other_I = CLint_2b6_I + CLint_1a2_I + CLint_extra_I
CLint_other_NMI = CLint_1a2_NMI + CLint_extra_NMI

Ki_3a4_I = Ki_3a4_uM_I * MW_I * fu_mic_3a4_I
kI_3a4_I = kI_3a4_uM_I * MW_I * fu_mic_3a4_I
Ki_3a5_I = Ki_3a5_uM_I * MW_I * fu_mic_3a5_I
Ki_2c8_I = Ki_2c8_uM_I * MW_I * fu_mic_2c8_I
Ki_2c9_I = Ki_2c9_uM_I * MW_I * fu_mic_2c9_I
Ki_2d6_I = Ki_2d6_uM_I * MW_I * fu_mic_2d6_I

Ki_3a4_NMI = Ki_3a4_uM_NMI * MW_NMI * fu_3a4_NMI
Ki_3a5_NMI = Ki_3a5_uM_NMI * MW_NMI * fu_3a5_NMI
Ki_2c8_NMI = Ki_2c8_uM_NMI * MW_NMI * fu_2c8_NMI
Ki_2c9_NMI =Ki_2c9_uM_NMI * MW_NMI * fu_2c9_NMI
Ki_2d6_NMI =Ki_2d6_uM_NMI * MW_NMI * fu_2d6_NMI

MW_ratio_I = MW_NMI / MW_I

hep_1_I = LIV_I / Vh * fu_hep_I
hep_2_I = LIV_I / Vh * fup_I / Kp_liver_I
hep_I = (1 - DUMMY1) * hep_1_I + DUMMY1 * hep_2_I

hep_NMI1 = LIV_NMI / Vh * fu_hep_NMI
hep_NMI2 = LIV_NMI / Vh * fup_NMI / Kp_liver_NMI
hep_NMI = (1 - DUMMY1) * hep_NMI1 + DUMMY1 * hep_NMI2

fu_gut_I = (1 - DUMMY3) * fu_gut_I_1 + DUMMY3 * fu_gut_I_fup
fu_gut_NMI = (1 - DUMMY3) * fu_gut_NMI_1 + DUMMY3 * fu_gut_NMI_fup

portal_I = PV_I / Vpv * fu_gut_I
portal_NMI = PV_NMI / Vpv * fu_gut_NMI

CLint_3a4_I = CLint_3a4_N_I + CLint_3a4_other_I
CLint_3a5_I = CLint_3a5_N_I + CLint_3a5_other_I
CLint_2c8_I = CLint_2c8_N_I + CLint_2c8_other_I

TVCL_I = CLint_3a4_I * 1 / (1 + hep_NMI / Ki_3a4_NMI + hep_V / Ki_3a4_V) * CYP3a4_ratio + CLint_2c8_I * 1 / (1 + hep_NMI / Ki_2c8_NMI + hep_V / Ki_2c8_V) + CLint_3a5_I * 1 / (1 + hep_NMI / Ki_3a5_NMI) + CLint_2d6_I * 1 / (1 + hep_NMI / Ki_2d6_NMI) + CLint_other_I

TVCL_N_I = CLint_3a4_N_I * 1 / (1 + hep_NMI / Ki_3a4_NMI + hep_V / Ki_3a4_V) * CYP3a4_ratio + CLint_2c8_N_I * 1 / (1 + hep_NMI / Ki_2c8_NMI + hep_V / Ki_2c8_V) + CLint_3a5_N_I * 1 / (1 + hep_NMI / Ki_3a5_NMI)

TVCL_NMI = CLint_3a4_NMI * 1 / (1 + hep_I / Ki_3a4_I + hep_V / Ki_3a4_V) * CYP3a4_ratio + CLint_2c8_NMI * 1 / (1 + hep_I / Ki_2c8_I + hep_V / Ki_2c8_V) + CLint_3a5_NMI * 1 / (1 + hep_I / Ki_3a5_I) + CLint_2d6_NMI * 1 / (1 + hep_I / Ki_2d6_I) + CLint_other_NMI

Cc_I = CENT_I / Vc_I / BP_I
OUTPUT1 = Cc_I
Cc_NMI = CENT_NMI / Vc_NMI / BP_NMI
OUTPUT2 = Cc_NMI




********** MODEL REACTIONS


********** MODEL FUNCTIONS


********** MODEL EVENTS


********** MODEL INITIAL ASSIGNMENTS
