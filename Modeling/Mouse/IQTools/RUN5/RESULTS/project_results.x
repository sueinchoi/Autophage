list(type = "SYSFIT", method = "mstrust", termination_info = "", 
    path = structure("RUN5", class = "IQRsysProject", absProjectPath = "C:/Users/admin/Documents/GitHub/Autophage/Modeling/Mouse/IQTools/RUN5", absModelPath = "C:/Users/admin/Documents/GitHub/Autophage/Modeling/Mouse/IQTools/RUN5/model.txt", absDataPath = "C:/Users/admin/Documents/GitHub/Autophage/Modeling/Mouse/IQTools/RUN5/Plasma_inidividual4_sys.csv"), 
    parameters = list(note = "Parameters are given on the scale at which they are estimated, they are not transformed to linear scale", 
        names = c("GUT", "CENT", "PERI", "INPUT1", "INPUT2", 
        "KA", "FP", "Q", "V2", "V3", "CL", "Tlag1", "Tlag2", 
        "error_ADD1", "error_PROP1", "omega(GUT)", "omega(CENT)", 
        "omega(PERI)", "omega(INPUT1)", "omega(INPUT2)", "omega(KA)", 
        "omega(FP)", "omega(Q)", "omega(V2)", "omega(V3)", "omega(CL)", 
        "omega(Tlag1)", "omega(Tlag2)"), FLAGestimated = c(0, 
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0), transformation = c("(phi)", 
        "(phi)", "(phi)", "(phi)", "(phi)", "exp(phi)", "exp(phi)", 
        "exp(phi)", "exp(phi)", "exp(phi)", "exp(phi)", "(phi)", 
        "(phi)", "", "", "", "", "", "", "", "", "", "", "", 
        "", "", "", ""), values = c(0, 0, 0, 0, 0, -1.62638534111683, 
        -1.56448722268772, 6.50233509342563, 3.27922827121288, 
        6.576605700396, 5.52877838932746, 0, 0, -372.038409471396, 
        0.315570454319848, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0), stderrors = c(0, 0, 0, 0, 0, 0.137285008924595, 0.131978953797196, 
        0.304883477460562, 0.383108839093178, 0.156747144017443, 
        0.126263615044513, 0, 0, 10, 0.115647071165545, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), correlationmatrix = structure(c(1, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        1, 0.480376407204552, 0.806496810646192, 0.737949002285846, 
        0.582820723010691, 0.265543103048716, 0, 0, 3.6066792146411e-322, 
        -0.116883697053202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0.480376407204551, 1, 0.741447582595259, 
        0.751964922048916, 0.692320173098994, 0.563287918531712, 
        0, 0, -1.87250879773832e-321, -0.196792443830958, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.80649681064619, 
        0.741447582595258, 1, 0.910643178048954, 0.835592931455054, 
        0.567898593564628, 0, 0, -1.1343747228515e-320, 0.0168540722265361, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0.737949002285845, 0.751964922048916, 0.910643178048955, 
        1, 0.812619787752214, 0.606241853784061, 0, 0, -2.06519439961641e-321, 
        0.033497968343583, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0.582820723010687, 0.692320173098992, 
        0.835592931455052, 0.812619787752211, 1, 0.879710085150574, 
        0, 0, -2.9945318794438e-320, 0.379953394316002, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.265543103048712, 
        0.563287918531709, 0.567898593564625, 0.606241853784058, 
        0.879710085150573, 1, 0, 0, -3.83493754301976e-320, 0.616200802987229, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, -1.53149173260405e-307, 2.0606299548843e-307, 5.30867505485514e-308, 
        -1.91509463088255e-308, -8.27152893214563e-308, 2.44970314046216e-308, 
        0, 0, 1, 7.90856880366377e-308, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.116883697053206, 
        -0.196792443830962, 0.0168540722265311, 0.0334979683435783, 
        0.379953394315998, 0.616200802987226, 0, 0, -4.44313235305033e-320, 
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1), .Dim = c(28L, 
        28L), .Dimnames = list(c("GUT", "CENT", "PERI", "INPUT1", 
        "INPUT2", "KA", "FP", "Q", "V2", "V3", "CL", "Tlag1", 
        "Tlag2", "error_ADD1", "error_PROP1", "omega(GUT)", "omega(CENT)", 
        "omega(PERI)", "omega(INPUT1)", "omega(INPUT2)", "omega(KA)", 
        "omega(FP)", "omega(Q)", "omega(V2)", "omega(V3)", "omega(CL)", 
        "omega(Tlag1)", "omega(Tlag2)"), c("GUT", "CENT", "PERI", 
        "INPUT1", "INPUT2", "KA", "FP", "Q", "V2", "V3", "CL", 
        "Tlag1", "Tlag2", "error_ADD1", "error_PROP1", "omega(GUT)", 
        "omega(CENT)", "omega(PERI)", "omega(INPUT1)", "omega(INPUT2)", 
        "omega(KA)", "omega(FP)", "omega(Q)", "omega(V2)", "omega(V3)", 
        "omega(CL)", "omega(Tlag1)", "omega(Tlag2)"))), covariancematrix = structure(c(0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0.0188471736754262, 0.00870381130916091, 0.033756674796942, 
        0.0388125018608749, 0.0125417384096321, 0.00460295110571426, 
        0, 0, 4.94065645841247e-322, -0.00185571677962183, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0087038113091609, 
        0.0174184442454024, 0.0298345178865565, 0.0380210788160115, 
        0.0143222517867194, 0.00938670863120375, 0, 0, -2.47032822920623e-321, 
        -0.00300363902849595, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0.0337566747969419, 0.0298345178865564, 
        0.0929539348284449, 0.106366360631518, 0.0399326639478644, 
        0.0218616482271959, 0, 0, -3.45845952088873e-320, 0.000594255730625821, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0.0388125018608748, 0.0380210788160115, 0.106366360631518, 
        0.146772382591323, 0.0487988067054786, 0.0293255595517514, 
        0, 0, -7.90505033345994e-321, 0.00148414139510733, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.012541738409632, 
        0.0143222517867194, 0.0399326639478643, 0.0487988067054784, 
        0.024569667157625, 0.0174107478869091, 0, 0, -4.69362363549184e-320, 
        0.00688754744783065, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0.0046029511057142, 0.00938670863120371, 
        0.0218616482271958, 0.0293255595517513, 0.0174107478869091, 
        0.0159425004841089, 0, 0, -4.84184332924422e-320, 0.00899777476988608, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, -2.1025085617849e-307, 2.71959785608794e-307, 1.61852731143237e-307, 
        -7.33689680790994e-308, -1.29653853677148e-307, 3.09308374300648e-308, 
        0, 0, 100, 9.14602819254909e-308, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.00185571677962189, 
        -0.00300363902849601, 0.000594255730625642, 0.00148414139510713, 
        0.00688754744783058, 0.00899777476988604, 0, 0, -5.13828271674896e-320, 
        0.0133742450691685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0), .Dim = c(28L, 28L), .Dimnames = list(
            c("GUT", "CENT", "PERI", "INPUT1", "INPUT2", "KA", 
            "FP", "Q", "V2", "V3", "CL", "Tlag1", "Tlag2", "error_ADD1", 
            "error_PROP1", "omega(GUT)", "omega(CENT)", "omega(PERI)", 
            "omega(INPUT1)", "omega(INPUT2)", "omega(KA)", "omega(FP)", 
            "omega(Q)", "omega(V2)", "omega(V3)", "omega(CL)", 
            "omega(Tlag1)", "omega(Tlag2)"), c("GUT", "CENT", 
            "PERI", "INPUT1", "INPUT2", "KA", "FP", "Q", "V2", 
            "V3", "CL", "Tlag1", "Tlag2", "error_ADD1", "error_PROP1", 
            "omega(GUT)", "omega(CENT)", "omega(PERI)", "omega(INPUT1)", 
            "omega(INPUT2)", "omega(KA)", "omega(FP)", "omega(Q)", 
            "omega(V2)", "omega(V3)", "omega(CL)", "omega(Tlag1)", 
            "omega(Tlag2)")))), objectivefunction = list(OBJ = -101200.468192128, 
        BIC = -101153.743058869, AIC = -101184.468192128), residualerrormodels = "absrel", 
    inv_trans_randeffects = c("(psi)", "(psi)", "(psi)", "(psi)", 
    "(psi)", "log(psi)", "log(psi)", "log(psi)", "log(psi)", 
    "log(psi)", "log(psi)", "(psi)", "(psi)"), trans_randeffects = c("(phi)", 
    "(phi)", "(phi)", "(phi)", "(phi)", "exp(phi)", "exp(phi)", 
    "exp(phi)", "exp(phi)", "exp(phi)", "exp(phi)", "(phi)", 
    "(phi)"), covariates = list(covNames = "", covTransformation = "", 
        catNames = "", catReference = "", catCategories = ""), 
    PROJECTINFO = list(COMMENT = "", TOOL = "IQRtools SYSFIT", 
        TOOLVERSION = "1.3.2", FILE = "project_sysfit.R", METHOD = "trust-region", 
        DATA = "./Plasma_inidividual4_sys.csv", DOSINGTYPES = c("BOLUS", 
        "BOLUS"), COVNAMES = "", CATNAMES = "", REGRESSIONNAMES = "", 
        OUTPUTS = "Cc", ERRORMODELS = "absrel", ERRORNAMES = c("error_ADD1", 
        "error_PROP1"), PARAMNAMES = c("GUT", "CENT", "PERI", 
        "TIME1_1", "TINF1_1", "TIME2_1", "TINF2_1", "AMT1_1", 
        "AMT2_1", "KA", "Q", "V2", "V3", "CL", "FP", "INPUT1", 
        "Tlag1", "INPUT2", "Tlag2"), PARAMTRANS = c("(phi)", 
        "(phi)", "(phi)", "(phi)", "(phi)", "(phi)", "(phi)", 
        "(phi)", "(phi)", "exp(phi)", "exp(phi)", "exp(phi)", 
        "exp(phi)", "exp(phi)", "exp(phi)", "(phi)", "(phi)", 
        "(phi)", "(phi)"), PARAMINVTRANS = c("(psi)", "(psi)", 
        "(psi)", "(psi)", "(psi)", "(psi)", "(psi)", "(psi)", 
        "(psi)", "log(psi)", "log(psi)", "log(psi)", "log(psi)", 
        "log(psi)", "log(psi)", "(psi)", "(psi)", "(psi)", "(psi)"
        ), LOCPARAMNAMES = "", LOCPARAMTRANS = "", LOCPARAMINVTRANS = "", 
        LOCPARAMESTIMATE = "", COVARIATENAMES = "", COVARIATESUSED = "", 
        BETACOVNAMES = "", BETACOVTRANS = "", BETACATNAMES = "", 
        BETACATREFERENCE = "", BETACATCATEGORIES = "", THETANAMES = c("GUT", 
        "CENT", "PERI", "TIME1_1", "TINF1_1", "TIME2_1", "TINF2_1", 
        "AMT1_1", "AMT2_1", "KA", "Q", "V2", "V3", "CL", "FP", 
        "INPUT1", "Tlag1", "INPUT2", "Tlag2", "error_ADD1", "error_PROP1"
        ), THETAESTIMATE = c("0", "0", "0", "0", "0", "0", "0", 
        "0", "0", "1", "1", "1", "1", "1", "1", "0", "0", "0", 
        "0", "1", "1"), ETANAMES = c("omega(GUT)", "omega(CENT)", 
        "omega(PERI)", "omega(TIME1_1)", "omega(TINF1_1)", "omega(TIME2_1)", 
        "omega(TINF2_1)", "omega(AMT1_1)", "omega(AMT2_1)", "omega(KA)", 
        "omega(Q)", "omega(V2)", "omega(V3)", "omega(CL)", "omega(FP)", 
        "omega(INPUT1)", "omega(Tlag1)", "omega(INPUT2)", "omega(Tlag2)"
        ), ETAESTIMATE = c("0", "0", "0", "0", "0", "0", "0", 
        "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", 
        "0"), CORRELATIONNAMES = "", CORRESTIMATE = "", NROBSERVATIONS = "344", 
        NRPARAM_ESTIMATED = "8", RESIDUAL_NAMES_USED = c("XPRED", 
        "XRES", "XWRES"), RESIDUAL_NAMES_ORIG = c("XPRED", "XRES", 
        "XWRES")), rawParameterInfo = list(fixedEffects = list(
        names = c("GUT", "CENT", "PERI", "INPUT1", "INPUT2", 
        "KA", "FP", "Q", "V2", "V3", "CL", "Tlag1", "Tlag2"), 
        trans = c("", "", "", "", "", "", "", "", "", "", "", 
        "", ""), invtrans = c("", "", "", "", "", "", "", "", 
        "", "", "", "", ""), estimated = c(0, 0, 0, 0, 0, 1, 
        1, 1, 1, 1, 1, 0, 0), values = c(0, 0, 0, 0, 0, 0.196639074230416, 
        0.209195256256268, 666.696615707129, 26.5552713228104, 
        718.0977489609, 251.836077395494, 0, 0), stderr = c(NA, 
        NA, NA, NA, NA, 0.0269955970606468, 0.0276093710600386, 
        203.264782607977, 10.1735591682863, 112.559771274976, 
        31.7977335305848, NA, NA), rse = c(NA, NA, NA, NA, NA, 
        13.7285008924595, 13.1978953797196, 30.4883477460562, 
        38.3108839093178, 15.6747144017443, 12.6263615044513, 
        NA, NA), distribution_info = c("(psi)", "(psi)", "(psi)", 
        "(psi)", "(psi)", "log(psi)", "log(psi)", "log(psi)", 
        "log(psi)", "log(psi)", "log(psi)", "(psi)", "(psi)")), 
        fixedEffects_transformed = list(names = c("GUT", "CENT", 
        "PERI", "INPUT1", "INPUT2", "KA", "FP", "Q", "V2", "V3", 
        "CL", "Tlag1", "Tlag2"), trans = c("(phi)", "(phi)", 
        "(phi)", "(phi)", "(phi)", "exp(phi)", "exp(phi)", "exp(phi)", 
        "exp(phi)", "exp(phi)", "exp(phi)", "(phi)", "(phi)"), 
            invtrans = c("(psi)", "(psi)", "(psi)", "(psi)", 
            "(psi)", "log(psi)", "log(psi)", "log(psi)", "log(psi)", 
            "log(psi)", "log(psi)", "(psi)", "(psi)"), estimated = c(0, 
            0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0), values = c(0, 
            0, 0, 0, 0, -1.62638534111683, -1.56448722268772, 
            6.50233509342563, 3.27922827121288, 6.576605700396, 
            5.52877838932746, 0, 0), stderr = c(NA, NA, NA, NA, 
            NA, 0.137285008924595, 0.131978953797196, 0.304883477460562, 
            0.383108839093178, 0.156747144017443, 0.126263615044513, 
            NA, NA), rse = c(NA, NA, NA, NA, NA, 8.44111204484432, 
            8.43592404484214, 4.68883059823882, 11.6828963221727, 
            2.38340492281611, 2.28375250648945, NA, NA), distribution_info = c("(psi)", 
            "(psi)", "(psi)", "(psi)", "(psi)", "log(psi)", "log(psi)", 
            "log(psi)", "log(psi)", "log(psi)", "log(psi)", "(psi)", 
            "(psi)")), randomEffects = list(names = c("omega(GUT)", 
        "omega(CENT)", "omega(PERI)", "omega(INPUT1)", "omega(INPUT2)", 
        "omega(KA)", "omega(FP)", "omega(Q)", "omega(V2)", "omega(V3)", 
        "omega(CL)", "omega(Tlag1)", "omega(Tlag2)"), estimated = c(0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), values = c(0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), stderr = c(NA, NA, 
        NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), rse = c(NA, 
        NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)), correlation = list(
            names = character(0), stderr = logical(0), rse = logical(0)), 
        covariate = list(names = character(0), estimated = numeric(0), 
            values = numeric(0), stderr = numeric(0), rse = numeric(0)), 
        errorParameter = list(names = c("error_ADD1", "error_PROP1"
        ), estimated = c(1, 1), values = c(2.66545718270733e-162, 
        1.37104120429626), stderr = c(2.66731049938209e-161, 
        0.158556899724143), rse = c(1000.69530911499, 11.5647071165545
        ))))