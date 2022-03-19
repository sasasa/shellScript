#!/usr/bin/bash

# comment

# echo "hello world"
# echo 'hello world'

# echo "foo"; echo "bar"

# 変数
readonly name="saeki"
echo "morning $name"
echo "hello $name"
echo "bye ${name}san"
echo 'bye ${name}san'

#引数 $1, $2, ...
echo "hello $1"

# ./hello a aa aaa
# $0 スクリプト名 ./hello
# $# 引数の数 3
# $@ or $* 全ての引数 a aa aaa
echo $0
echo $#
echo $@

# 入力受け取り
read -p "Name: " hoge
echo "hello! $hoge"

read -p "Colors: " c1 c2 c3
echo $c1
echo $c2
echo $c3

# 配列
colors=(red blue pink)
echo ${colors[0]} # red
echo ${colors[1]} # blue
echo ${colors[2]} # pink
echo ${colors[@]} # red blue pink
echo ${#colors[@]} # 3

colors[1]=silver
colors+=(green orange)
echo ${colors[@]} # red silver pink green orange
echo ${#colors[@]} # 5

# 数値計算
echo 5+2

echo `expr 5 + 2`
echo $((5 + 2))

n=5
((n=n+5))
echo $n

# + - * / % ** ++ --

echo $((10 / 3)) # 3


# if
read -p "Name? " welcom
if [ "$welcom" = "saeki" ]
then
  echo "welcom saeki"
elif [ "$welcom" = "satou" ]
then
  echo "welcom satou"
else
  echo "you are not allowed."
fi

# 文字列の比較
# [[]] = == != -z =~
# (())
if [[ -z $welcom ]]
then
  echo "empty!...."
elif [[ $welcom =~ ^t ]]
then
  echo "start with T"
fi

# ファイル判定
# -e -f -d
if [[ -f $0 ]]
then
  echo "file exists...."
fi

# 数値判定
# == != > >= < <=
# && || !
read -p "Number? " nn
if ((nn > 10))
then
  echo "bigger than 10"
fi

# for

for i in {1..5}
do
  echo $i
done

for ((i=1; i<=5; i++))
do
  echo $i
done

for color in ${colors[@]}
do
  echo $color
done

# $(コマンド) コマンドの結果を受け取る
for item in $(date)
do
  echo $item
done

# while
# continue
# break
i=0
while ((i < 10))
do
  ((i++))
  if ((i == 4)); then
    continue
  fi
  if ((i == 8)); then
    break
  fi
  echo $i
done

while :
do
  read -p "command?" cmd
  if [[ $cmd == "q" ]]; then
    break
  else
    echo "$cmd"
  fi
done

# while file の内容を読み込む
i=0
while read line; do
  echo $i "$line"
  ((i++))
done < colors.txt

# case
read -p "sig color? " sig
case "$sig" in
  red)
    echo "stop"
    ;;
  blue|green)
    echo "go"
    ;;
  yellow)
    echo "caution"
    ;;
  *)
    echo "wrong"
esac


# select
select sig in red blue yellow green
do
  case "$sig" in
    red)
      echo "stop"
      ;;
    blue|green)
      echo "go"
      ;;
    yellow)
      echo "caution"
      ;;
    *)
      echo "wrong"
      break
  esac
done

# 関数
function hello() {
  local hogename="pipi"
  echo "hello.........${1}!!!!!"
  if [[ $1 == "saeki" ]]; then
    return 0
  else
    return 1
  fi
}

hello saeki
echo $?
hello
echo $?


# 変数のスコープ
# 関数の中の変数が読めてしまうのでlocal指定する
echo $hogename