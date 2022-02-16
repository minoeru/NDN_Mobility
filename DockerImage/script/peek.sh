##peek.sh
#!/bin/bash

# list.txtの行数取得
max=$(wc -w list.txt | awk '{print $1}')

for i in `seq 500`
do
  sleep 1
  # 1~行数の乱数を取得
  rand=$(echo $(($RANDOM % $max +1)))
  # ランダムな行数のコンテンツ名を取得
  hoge=$(sed -n ${rand}p list.txt)
  echo "finding $hoge" >> result.txt
  ndnpeek -p $hoge >> result.txt
done