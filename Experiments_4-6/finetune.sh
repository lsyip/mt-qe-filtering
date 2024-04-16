#!/bin/bash -l

#SBATCH --job-name=fine-tune
#SBATCH --time=05:00:00
#SBATCH --account=comp_sci
#SBATCH --partition=gpu
#SBATCH --nodes=1

echo "Start job train 17-7"
module load python/3.8
module load gcc/9.3.1

source ~/miniconda/etc/profile.d/conda.sh
conda activate fairseq-env

CUDA_VISIBLE_DEVICES=0 fairseq-train \
    binarized-data-v6/iwslt17.tokenized.de-en-finetune7 \
    --finetune-from-model checkpoints-v4/checkpoint7/checkpoint_best.pt \
    --arch transformer_iwslt_de_en --share-decoder-input-output-embed \
    --optimizer adam --adam-betas '(0.9, 0.98)' --clip-norm 0.0 \
    --lr 5e-5 --lr-scheduler inverse_sqrt --warmup-updates 4000 \
    --dropout 0.3 --weight-decay 0.0001 \
    --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
    --max-tokens 4096 \
    --patience 10 \
    --keep-last-epochs 5 \
    --save-dir finetune-checkpoints-v6/checkpoint7 \
    --eval-bleu \
    --eval-bleu-args '{"beam": 5, "max_len_a": 1.2, "max_len_b": 10}' \
    --eval-bleu-detok moses \
    --eval-bleu-remove-bpe \
    --eval-bleu-print-samples \
    --best-checkpoint-metric bleu --maximize-best-checkpoint-metric

echo "Finished fine-tuning 17-7"
