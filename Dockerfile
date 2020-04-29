FROM python:3.6.8-stretch

WORKDIR /app
RUN apt update &&\
    rm -rf ~/.cache &&\
    apt clean all

# mecab
RUN apt install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8 gsutil libwww-perl
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH /root/google-cloud-sdk/bin:$PATH
RUN mkdir -p /usr/lib/x86_64-linux-gnu/mecab
RUN ln -s /var/lib/mecab/dic /usr/lib/x86_64-linux-gnu/mecab/dic

# Neologd
RUN mkdir /app/neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /app/neologd
RUN /app/neologd/bin/install-mecab-ipadic-neologd -n -y

# python
WORKDIR /app
RUN pip install --upgrade pip &&\
    rm -rf ~/.cache
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

# bert
RUN apt install git
RUN git clone https://github.com/google-research/bert.git
RUN wget https://ai-health.m.u-tokyo.ac.jp/labweb/dl/uth_bert/UTH_BERT_BASE_MC_BPE_V25000_10M.zip
RUN unzip UTH_BERT_BASE_MC_BPE_V25000_10M.zip

# MANBYO dic
RUN wget http://sociocom.jp/~data/2018-manbyo/data/MANBYO_201907_Dic-utf8.dic

# sample file
COPY ./input.txt /app/input.txt
COPY ./extract_feature.sh /app/extract_feature.sh
COPY ./tokenize_text.py /app/tokenize_text.py
