#!/bin/sh
LOG_FILE="/NLSR/nfd-log.txt"

function() {
    while read i
    do	    
        echo $i | grep -q "insert /ndn/edu/uaslp/move"
        if [ $? = "0" ];then
            var=$(echo $i |  sed -e "s/.*insert //")
            echo $var
            nlsrc advertise $var
        else
            echo $i | grep -q "insert /localhost/nfd/cs/erase"
            if [ $? = "0" ];then
            var=$(echo $i | sed -e "s@.*/localhost/nfd/cs/erase/h%..%..%..@@" -e "s@%..%..@/@g" -e "s@//.*@@")
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

tail -n 0 --follow=name --retry $LOG_FILE | function
