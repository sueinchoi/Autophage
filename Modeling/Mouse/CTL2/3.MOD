$PROB Mouse_liver_2comp
$INPUT ID TIME AMT DV MDV CMT ADDL II SPECIES DOSE ROUTE FORMULATION TAD BQL WT LVW
$DATA  ..//Mouse_lowdose_individual.csv IGNORE=@

$SUBROUTINE ADVAN6 TOL=3

$MODEL NCOMP=5
 COMP(DEPOT, DEFDOSE)
 COMP(LIV)
 COMP(CENT, DEFOBS)
 COMP(PERI)
 COMP(BILE)
$PK
 ;---- PK FIXED EFFECT ----

 ;Distribution
 TVCL = THETA(5)
 TVV3 = THETA(6)
 TVV4 = THETA(7)
 TVQ  = THETA(8)

 ;Absorption
 TVKA = THETA(9)
 TVF1 = THETA(10)
 TVCLbile = THETA(11)

 ;Scaling parameter
 TVKp = THETA(12)
 FA = THETA(13)

 ;Biliary excretion parameter
 Tbil = THETA(14)
 ;Physiological data
 TVV2 = LVW ; Liver weigth (mL)
 TVCLint = 5135 * WT / 1000 * 60 ; Intrinsic clearance (mL/hr)
 TVQH = 2.62 * 60 ; Hepatic blood flow (mL/hr)

 ;Mouse in vitro data
 BP = 1       ; assumed
 fu = 0.135

;---- PK RANDOM EFFECT ----
 CL   = TVCL * EXP(ETA(1))
 V2   = TVV2 * EXP(ETA(2))
 V3   = TVV3 * EXP(ETA(3))
 V4   = TVV4 * EXP(ETA(4))
 Q    = TVQ  * EXP(ETA(5))
 KA   = TVKA * EXP(ETA(6))
 CLint = TVCLint * EXP(ETA(7))
 F1 = TVF1 * EXP(ETA(8))
 QH = TVQH * EXP(ETA(9))
 Kp = TVKp * EXP(ETA(10))
 CLbile = TVCLbile * EXP(ETA(11))

;---- PK PARAMETER RELATIONSHIP ----
 S2   = V2
 S3   = V3
 K34  = Q/V3
 K43  = Q/V4

 T1 = 1 + Tbil
 T2 = 4 + Tbil
 T3 = 8 + Tbil

 BILE = 0

$DES


 IF(TIME.GT.1.AND.TIME.LT.T1) BILE = 1
 IF(TIME.GT.4.AND.TIME.LT.T2) BILE = 1
 IF(TIME.GT.8.AND.TIME.LT.T3) BILE = 1

 DADT(1) = - KA*A(1)
 DADT(2) = KA*A(1) - QH*A(2)/V2/Kp - CLint*A(2)/V2*fu + QH*A(3)/V3 - CLbile*A(2)/V2 + A(5)/Tbil
 DADT(3) = QH*A(2)/V2/Kp - K34*A(3) + K43*A(4) - QH*A(3)/V3
 DADT(4) = K34*A(3) - K43*A(4)
 DADT(5) = CLbile*A(2)/V2 - A(5)/Tbil

$ERROR
; dose : ng, concentration : ng/mL

 IF (CMT.EQ.2) THEN
 IPRED  = A(2)/V2
 W      = SQRT(THETA(1)**2 + THETA(2)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(1)
 ENDIF

 IF (CMT.EQ.3) THEN
 IPRED  = A(3)/V3
 W      = SQRT(THETA(3)**2 + THETA(4)**2 * IPRED**2)
 IRES   = DV - IPRED
 IWRES  = IRES / W
 Y      = IPRED + W * EPS(2)
 ENDIF

$THETA
 ; Error model
 0.0001 FIX
 0.5

 0.0001 FIX
 0.5

 ;Distribution
 0 FIX   ; (5) CL (mL/hr)
 (0, 100)  ; (6) VC (mL)
 (0, 100) FIX  ; (7) VP (mL)
 (0, 20) FIX ; (8) Q (mL/hr)

 ; Absorption
 (0, 20) ; (9) KA (/h)
 (0, 0.2, 1) ; (10) F1
 (0, 1000) ; (11) TVCLbile

 ; Scaling parameter
 15 FIX ; (12) Kp
 0.5 ; (13) FA

 ; Biliary PARAMETER
 0.5 FIX ; (14) Tbil

$OMEGA
 0 FIX
 0 FIX
 0 FIX
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
 1 FIX
$ESTIMATION NOABORT MAXEVAL=9999 METHOD=0 PRINT=10 SIGDIGITS=3

$TABLE ID TIME AMT CMT DV MDV IPRED CWRES IWRES  ONEHEADER NOPRINT  FILE = sdtab001
