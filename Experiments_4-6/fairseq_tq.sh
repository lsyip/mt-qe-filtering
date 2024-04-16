#!/bin/bash -l

#SBATCH --job-name=fs_tq_v4-17-7
#SBATCH --time=03:00:00
#SBATCH --account=comp_sci
#SBATCH --partition=gpu
#SBATCH --nodes=1
#### SBATCH --ntasks-per-node=1
#### SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2


#### setup fairseq in conda env
echo "---------- Start job $SLURM_JOBID"

module load gcc/9.3.1
module load python/3.8

source ~/miniconda/etc/profile.d/conda.sh
conda activate fairseq-env


echo "----------- Run python -----------"

python fs_tq_v4.py


echo "---------- Finished job $SLURM_JOBID - Fairseq-Transquest 17-7" 

