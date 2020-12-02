library(mrgsolve)

mod <- mread_cache('pk2', modlib())

mod <- mcode_cache('new', new)
see(mod)
mod <- param(mod, list(TVCL = 252,
                       TVVC= 28.6,
                       TVVP = 741,
                       TVQ = 704,
                       TVKA = 0.2)
                        )
mod %>%
    ev(amt = 10*28*0.214*1000, cmt = 1) %>%
    mrgsim(end = 24) %>%
    plot()
<<<<<<< HEAD

new <- 

'$PARAM TVCL = 1.3, TVVC=28, TVKA=0.6, WT=70, OCC=1, TVVP = 10,  TVQ = 10

$SET delta=0.01, end=24

$CMT GUT CENT PERI

$MAIN

double IOV = IOV1;
if(OCC==2) IOV = IOV2;

double CLi = exp(log(TVCL) + 0.75*log(WT/70) + ECL + IOV);
double VCi = exp(log(TVVC) + EVC);
double VPi = exp(log(TVVP) + EVP);
double Qi = exp(log(TVQ) + EVQ);
double KAi = exp(log(TVKA) + EKA);
double K23 = Qi / VCi;
double K32 = Qi / VPi;

$OMEGA @name IIV @labels ECL EVC EKA EVP EVQ
0 0 0 0 0 
$OMEGA @name IOV @labels IOV1 IOV2
0 0

$SIGMA 0

$ODE
dxdt_GUT = -KAi*GUT;
dxdt_CENT = KAi*GUT - (CLi/VCi)*CENT - K23*CENT + K32 * PERI;
dxdt_PERI = K23*CENT - K32*PERI;

$TABLE
capture CP = CENT/VCi;

$CAPTURE IOV ECL EVC'




code <- '

$PARAM @annotated

P_F : 1 : Bioavailability
KA : 1.5 : Absorption rate constant (1/h)
VC : 10 : Central volume (V)
CL : 4 : Clearance (L/h)
Q : 4 : Inter-compartmental clearance (L/h)
VP : 10 : Peripheral volume of distribution (L)

ALAG1 : 0 :
ALAG2 : 0 :

$SET delta= 0.1

$CMT GUT CENT PERI

$GLOBAL

double podo = 0;

$MAIN

double CLi = exp(log(CL) + ECL);
double VCi = exp(log(VC) + EVC);
double VPi = exp(log(VP) + EVP);
double Qi = exp(log(Q) + EQ);
double KAi = exp(log(KA) + EKA);
double Fi = exp(log(P_F) + EF);

double K23 = Qi / VCi;
double K32 = Qi / VPi;

double CPi = CENT/VCi;

$OMEGA @name IIV @labels ECL EVC EVP EQ EKA EF

0 0 0 0 0 0

$SIGMA @labels ADD PROP
0 0


$ODE
  dxdt_GUT =  -KAi * GUT;
  dxdt_CENT = KAi* GUT -(CLi/VCi) * CENT  - K23 * CENT + K32 * PERI;
  dxdt_PERI = K23 * CENT - K32 * PERI;

$TABLE
capture CP = CENT/VCi*(1 + PROP) + ADD;


$CAPTURE CP;'
}}}
=======
a <- c(229.5/15.2, 369/15.1, 105.9/1.78, 79.8/2.06)
ifelse(5 %in% c(4, 5), 1:2, 1)
mean(a)
16801.28/mean(a)
10*28*1000
code <- '
'
>>>>>>> f2bd23003200de0f562dca0839c47ae7fe368733
