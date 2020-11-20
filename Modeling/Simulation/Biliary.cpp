$PARAM @annotated

P_F : 1 : Bioavailability
KA : 1.5 : Absorption rate constant (1/h)
VC : 100 : Central volume (L)
CLint : 700 : Intrinsic clearance (mL/h)
Q : 40 : Inter-compartmental clearance (L/h)
VP : 10 : Peripheral volume of distribution (L)
CLbile : 1000 : Biliary clearance(mL/h)
CL : 0 : Clearance (mL/h)
MTIME1 : 2.5 : First meal time
MTIME2 : 9 : Second meal time
Tbil : 0.25 : MM no (0) yes (1)
Kp : 15 : Liver-plasma partition coefficient
V_liv : 2.5 : Liver weight
Qh : 1560 : Hepatic blood flow (mL/h)
fu : 0.135 : unbound fraction
KB : 10 : Absorption

$SET delta= 0.1

$CMT GUT GUT2 LIV CENT PERI GB

$GLOBAL

$MAIN

double CLi = exp(log(CL) + ECL);
double VCi = exp(log(VC) + EVC);
double VPi = exp(log(VP) + EVP);
double Qi = exp(log(Q) + EQ);
double KAi = exp(log(KA) + EKA);
double Fi = exp(log(P_F) + EF);

double K34 = Qi / VCi;
double K43 = Qi / VPi;
double K30 = CLi / VCi;
double CPi = CENT/VCi;

double BILE = 0;
if(self.tad() > MTIME1 &&  self.tad() < MTIME1 + Tbil )  BILE = 1;
if(self.tad() > MTIME2 && self.tad() < MTIME2 + Tbil)  BILE = 1;
F_GUT = Fi;

$OMEGA @name IIV @labels ECL EVC EVP EQ EKA EF

0 0 0 0 0 0

$SIGMA @labels ADD PROP
0 0


$ODE
dxdt_GUT = -KAi * GUT;
dxdt_GUT2 = -KB * GUT2 + BILE * GB / Tbil;
dxdt_LIV = KAi * GUT - Qh * LIV / V_liv / Kp - CLint * LIV / V_liv * fu + Qh * CENT / VCi - CLbile * LIV / V_liv;
dxdt_CENT = Qh * LIV / V_liv / Kp - K34 * CENT + K43*PERI - Qh * CENT / VCi - K30 * CENT;
dxdt_PERI = K34 * CENT - K43 * PERI;
dxdt_GB = CLbile *LIV / V_liv - BILE * GB / Tbil;

$TABLE

capture CP = CENT/VCi*(1 + PROP) + ADD;
capture Cliv = LIV / V_liv ;

$CAPTURE CP BILE;