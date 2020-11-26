$PROB Simple_2comp, M3 method 
$INPUT ID TIME AMT DV MDV CMT ADDL II SPECIES SEX MULTIPLE DOSE ROUTE FORMULATION TAD BQL LIV
$DATA  ..//Rat_plasma.csv IGNORE=@

$SUBROUTINE ADVAN4 TRANS4

$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(3)
 TVV2 = THETA(4)
 TVV3 = THETA(5)
 TVQ  = THETA(6)
 TVKA = THETA(7)
 TVF = THETA(8)
 TVALAG1 = THETA(9)
;---- RANDOM EFFECT DEFINITION ----

 CL   = TVCL * EXP(ETA(1))
 V2   = TVV2 * EXP(ETA(2))
 V3   = TVV3 * EXP(ETA(3))
 Q    = TVQ  * EXP(ETA(4))
 KA   = TVKA * EXP(ETA(5))
 F1   = TVF * EXP(ETA(6))
 ALAG1 = TVALAG1 * EXP(ETA(7))
 S2 = V2

$ERROR

 IPRED  = A(2)/V2
 W      = SQRT(THETA(1)**2 + THETA(2)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(1)

$THETA
 0.001 FIX
 0.5
 (0, 5)
 (0, 1)
 (0, 0.5)
 (0, 0.3)
 (0, 0.2)
 (0, 0.01)
 0.25 FIX
$OMEGA
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3  

$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES BQL   ONEHEADER NOPRINT FILE = sdtab002.txt
$TABLE ID CL V2 V3 Q KA F1 DOSE                      ONEHEADER NOPRINT NOAPPEND FILE = patab002.txt