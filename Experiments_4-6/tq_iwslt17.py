import torch
from transquest.algo.sentence_level.siamesetransquest.run_model import SiameseTransQuestModel
from fairseq.models.transformer import TransformerModel

"""
V4: Pass original IWSLT17 training data through Transquest. 
    Save "high quality" sentences. Train new system on these sentences. 
"""


def main():
    
    source = []
    target = []

    # Read .txt into array
    # SOURCE data (original)
    with open('/PATH/TO/train.de', 'r', encoding='UTF-8') as source_file:
          for line in source_file:
                print(line)
                source.append(line)

    # TARGET data (original)
    with open('/PATH/TO/train.en', 'r', encoding='UTF-8') as target_file:
          for line in target_file:
                print(line)
                target.append(line)


    qe_high_source = []
    qe_high_target = []
    total_good = 0
    total_sents = 0
    sum = 0
    avg = 0
    

    # Load TransQuest QE model
    qe_model = SiameseTransQuestModel("TransQuest/siamesetransquest-da-en_de-wiki")

    for i in range(len(source)):
        pred = qe_model.predict([[source[i], target[i]]])  # TransQuest QE score on source & target
        sum = sum + pred
        total_sents = total_sents + 1
        if (pred > 0.71): # Save sentences that are GREATER than .71
            total_good = total_good + 1
            qe_high_source.append(source[i])
            qe_high_target.append(target[i])

    # Uncomment to save train.de/en files
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
