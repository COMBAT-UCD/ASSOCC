# Adapted from tutorial found at https://forum.comses.net/t/containerizing-a-netlogo-model-in-headless-mode/8162
FROM openjdk:8-jdk

ARG NETLOGO_VERSION=6.1.1
ARG NETLOGO_NAME=NetLogo-$NETLOGO_VERSION
ARG NETLOGO_URL=https://ccl.northwestern.edu/netlogo/$NETLOGO_VERSION/$NETLOGO_NAME-64.tgz


ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN mkdir /usr/lib/netlogo \
 && wget $NETLOGO_URL \
 && tar xzf $NETLOGO_NAME-64.tgz -C /usr/lib/netlogo --strip-components=1 \
 && rm $NETLOGO_NAME-64.tgz 

RUN sed -i 's/-Xmx1024m/-Xmx4096m/g' /usr/lib/netlogo/netlogo-headless.sh

RUN mkdir -p /var/model

VOLUME [ "/var/model/results", "/var/model/data" ]

WORKDIR /var/model

COPY simulation_model /var/model/simulation_model
COPY simulate.sh simulate.sh

RUN chmod +x simulate.sh

ENTRYPOINT [ "/var/model/simulate.sh" ]
CMD [ "experiment" ]
