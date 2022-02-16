FROM ubuntu:20.04
MAINTAINER minoeru

USER root
RUN apt update -y && \
apt install -y tzdata && \
apt install -y git  && \
apt install -y vim
# ndn-cxx
RUN git clone https://github.com/named-data/ndn-cxx.git  && \
apt-get install -y build-essential libsqlite3-dev libboost-all-dev libssl-dev && \
cd ndn-cxx && \
./waf configure && \
./waf && \
./waf install && \
ldconfig
# NFD
RUN apt install -y software-properties-common && \
add-apt-repository ppa:named-data/ppa && \
apt update && \
apt install -y nfd && \
apt install -y libpcap-dev libsystemd-dev && \
apt install pkg-config && \
git clone --recursive https://github.com/named-data/NFD.git
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
./waf install && \
mkdir my_conf
COPY my_conf/ ./NLSR/my_conf
# その他
RUN ldconfig && \
mkdir /var/lib/nlsr && \
mkdir /var/lib/nlsr/r1 && \
mkdir /var/lib/nlsr/r2 && \
mkdir /var/lib/nlsr/r3 && \
mkdir /var/lib/nlsr/router1 && \
mkdir /var/lib/nlsr/router2 && \
mkdir /var/lib/nlsr/router3 && \
mkdir /var/lib/nlsr/router4 && \
mkdir /var/lib/nlsr/router5 && \
mkdir /var/lib/nlsr/router6 && \
mkdir /var/lib/nlsr/router7 && \
mkdir /var/lib/nlsr/router8 && \
mkdir /var/lib/nlsr/router9 && \
mkdir /var/lib/nlsr/router10 && \
mkdir /var/lib/nlsr/new_router1 && \
mkdir /var/lib/nlsr/new_router2 && \
mkdir /var/lib/nlsr/new_router3 && \
mkdir /var/lib/nlsr/new_router4 && \
mkdir /var/lib/nlsr/new_router5 && \
mkdir /var/lib/nlsr/new_router6 && \
mkdir /var/lib/nlsr/new_router7 && \
mkdir /var/lib/nlsr/new_router8 && \
mkdir /var/lib/nlsr/new_router9 && \
mkdir /var/lib/nlsr/new_router10 && \
mkdir /var/lib/nlsr/new_pc && \
mkdir /var/lib/nlsr/new_server1 && \
mkdir /var/lib/nlsr/new_server2 && \
mkdir /var/lib/nlsr/new_server3 && \
mkdir /var/lib/nlsr/new_server4
COPY newExperiment/script/ ./NLSR/
RUN apt install -y tcpdump
WORKDIR NLSR
