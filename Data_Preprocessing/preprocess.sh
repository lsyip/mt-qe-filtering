#!/bin/bash

#SBATCH --job-name=process-finetune-data-17-1
#SBATCH --time=00:15:00
#SBATCH --account=comp_sci
#SBATCH --partition=gpu
#SBATCH --nodes=1

echo "--------------Start job $SLURM_JOBID"

#module load python/3.8
module load gcc/9.3.1

#source ~/miniconda/etc/profile.d/conda.sh
#conda activate fairseq-env

fairseq-preprocess --source-lang de --target-lang en \
	--trainpref split1/train \
        --validpref ./../fairseq/data-bin/iwslt17.tokenized.de-en/valid \
        --testpref ./../fairseq/data-bin/iwslt17.tokenized.de-en/test \
	--destdir binarized-data-v1/iwslt17.tokenized.de-en-finetune1 \
        --tgtdict ./../fairseq/data-bin2/iwslt17.tokenized.de-en/dict.en.txt \
        --srcdict ./../fairseq/data-bin2/iwslt17.tokenized.de-en/dict.de.txt \

echo "--------------End job $SLURM_JOBID: process 17-1"
