echo tokenize &&\
python tokenize_text.py input.txt tokenized_input.txt &&\
echo extract &&\
python /app/bert/extract_features.py \
  --input_file=/app/tokenized_input.txt \
  --output_file=/app/output.jsonl \
  --vocab_file=/app/UTH_BERT_BASE_MC_BPE_V25000_10M/vocab.txt \
  --bert_config_file=/app/UTH_BERT_BASE_MC_BPE_V25000_10M/bert_config.json \
  --init_checkpoint=/app/UTH_BERT_BASE_MC_BPE_V25000_10M/model.ckpt-10000000.index \
  --layers=-1,-2,-3,-4 \
  --max_seq_length=128 \
  --batch_size=8
