## change to you personal conda environment where R is installed.
conda activate /usr/local/usrapps/jmgray2/rpops_env
#This version of MPI is necessary for a successful compile.
module load openmpi-gcc/openmpi1.8.4-gcc4.8.2
setenv RMPI_INCLUDE /usr/local/apps/openmpi/1.8.4-gcc4.8.2/include
setenv RMPI_LIBPATH /usr/local/apps/openmpi/1.8.4-gcc4.8.2/lib
Rscript --vanilla ./setup_rmpi.R
conda deactivate
