$PROB Simple_2comp, M3 method 
$INPUT ID TIME AMT DV MDV CMT ADDL II SPECIES SEX MULTIPLE DOSE ROUTE FORMULATION TAD BQL LIV RATE TYPE 
$DATA  ..//Monkey_plasma_dual_m3.csv IGNORE=@

$SUBROUTINE ADVAN4 TRANS4

$PK
;---- FIXED EFFECT DEFINITION ---- 
 TVCL = THETA(3)
 TVV2 = THETA(4)
 TVV3 = THETA(5)
 TVQ  = THETA(6)
 TVKA = THETA(7)
 TVF  = THETA(8)
 TVFA = THETA(9)
 TVD2 = THETA(10)
 TVALAG = THETA(11)
;---- RANDOM EFFECT DEFINITION ----

 CL   = TVCL * EXP(ETA(1))
 V2   = TVV2 * EXP(ETA(2))
 V3   = TVV3 * EXP(ETA(3))
 Q    = TVQ  * EXP(ETA(4))
 KA   = TVKA * EXP(ETA(5))
 FF   = TVF * EXP(ETA(6))
 FA   = TVFA * EXP(ETA(7))
 D2   = TVD2 * EXP(ETA(8))
 ALAGPO = TVALAG * EXP(ETA(9))
 S2 = V2

IF(ROUTE.EQ.1) THEN
 F1 = FF * FA
 F2 = FF * (1 - FA)
 ALAG1 = ALAGPO
ELSE
 F1 = 1
 F2 = 1
 ALAG1 = 0
ENDIF

$ERROR
  LLOQ  = 1.0
  IPRED = F 
  IRES = DV-IPRED
  W = SQRT(THETA(1)**2 + THETA(2)**2 * IPRED**2)
  IWRES = IRES/W
  
  IF(DV .LT. LLOQ) THEN   
    F_FLAG=1 
    Y = PHI((LLOQ-IPRED)/W)
  ELSE
    F_FLAG=0 
    Y = IPRED + W*EPS(1)
  ENDIF

$THETA
 ; Error
 0.0001 FIX
 0.5
 
 ; Distribution
 (0, 4) ; CL(3) 2.16 L/h/kg
 (0, 10) ; V2(4) 3.34 L/kg
 (0, 2) ; V3(5) 0.651 L/kg
 (0, 2) ; Q (6) 0.12 L/h/kg
 
 ; Absorption
 (0, 1) ; KA(7) 0.299 /h
 (0, 0.1)  ; FF(8) 0.0201
 (0, 0.5)  ; FA(9) 0.623
 (0, 5)    ; D2(10)   7.92
 (0, 5)    ; ALAG2(11) 4.00
 
$OMEGA
 0.1
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
 0 FIX
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 NUMERICAL LAPLACIAN SLOW INTER PRINT=10 SIGDIGITS=3  

$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES BQL   ONEHEADER NOPRINT FILE = sdtab002
$TABLE ID CL V2 V3 Q KA F1 DOSE                      ONEHEADER NOPRINT NOAPPEND FILE = patab002

