FROM ubuntu:20.04
MAINTAINER minoeru

USER root
RUN apt update -y && \
apt install -y tzdata && \
apt install -y git  && \
apt install -y vim
# proactive
RUN apt install -y software-properties-common && \
add-apt-repository ppa:named-data/ppa && \
apt update && \
apt install -y nfd && \
apt install -y libpcap-dev libsystemd-dev && \
apt install -y pkg-config
# nan-cxx
RUN git clone https://github.com/named-data/ndn-cxx.git  && \
apt-get install -y build-essential libsqlite3-dev libboost-all-dev libssl-dev && \
cd ndn-cxx && \
./waf configure && \
./waf && \
./waf install && \
ldconfig
# NFD
RUN git clone --recursive https://github.com/named-data/NFD.git
ENV PKG_CONFIG_PATH /custom/lib/pkgconfig
COPY my_program/cs-policy-lru.cpp ./NFD/daemon/table/cs-policy-lru.cpp
RUN cd NFD && \
./waf configure && \
./waf && \
./waf install && \
cp /usr/local/etc/ndn/nfd.conf.sample /usr/local/etc/ndn/nfd.conf
# PSync library
RUN git clone https://github.com/named-data/PSync.git && \
cd PSync && \
./waf configure && \
./waf && \
./waf install
# ndn-tools
RUN git clone https://github.com/named-data/ndn-tools.git && \
cd ndn-tools && \
./waf configure && \
./waf && \
./waf install
# NLSR
RUN git clone https://github.com/named-data/NLSR.git && \
cd NLSR && \
./waf configure && \
./waf && \
./waf install
RUN ldconfig && \
mkdir /var/lib/nlsr
WORKDIR NLSR