#!/bin/sh

sed -e "s/^\!.*'.*//" -e "s/^ *\!.*'.*//" wrf.F > wrf.G


SED_FTN=../tools/standard.exe

$SED_FTN wrf.G > wrf.H 


#####cpp -I$../inc $(CPPFLAGS) $*.H  > $@
