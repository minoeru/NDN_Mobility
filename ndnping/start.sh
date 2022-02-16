#!/bin/zsh

for num in `seq 10`
do
  name="nlsr$num"
  docker run --name ${name} -itd minoeru/nlsr:ndnping /bin/bash
done