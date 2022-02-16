FROM minoeru/nlsr:base
MAINTAINER minoeru

USER root
RUN apt install -y tcpdump
RUN mkdir my_conf
COPY my_conf/<name> ./my_conf
RUN ldconfig && \
#<mkdir>
COPY script/ ./
