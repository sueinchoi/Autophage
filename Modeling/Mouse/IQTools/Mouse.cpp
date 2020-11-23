

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

BILE = 0
KA = 5
QH = 157.2  # Hepatic blood flow (mL/hr)
Tbil = 0.25
V2 = 2.3
Kp = 15
CLint = 7702.5 # Intrinsic clearance (mL/hr)
fu = 0.15
V3 = 10
CLbile = 1000E
Q = 20
V4 = 100


********** MODEL VARIABLES

K34 = Q/V3
K43 = Q/V4

CLIV = LIV / V2
OUTPUT1 = CLIV
Cc_NMI = CENT / V3
OUTPUT2 = CCENT




********** MODEL REACTIONS


********** MODEL FUNCTIONS


********** MODEL EVENTS

Event1 = gt(time,3), BILE, 1
Event2 = gt(time,3+Tbil), BILE, 0
Event3 = gt(time,9), BILE, 1
Event4 = gt(time,9+Tbil), BILE, 0

********** MODEL INITIAL ASSIGNMENTS
