FROM minoeru/nlsr:base
MAINTAINER minoeru

USER root
RUN apt install -y tcpdump
RUN mkdir my_conf
COPY my_conf/ndnpeek_low ./my_conf
RUN ldconfig && \
mkdir /var/lib/nlsr/new_router1 && \
mkdir /var/lib/nlsr/new_router2 && \
mkdir /var/lib/nlsr/new_router3 && \
mkdir /var/lib/nlsr/new_router4 && \
mkdir /var/lib/nlsr/new_router5 && \
mkdir /var/lib/nlsr/new_router6 && \
mkdir /var/lib/nlsr/new_router7 && \
mkdir /var/lib/nlsr/new_pc && \
mkdir /var/lib/nlsr/new_server1 && \
mkdir /var/lib/nlsr/new_server2 && \
mkdir /var/lib/nlsr/new_server3 && \
mkdir /var/lib/nlsr/new_server4
COPY script/ ./
