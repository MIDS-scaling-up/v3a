# Homework 12.  NLP and Speech

Due: beginning of week 13.

Train [Conformer-Transducer](https://docs.nvidia.com/deeplearning/nemo/user-guide/docs/en/main/asr/models.html#conformer-transducer) BPE *Small* on LibriSpeech from scratch for 10-20 epochs.  We will distribute a tarred and processed version of Librispeech in class.

Notes:
* You will need to provision a GPU'ed VM in AWS to work on this.
* The config file for all Conformer Transducer BPE models is [here](https://github.com/NVIDIA/NeMo/blob/main/examples/asr/conf/conformer/conformer_transducer_bpe.yaml).  It's large by default so you'll have to set it to small instead (see the header inside the file)
* The script to train the model is [here](https://github.com/NVIDIA/NeMo/blob/main/examples/asr/asr_transducer/speech_to_text_rnnt_bpe.py)
* The difference between the two LibriSpeech versions is that the `tarred` dataset has the training set aggregated in larger tar files. The other version has a large number of audio files in the train folder. However, it also contains the dev and test datasets which you will need to evaluate your model on during training.
* Once you unpacked the dataset, you will need to generate a tokenizer using [this script](https://github.com/NVIDIA/NeMo/blob/main/scripts/tokenizers/process_asr_text_tokenizer.py). Use `spe` as the `--tokenizer` type, `unigram` as the `--spe_type` and 1024 as `--vocab_size` . Simply point it to your manifest to generate the tokenizer and then point to its directory for training.
* There's no need to spin up Jupyter; just do training on the command line.
* There is a pre-trained checkpoint [here](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/nemo/models/stt_en_conformer_transducer_small) so that you can compare your work (and model config and params) against it.

Credit / nocredit only.  Please spend time on your final projects!!
