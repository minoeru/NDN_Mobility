#!/bin/zsh

# start docker
for num in `seq 20`
do
  name="nlsr$num"
  docker run --name ${name} -itd minoeru/nlsr:ndnpeek_high /bin/bash
done

number=(17 18 19 20)
# create rand_raw.txt
if test -e rand_raw.txt; then
  rm rand_raw.txt
fi
for num in $number
do
  echo $num >> rand_raw.txt
done

# create moving_raw.txt
if test -e moving_raw.txt; then
  rm moving_raw.txt
fi
for num in `seq -f %02g 24`
do
  tmp=$((($num -1) /6 + 1))
  echo "${number[$tmp]},/ndn/edu/uaslp/move/moving$num" >> moving_raw.txt
done