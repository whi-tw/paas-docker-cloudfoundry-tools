FROM ruby:2.2-alpine

RUN gem install bosh_cli -v 1.3232.0 --no-rdoc --no-ri

RUN apk add --update bash openssl openssh-client file git && rm -rf /var/cache/apk/*

ARG BOSH_ID_RSA
ARG BOSH_IP
ARG BOSH_ADMIN_PASSWORD

ENV BOSH_ID_RSA=$BOSH_ID_RSA
ENV BOSH_IP=$BOSH_IP
ENV BOSH_ADMIN_PASSWORD=$BOSH_ADMIN_PASSWORD

RUN bosh -t "$BOSH_IP" login admin -- "$BOSH_ADMIN_PASSWORD"
RUN bosh target "$BOSH_IP"
