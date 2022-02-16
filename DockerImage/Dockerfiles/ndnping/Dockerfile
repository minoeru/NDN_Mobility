FROM minoeru/nlsr:base
MAINTAINER minoeru

USER root
RUN mkdir my_conf
COPY my_conf/ndnping ./my_conf
RUN ldconfig && \
mkdir /var/lib/nlsr/router1 && \
mkdir /var/lib/nlsr/router2 && \
mkdir /var/lib/nlsr/router3 && \
mkdir /var/lib/nlsr/router4 && \
mkdir /var/lib/nlsr/router5 && \
mkdir /var/lib/nlsr/router6 && \
mkdir /var/lib/nlsr/router7 && \
mkdir /var/lib/nlsr/router8 && \
mkdir /var/lib/nlsr/router9 && \
mkdir /var/lib/nlsr/router10