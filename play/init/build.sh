
ifort -c mod.test.f90

ifort -c main.f90

ifort -o run.exe main.o mod.test.o
