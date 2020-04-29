# Docker for UTH-BERT

東京大学大学院 医学系研究科 医療AI開発講座より公開されているBERT学習済みモデルであるUTH-BERTを動かすためのスクリプト群です。  
  
UTH-BERT: https://ai-health.m.u-tokyo.ac.jp/uth-bert


# Usage

以下のコマンドでdockerコンテナを作成し動かします。mecab、neologd、J-MeDic(万病辞書)とgoogle-researchのbertモデルrepogitoryが入り、活用できる状態となります。

```
docker build -t bert .
docker run -it bert bash
```

# 特徴抽出

テキストファイルを特徴量に変換するには以下のコマンドを実行します。
入力テキストをtokenizeしたファイル、featureのファイルが出力されます。

```
./extract_feature.sh
```

output.jsonlファイルがinput.txtに対する特徴量です。  
inputはサンプルとしてWikipediaのインフルエンザのページを設置しています。
```
インフルエンザ

インフルエンザ（イタリア語: influenza、ラテン語: influentia）とはインフルエンザウイルス急性感染症。上気道炎症状・呼吸器疾患などを呈する。流行性感冒（りゅうこうせいかんぼう）略して流感（りゅうかん）とも呼ばれる。日本語ではインフル、英語ではfluと略されることも多い。
...
```

上記サンプルに対するoutput.jsonlは以下のような形式で出力されます。
```
{"linex_index": 0, "features": [ {"token": "インフルエンザ", "layers": {"index": 0, "values": [0.1, 0.2, ...]}}, ... ]}
...
```

# THX & LICENCE

順不同

 - [UTH-BERT](https://ai-health.m.u-tokyo.ac.jp/uth-bert): [Creative Commons 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en) (CC BY-NC-SA 4.0)
 - [万病辞書](http://sociocom.jp/~data/2018-manbyo/index.html): [Creative Commons 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en) (CC BY 4.0)
 - [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd): (Apache License, Version 2.0](https://github.com/neologd/mecab-ipadic-neologd/blob/master/COPYING)
 - [google-research/bert](https://github.com/google-research/bert): [Apache License, Version 2.0](https://github.com/google-research/bert/blob/master/LICENSE)
 - [MeCab](https://taku910.github.io/mecab/): [BSD,LGPL,GPL](https://github.com/taku910/mecab/blob/3a07c4eefaffb4e7a0690a7f4e5e0263d3ddb8a3/mecab/COPYING)
