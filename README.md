# mt-qe-filtering
Experiment setup for evaluating the effects of quality estimation filtering for machine translation models

## Requirements and Installation
- [PyTorch](https://pytorch.org/) version >= 1.10.0
- Python verison >= 3.8
- [fairseq](https://github.com/facebookresearch/fairseq) : ``` pip install fairseq ```
- [TransQuest](https://github.com/TharinduDR/TransQuest) : ``` pip install transquest ```

## Initial Data Split Preparation and Preprocessing
1. Split train.de and train.en files using ```Data_Preprocessing\split-data.sh```. This will make all 7 dataset splits at once. 
2. Preprocess all split datasets using ```Data_Preprocessing\preprocess.sh```. Change paths to to point to your train, valid, and test set locations.

## Experimenent 1
