

********** MODEL NAME

Autophage

********** MODEL NOTES

Autophage
1. Possibly biliary excretion
2. 2-comparment model
3. continuous biliary elimination + temporary EHR

********** MODEL STATES

d/dt(GUT) = - KA*GUT + FP*INPUT2
d/dt(CENT) = KA*GUT - K23*CENT + K32*PERI - K20*CENT + INPUT1
d/dt(PERI) = K23*CENT - K32*PERI

********** MODEL PARAMETERS
KA = 0.5
Q = 100
V2 = 10
V3 = 1000
CL = 10
FP = 0.2
********** MODEL VARIABLES
K20 = CL/V2
K23 = Q/V2
K32 = Q/V3
Cc = CENT / V2
OUTPUT1 = Cc



********** MODEL REACTIONS


********** MODEL FUNCTIONS


********** MODEL EVENTS


********** MODEL INITIAL ASSIGNMENTS