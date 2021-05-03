#!/bin/tcsh
#BSUB -n 8
#BSUB -W 3
#BSUB -J mpi4py_test
#BSUB -o %J_mpi4py_test.stdout
#BSUB -e %J_mpi4py_test.stderr

module load openmpi-gcc
## change to you personal conda environment.
conda activate /usr/local/usrapps/jmgray2/nfkruska_env
## this example uses mpi4py.futures to distribute jobs, so the call here
## reflects that in the -m argument.
mpirun python -m mpi4py.futures ./test_py_mpi.py
conda deactivate
