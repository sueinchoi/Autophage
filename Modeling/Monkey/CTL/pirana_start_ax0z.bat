echo Starting NONMEM runs
C:
cd "C:\Users\admin\Documents\GitHub\Autophage\Modeling\Monkey\CTL"
cd nmfe_dual_2_11_001
CALL C:/nm74g64/util/nmfe74.bat dual_2_11.mod dual_2_11.lst   
copy dual_2_11.lst ..
copy dual_2_11.ext ..
copy dual_2_11.phi ..
copy *tabdual_2_11 .. 
cd ..
echo Pirana: All runs finished / submitted.
echo Done
pause

