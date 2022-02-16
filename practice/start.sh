#!/bin/zsh

for num in `seq 3`
do
  name="nlsr$num"
  docker run --name ${name} -itd minoeru/nlsr:practice /bin/bash
done