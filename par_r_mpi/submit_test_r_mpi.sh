#!/bin/tcsh
#BSUB -n 8
#BSUB -W 3
#BSUB -J Rmpi_test
#BSUB -o %J_Rmpi_test.stdout
#BSUB -e %J_Rmpi_test.stderr

## this is version of openmpi that should be used to compile Rmpi.
module load openmpi-gcc/openmpi1.8.4-gcc4.8.2
## change to you personal conda environment where R is installed and Rmpi
## has been successfully compiled.
conda activate /usr/local/usrapps/jmgray2/rpops_env
## when using R with MPI, #BSUB -n specifies the universe size, while mpirun -n
## specifies you want 1 universe / cluster. Then in the R file, you need to
## subtract one from the mpi.universe.size() to account for the main process.
## This results in n - 1 worker tasks.
mpirun -n 1 Rscript --vanilla ./test_r_mpi.R
conda deactivate
