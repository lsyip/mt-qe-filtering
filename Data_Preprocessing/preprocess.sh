#!/bin/bash


echo "--------------Start job preprocess.sh"


fairseq-preprocess --source-lang de --target-lang en \
	--trainpref split1/train \
        --validpref ./../fairseq/data-bin/iwslt17.tokenized.de-en/valid \
        --testpref ./../fairseq/data-bin/iwslt17.tokenized.de-en/test \
	--destdir binarized-data-v1/iwslt17.tokenized.de-en-finetune1 \
        --tgtdict ./../fairseq/data-bin2/iwslt17.tokenized.de-en/dict.en.txt \
        --srcdict ./../fairseq/data-bin2/iwslt17.tokenized.de-en/dict.de.txt \

echo "--------------End job preprocess.sh"
