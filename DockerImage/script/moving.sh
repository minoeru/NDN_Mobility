##moving.sh
#!/bin/bash

pnum=$(grep -n $1 moving.txt | awk -F '[:,]' '{print $2}')
kill $pnum
ndnpeek -p $1
nfdc cs erase $1
nlsrc withdraw $1
sed -i "/$pnum/d" ./moving.txt