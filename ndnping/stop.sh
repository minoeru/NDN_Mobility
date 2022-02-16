#!/bin/zsh

for num in `seq 10`
do
  name="nlsr$num"
  docker stop ${name} && docker rm ${name}
done