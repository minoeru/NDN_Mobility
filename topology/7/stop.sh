#!/bin/zsh

# stop docker
for num in `seq 12`
do
  name="nlsr$num"
  docker stop ${name} && docker rm ${name}
done

# remove rand_raw.txt
if test -e rand_raw.txt; then
  rm rand_raw.txt
fi

# remove moving_raw.txt
if test -e moving_raw.txt; then
  rm moving_raw.txt
fi