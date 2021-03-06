$PROB BQL WORKSHOP

$INPUT ID TIME AMT DV MDV BQL2 BQL3 ; 

$DATA ONECMTBQL.csv IGNORE=@ ;
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
  LLOQ  = 2.0
  IPRED = F
  IRES = DV-IPRED
  W = SQRT(THETA(4)**2 + THETA(5)**2 * IPRED**2)
  IWRES = IRES/W
 
  IF(DV .LT. LLOQ) THEN   
    F_FLAG=1 
    Y = PHI((LLOQ-IPRED)/W)
  ELSE
    F_FLAG=0 
    Y = IPRED + W*EPS(1)
  ENDIF

$THETA
 (0, 10, 60)
 (0, 50, 200)
 3 FIX
 0.001 FIX
 0.2

$OMEGA
 0.01
 0.01
 0.0 FIX
 
$SIGMA
 1 FIX

$ESTIMATION NOABORT MAXEVAL=9999 METHOD=1 INTER NUMERICAL LAPLACIAN SLOW PRINT=10 SIGDIGITS=5
$COV PRINT=E
$TABLE ID TIME AMT DV MDV IPRED CWRES IWRES BQL2 BQL3 ONEHEADER NOPRINT FILE = sdtab3
$TABLE ID ETA(1) ETA(2) ETA(3) CL V KA ONEHEADER NOPRINT NOAPPEND FILE = patab3


