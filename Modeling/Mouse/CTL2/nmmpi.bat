mpiexec -wdir "%cd%"  -localonly -n 1 nonmem.exe %* : ^
-wdir "%cd%\worker1" -n 1 nonmem.exe : ^
-wdir "%cd%\worker2" -n 1 nonmem.exe : ^
-wdir "%cd%\worker3" -n 1 nonmem.exe : ^
-wdir "%cd%\worker4" -n 1 nonmem.exe : ^
-wdir "%cd%\worker5" -n 1 nonmem.exe : ^
-wdir "%cd%\worker6" -n 1 nonmem.exe : ^
-wdir "%cd%\worker7" -n 1 nonmem.exe
