import torch
from transquest.algo.sentence_level.siamesetransquest.run_model import SiameseTransQuestModel
from fairseq.models.transformer import TransformerModel

"""
V1: Base fairseq model translates test set of training sentences.
    Output sentences are sent through TQ quality estimation.
Save "BAD" source/target sentences to txt file for finetuning pass. 

V2: Base fairseq model translates sentences that it was trained on.
    Output sentences sent through TQ quality estimate
    Save "BAD" source/target sentences to txt file for finetuning pass. 

V3: Base fairseq model translates sentences that it was trained on.
    Output sentences sent through TQ quality estimate
    Save "GOOD" source/target sentences to txt file for finetuning pass. 
"""


def main():
    
    source = []
    target = []
    predict = []


    # Read .txt into array
    # SOURCE data (original)
    with open('/PATH/TO/train.de', 'r', encoding='UTF-8') as source_file:
          for line in source_file:
                source.append(line)

    # TARGET data (original)
    with open('/PATH/TO/train.en', 'r', encoding='UTF-8') as target_file:
          for line in target_file:
                target.append(line)

    # Checkpoint to load model
    checkpoint_path = '/PATH/TO/checkpoints/'
    # Databin that the model was trained on (tokenized)
    databin_path = '/PATH/TO/iwslt17.tokenized.de-en'
    
    print("Loading model...")

    # Load base fairseq model from checkpoint
    model = TransformerModel.from_pretrained(
        checkpoint_path, 
        checkpoint_file='checkpoint_best.pt', 
        data_name_or_path = databin_path,
        is_gpu=True
    ).cuda()


    qe_predictions = []
    qe_high_predict = []
    qe_high_source = []
    qe_high_target = []
    total_good = 0
    total_sents = 0
    sum = 0
    avg = 0
    
    print(source[0])
 
    for i in range(len(source)):
        predict.append(model.translate(source[i]))


    # Load TransQuest QE model
    qe_model = SiameseTransQuestModel("TransQuest/siamesetransquest-da-en_de-wiki")

    for i in range(len(source)):
        pred = qe_model.predict([[source[i], predict[i]]])  # TransQuest QE score
        sum = sum + pred
        total_sents = total_sents + 1
        if (pred < 0.712): # Save sentences that are </> than threshold .712
            total_good = total_good + 1
            qe_high_source.append(source[i])
            qe_high_predict.append(predict[i])
            qe_high_target.append(target[i])

    
    good_source_f = open("train.de", "a")
    good_source_f.writelines(qe_high_source)

    good_target_f = open("train.en", "a")
    good_target_f.writelines(qe_high_target)

    good_source_f.close()
    good_target_f.close()
    
    avg = sum / total_sents
    print(total_good, total_sents, avg)


if __name__ == "__main__":
    main()
