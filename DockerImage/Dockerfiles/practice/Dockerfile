FROM minoeru/nlsr:base
MAINTAINER minoeru

USER root
RUN mkdir my_conf
COPY my_conf/practice ./my_conf
RUN ldconfig && \
mkdir /var/lib/nlsr/r1 && \
mkdir /var/lib/nlsr/r2 && \
mkdir /var/lib/nlsr/r3