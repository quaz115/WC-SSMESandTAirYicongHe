#!/bin/bash

##SBATCH --partition i01203share
#SBATCH --partition tshp384
#SBATCH --nodes 4
#SBATCH --ntasks-per-node 56
#SBATCH --job-name batch
#SBATCH --error ./outputs/%j.err
#SBATCH --output ./outputs/%j.out
#SBATCH --exclusive

# SET RECURSIVE DEPTH:
# ==================================================================
if [ -z $DEPTHr ]; then
    export DEPTHr=0
else
    export DEPTHr=$(($DEPTHr+1))
fi

# RUN LEVEL 0:
# ==================================================================
if [ $DEPTHr == 0 ]; then
    
    # >> LOG MESSAGE:
    read -p "ENTER SIMULATION LOG: " line

    # >> APPEND TO LOG:
    printf "\n\nSIMULATION on $( date +%F-%T ):\n%s\n" "$line" >> log.SIMS

    # >> RECURSIVE CALL:
    sbatch run.sh

fi 

# RUN LEVEL 1:
# ==================================================================
if [ $DEPTHr == 1 ]; then

    echo "STARTED @ $( date )"

    limit stacksize unlimited

    module load mathlib/netcdf/4.7.1/impi_pnetcdf

    mpirun -np 224 ./wrf.exe

    echo "ENDED @ $( date )"

fi
