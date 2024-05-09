# mt-qe-filtering
Experiment setup for evaluating the effects of quality estimation filtering for machine translation models

## Requirements and Installation
- [PyTorch](https://pytorch.org/) version >= 1.10.0
- Python version >= 3.8 (Experiments were run using Python 3.9.12)
- [fairseq](https://github.com/facebookresearch/fairseq) : ``` pip install fairseq ```
- [TransQuest](https://github.com/TharinduDR/TransQuest) : ``` pip install transquest ```

## Dataset
The German-English IWSLT17 dataset can be found [here](https://wit3.fbk.eu/2017-01).
1. Download 2017-01-trnmted.tgz
2. Extract files with ``` tar -xzvf 2017-01-trnmted.tgz ```
3. From the unzipped folder, also extract ```texts\DeEnItNlRo\DeEnItNlRo\DeEnItNlRo.tgz```
4. Run ``` prep-iwslt17.sh ``` to prepare the train, test, and valid sets.

## Initial Data Split Preparation and Preprocessing
1. Split ``` train.de ``` and ``` train.en ``` files using ``` Data_Preprocessing\split-data.sh ```. This will make all 7 dataset splits at once. 
2. Preprocess all split datasets using ``` Data_Preprocessing\preprocess.sh ```. Change paths to to point to your train, valid, and test set locations.

## Experiment 1
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to test.de and test.en, respectively. Change the checkpoint and databin paths for all 7 splits. In line 76, save sentences that are rated less than 0.70 : ``` if (pred < 0.70) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 

## Experiment 2
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint and databin paths for all 7 splits. In line 76, save sentences that are rated less than 0.712 : ``` if (pred < 0.712) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 

## Experiment 3
1. Run ``` fs_tq_v1.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint and databin paths for all 7 splits. In line 76, save sentences that are rated higher than 0.712 : ``` if (pred > 0.712) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Fine-tune the original models for each split with ```finetune.sh ```. Change the paths to the tokenized data, checkpoint_best.pt, and save directory. 

## Experiment 4
1. Run ``` tq_iwslt17.py ``` for each original dataset split. Change the source and target data to train.de and train.en, respectively. In line 76, save sentences that are rated higher than 0.712 : ``` if (pred > 0.712) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Train a new model for each split with ```finetune.sh ``` with a learning rate ``` --lr 5e-4```. Omit line 18 ``` --finetune-from-model checkpoints-v4/checkpoint7/checkpoint_best.pt ```. Change the paths to the tokenized data, and save directory. 

## Experiment 5
1. Run ``` fs_tq_v4.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint to point to the models trained in experiment 4 and the databin path for all 7 splits. In line 79, save sentences that are rated higher than 0.712 : ``` if (pred > 0.712) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Train a new model for each split with ```finetune.sh ```. Change the paths to the tokenized data, and save directory. 

## Experiment 6
1. Run ``` fs_tq_v4.py ``` for each split. Change the source and target data to train.de and train.en, respectively. Change the checkpoint to point to the models trained in experiment 4 and the databin path for all 7 splits. In line 79, save sentences that are rated lower than 0.712 : ``` if (pred < 0.712) ```
2. Preprocess the saved sentences using ``` Data_Preprocessing\preprocess.sh ```
3. Train a new model for each split with ```finetune.sh ```. Change the paths to the tokenized data, and save directory. 