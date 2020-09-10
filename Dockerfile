FROM alpine:3.11
MAINTAINER Nekmo com <contacto@nekmo.com>

#--
#-- Build variables
#--
ARG DUPLICACY_VERSION=2.6.2
ARG OFELIA_VERSION=0.3.0


#--
#-- Environment variables
#--


#--
#-- Build steps
#--
RUN apk --no-cache add ca-certificates tzdata libc6-compat && update-ca-certificates
RUN wget https://github.com/gilbertchen/duplicacy/releases/download/v${DUPLICACY_VERSION}/duplicacy_linux_x64_${DUPLICACY_VERSION} -O /usr/bin/duplicacy && \
    chmod +x /usr/bin/duplicacy
RUN wget -O - https://github.com/mcuadros/ofelia/releases/download/v${OFELIA_VERSION}/ofelia-v${OFELIA_VERSION}-linux-amd64.tar.gz | tar -xz -C /usr/bin/ && \
    chmod +x /usr/bin/ofelia

RUN mkdir /app && mkdir /duplicacy
WORKDIR /app

ADD *.sh ./
RUN chmod +x *.sh

WORKDIR /duplicacy

VOLUME ["/duplicacy/.duplicacy", "/etc/ofelia"]
ENTRYPOINT ["/app/entrypoint.sh"]
