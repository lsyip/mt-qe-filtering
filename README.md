# mt-qe-filtering
Experiment setup for evaluating the effects of quality estimation filtering for machine translation models

## Requirements and Installation
- [PyTorch](https://pytorch.org/) version >= 1.10.0
- Python verison >= 3.8
- [fairseq](https://github.com/facebookresearch/fairseq) : ``` pip install fairseq ```
- [TransQuest](https://github.com/TharinduDR/TransQuest) : ``` pip install transquest ```

## Initial Data Split Preparation and Preprocessing
1. Split train.de and train.en files using ``` Data_Preprocessing\split-data.sh ```. This will make all 7 dataset splits at once. 
2. Preprocess all split datasets using ``` Data_Preprocessing\preprocess.sh ```. Change paths to to point to your train, valid, and test set locations.

## Experiment 1
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to test.de and test.en, respectively. Change the checkpoint and databin paths for all 7 splits. 
2. In line 76, save sentences that are rated less than 0.70 : ``` if (pred < 0.70) ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 

## Experiment 2
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint and databin paths for all 7 splits. 
2. In line 76, save sentences that are rated less than 0.712 : ``` if (pred < 0.712) ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 

## Experiment 3
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint and databin paths for all 7 splits. 
2. In line 76, save sentences that are rated higher than 0.712 : ``` if (pred > 0.712) ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 