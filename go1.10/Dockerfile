FROM ubuntu:trusty

RUN \
  apt-get update && \
  apt-get -y install \
    build-essential \
    wget \
    curl \
    openssh-client \
    unzip \
    git \
  && rm -rf /var/lib/apt/lists/*

ENV GOPATH /go
ENV PATH /go/bin:/usr/local/go/bin:$PATH
RUN \
  wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz -P /tmp && \
  tar xzvf /tmp/go1.10.2.linux-amd64.tar.gz -C /usr/local && \
  mkdir $GOPATH && \
  rm -rf /tmp/*

RUN go get github.com/tools/godep
RUN go get github.com/onsi/ginkgo/ginkgo

