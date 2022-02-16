##doPoke.sh
#!/bin/bash
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  exit 1
fi

max=$(wc -w $1 | awk '{print $1}')

for num in `seq $max`
do
  hoge=$(sed -n ${num}p $1)
  ./poke.sh $hoge &
  sleep 1
done