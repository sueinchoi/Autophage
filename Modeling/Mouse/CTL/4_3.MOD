$PROB Simple_2comp
$INPUT ID TIME AMT DV MDV CMT ADDL II SPECIES SEX MULTIPLE DOSE ROUTE FORMULATION 
$DATA  C:\Users\admin\Documents\GitHub\Autophage\PKTK_dataset_plasma.csv IGNORE=@ IGNORE=(SPECIES.NE.1)

$SUBROUTINE ADVAN4 TRANS4

$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(3)
 TVV2 = THETA(4)
 TVV3 = THETA(5)
 TVQ  = THETA(6)
 TVKA = THETA(7)
 
;---- RANDOM EFFECT DEFINITION ----

 CL   = TVCL * EXP(ETA(1))
 V2   = TVV2 * EXP(ETA(2))
 V3   = TVV3 * EXP(ETA(3))
 Q    = TVQ  * EXP(ETA(4))
 KA   = TVKA * EXP(ETA(5))
 F1   = THETA(8) * (1 - DOSE / (THETA(9) + DOSE)) * EXP(ETA(6))
 S2 = V2

$ERROR
 IPRED  = F
 W      = SQRT(THETA(1)**2 + THETA(2)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(1)

$THETA
 0.0001 FIX
 0.5
 (0, 10, 30)
 (0, 30, 100)
 (0, 50, 500)
 (0, 5, 200)
 (0, 1.5, 20)
 
 (0, 1)
 (0, 50)
$OMEGA
 0.1
 0.1
 0 FIX
 0.1
 0 FIX
 0 FIX
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER PRINT=10 SIGDIGITS=3  

$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES  ONEHEADER NOPRINT FILE = sdtab004_3
$TABLE ID CL V2 V3 Q KA F1 DOSE                      ONEHEADER NOPRINT NOAPPEND FILE = patab004_3
