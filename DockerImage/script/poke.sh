##poke.sh
#!/bin/bash
if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには1個の引数が必要です。" 1>&2
  exit 1
fi

# grep
echo $1 | grep -q "move"
        if [ $? = "0" ];then
            nlsrc advertise $1
            echo $$,$1 >> moving.txt
        fi
while true
do
  echo "Hello $1" | ndnpoke $1
done


####