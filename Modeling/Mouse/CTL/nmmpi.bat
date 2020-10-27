mpiexec -wdir "%cd%"  -localonly -n 1 nonmem.exe %* : ^
-wdir "%cd%\worker1" -n 1 nonmem.exe : ^
-wdir "%cd%\worker2" -n 1 nonmem.exe : ^
-wdir "%cd%\worker3" -n 1 nonmem.exe
