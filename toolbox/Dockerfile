FROM ubuntu:14.04

ENV PACKAGES "coreutils openssl curl ca-certificates"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y --no-install-recommends ${PACKAGES}
