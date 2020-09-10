FROM golang:1.13.10-alpine AS ofelia
ARG OFELIA_VERSION=0.3.0

RUN apk --no-cache add gcc musl-dev

WORKDIR ${GOPATH}/src/github.com/mcuadros/ofelia
RUN wget -O - https://github.com/mcuadros/ofelia/archive/v${OFELIA_VERSION}.tar.gz | \
    tar -xz --strip 1 -C ${GOPATH}/src/github.com/mcuadros/ofelia

RUN go build -o /go/bin/ofelia .


FROM azinchen/duplicacy AS duplicacy


FROM alpine:3.11
MAINTAINER Nekmo com <contacto@nekmo.com>

COPY --from=ofelia /go/bin/ofelia /usr/bin/ofelia
COPY --from=duplicacy /usr/bin/duplicacy /usr/bin/duplicacy

RUN mkdir /app && mkdir /duplicacy
WORKDIR /app

ADD *.sh ./
RUN chmod +x *.sh

WORKDIR /duplicacy

VOLUME ["/duplicacy/.duplicacy", "/etc/ofelia"]
ENTRYPOINT ["/app/entrypoint.sh"]
