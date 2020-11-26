$PROB Simple_2comp, M3 method 
$INPUT ID TIME AMT DV MDV CMT ADDL II SPECIES SEX MULTIPLE DOSE ROUTE FORMULATION TAD BQL LIV
$DATA  ..//Rat_plasma.csv IGNORE=@ IGNORE=(ROUTE.EQ.1)

$SUBROUTINE ADVAN3 TRANS4

$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(3)
 TVV1 = THETA(4)
 TVV2 = THETA(5)
 TVQ  = THETA(6)

;---- RANDOM EFFECT DEFINITION ----

 CL   = TVCL * EXP(ETA(1))
 V1   = TVV1 * EXP(ETA(2))
 V2   = TVV2 * EXP(ETA(3))
 Q    = TVQ  * EXP(ETA(4))

 S1 = V1

$ERROR

 IPRED  = A(1)/V1
 W      = SQRT(THETA(1)**2 + THETA(2)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(1)

$THETA
 0.0001 FIX
 0.5
 (0, 1)
 (0, 1)
 (0, 10)
 (0, 50)

$OMEGA
 0 FIX
 0 FIX
 0 FIX
 0 FIX
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3  

$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES BQL   ONEHEADER NOPRINT FILE = sdtab001
$TABLE ID CL V1 V2 Q  DOSE                      ONEHEADER NOPRINT NOAPPEND FILE = patab001
