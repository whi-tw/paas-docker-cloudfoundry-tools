FROM alpine:3.3

ENV SPRUCE_VERSION 0.13.0

RUN apk add --update wget ca-certificates \
  && wget https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce_${SPRUCE_VERSION}_linux_amd64.tar.gz \
  && tar -xvzf spruce_${SPRUCE_VERSION}_linux_amd64.tar.gz \
  && mv spruce_${SPRUCE_VERSION}_linux_amd64/spruce /usr/local/bin/ \
  && rm -rf spruce_${SPRUCE_VERSION}_linux_amd64* \
  && apk del wget ca-certificates \
  && rm -rf /var/cache/apk/*

