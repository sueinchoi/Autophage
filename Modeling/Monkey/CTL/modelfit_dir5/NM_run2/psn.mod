$PROBLEM    Simple_2comp,M3 method
$INPUT      ID TIME AMT DV MDV CMT ADDL II SPECIES SEX MULTIPLE DOSE
            ROUTE FORMULATION TAD BQL LIV RATE TYPE
$DATA      Monkey_plasma_dual_m3.csv IGNORE=@
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
 ALAG2 = ALAGPO
ELSE
 F1 = 1
 F2 = 1
 ALAG2 = 0
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

$THETA  0.0001 FIX
 0.5
 (0,10,30) ; 2.97 L/h/kg
 (0,30,100) ; 1.76 L/kg
 (0,50,500) ; 1.10 L/kg
 (0,5,200) ; 0.164 L/h/kg
 (0,1.5,20) ; 1.55 /h
 (0,0.1) ; 0.0437
 (0,0.4) ; 0.0607
 (0,6) ; 20.1
 (0,6) ; 20.1_
$OMEGA  0.1
 0.1
 0.1
 0  FIX
 0  FIX
 0  FIX
 0  FIX
 0  FIX
 0  FIX
$SIGMA  1  FIX
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 NUMERICAL LAPLACIAN SLOW
            INTER PRINT=10 SIGDIGITS=3
$TABLE      ID TIME AMT DV MDV IPRED CWRES IWRES BQL ONEHEADER NOPRINT
            FILE=sdtab002
$TABLE      ID CL V2 V3 Q KA F1 DOSE ONEHEADER NOPRINT NOAPPEND
            FILE=patab002

