#!/bin/zsh

for num in `seq 3`
do
  name="nlsr$num"
  docker stop ${name} && docker rm ${name}
done