#!/bin/bash

#SBATCH --partition c6148
#SBATCH --nodes 6
#SBATCH --ntasks-per-node 40
#SBATCH --job-name yh
#SBATCH --error ./outputs/out.SLURM/err.%j
#SBATCH --output ./outputs/out.SLURM/out.%j
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
    
    # LOG MESSAGE:
    read -p "ENTER SIMULATION LOG: " line

    # APPEND TO LOG:
    printf "\n\nSIMULATION on $( date +%F-%T ):\n%s\n" "$line" >> log.SIMS

    # RECURSIVE CALL:
    sbatch run-wrf.sh

fi 

# RUN LEVEL 1:
# ==================================================================
if [ $DEPTHr == 1 ]; then

    echo "STARTED @ $( date )"

    # UNLIMIT STACKSIZE:
    ulimit -s unlimited

    module load mathlib/netcdf/4.7.1/impi_pnetcdf

    # RUN MODEL:
    mpirun -np 240 ./wrf.exe

    echo "ENDED @ $( date )"

fi
