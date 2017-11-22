FROM ruby:2.4-alpine

ENV BOSH_INIT_VERSION 0.0.100
ENV BOSH_INIT_URL https://s3.amazonaws.com/bosh-init-artifacts/bosh-init-${BOSH_INIT_VERSION}-linux-amd64
ENV BOSH_INIT_PACKAGES "wget libc6-compat bash openssl build-base"

RUN apk add --update ${BOSH_INIT_PACKAGES} && rm -rf /var/cache/apk/*
RUN ln -s /lib/ /lib64 # FIXME: Remove for Alpine >= 3.6

RUN wget -q -O /usr/local/bin/bosh-init --no-check-certificate ${BOSH_INIT_URL}
RUN chmod +x /usr/local/bin/bosh-init

ENV BOSH_AWS_CPI_URL https://bosh.io/d/github.com/cloudfoundry-incubator/bosh-aws-cpi-release?v=62
ENV BOSH_AWS_CPI_CHECKSUM f36967927ceae09e5663a41fdda199edfe649dc6

COPY bosh_init_cache /tmp/bosh_init_cache/
RUN /tmp/bosh_init_cache/seed_bosh_init_cache.sh && \
    rm -rf /tmp/bosh_init_cache
