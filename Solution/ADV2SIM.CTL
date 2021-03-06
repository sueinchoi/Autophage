$PROB BQL WORKSHOP

$INPUT ID TIME AMT DV MDV ; 

$DATA FORSIM.csv IGNORE=@ ;IGNORE(BQL=1)
$SUBROUTINE ADVAN2 TRANS2

$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(1)
 TVV = THETA(2)
 TVKA = THETA(3)
 
 
;---- RANDOM EFFECT DEFINITION ----

 CL    = TVCL * EXP(ETA(1))
 V     = TVV * EXP(ETA(2))
 KA    = TVKA * EXP(ETA(3))
 
 S1    = V/1000
 K     = CL/V
 
$ERROR
  LLOQ  = 1.0
  IPRED = F
  IRES = DV-IPRED
  W = SQRT(THETA(4)**2 + THETA(5)**2 * IPRED**2)
  IWRES = IRES/W
  Y = IPRED + W*EPS(1)
 

$THETA
 (0, 10)
 (0, 50)
 (0, 3)
 0.0001 FIX
 0.5

$OMEGA
 0.12
 0.09
 0.0025
 
$SIGMA
 1 FIX

;$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 NUMERICAL LAPLACIAN SLOW PRINT=10 SIGDIGITS=3
$SIM (345623) ONLYSIM NSUB=1

$TABLE ID TIME AMT DV MDV ONEHEADER NOPRINT FILE = SIMDATA



