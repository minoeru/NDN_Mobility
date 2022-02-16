#!/bin/bash
LOG_FILE="/NLSR/nfd-log.txt"

function routing_support() {    
    while read i
    do	    
        echo $i | grep -q "insert /ndn/edu/uaslp/"
        if [ $? = "0" ];then
            echo $i | grep -q "insert /ndn/edu/uaslp/move"
            if [ $? = "0" ];then
                rand=$(echo $(($RANDOM % 10 +1)))
                if [ $rand -le $num1 ] ;then
                    var=$(echo $i |  sed -e "s/.*insert //")
                    echo $var
                    nlsrc advertise $var
                fi
            else
                rand=$(echo $(($RANDOM % 10 +1)))
                if [ $rand -le $num2 ] ;then
                    var=$(echo $i |  sed -e "s/.*insert //")
                    echo $var
                    nlsrc advertise $var
                fi
            fi            
        else
            echo $i | grep -q "[nfd.ContentStore] erase /ndn/edu/uaslp/"
            if [ $? = "0" ];then
                var=$(echo $i | sed -e "s/.*erase //" -e "s/ done//")
                echo $var
                nlsrc withdraw $var
            fi
        fi
    done
}

# main
if [ ! -f ${LOG_FILE} ]; then
    touch ${LOG_FILE}
fi

if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

num1=$(echo $(($1)))
num2=$(echo $(($2)))

tail -n 0 --follow=name --retry $LOG_FILE | routing_support