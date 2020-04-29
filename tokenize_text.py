import MeCab
import neologdn
import subprocess
import os


def exec_cmd(cmd):
    out = subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (stdout, stderr) = out.communicate()
    results = stdout.decode().split()
    return results[0]


def get_dicdir():
    return os.path.join(exec_cmd("mecab-config --dicdir"), 'mecab-ipadic-neologd')


def make_mecab_tagger():
    neologd_dic = get_dicdir()
    mecab = MeCab.Tagger(f'-Owakati --dicdir={neologd_dic}  --userdic=/app/MANBYO_201907_Dic-utf8.dic')
    mecab.parse('')
    return mecab


def tokenize_text(mecab, text):
    text = neologdn.normalize(text)
    return mecab.parse(text)


if __name__ == "__main__":
    mecab = make_mecab_tagger()
    print('[START]tokenize input.txt')
    with open('./input.txt', 'r') as fr:
        with open('./tokenized_input.txt', 'w') as fw:
            for x in fr:
                fw.write(tokenize_text(mecab, x))
    print('[DONE]tokenize input.txt')
