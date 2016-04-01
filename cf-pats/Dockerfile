FROM golang:1.6-alpine

RUN apk add --update git bzr \
  && rm -rf /var/cache/apk/* \
  && go get -d github.com/cloudfoundry-incubator/pat \
  && cd $GOPATH/src/github.com/cloudfoundry-incubator/pat \
  && go install \
  && go get -d github.com/cloudfoundry/cli || true \
  && cd $GOPATH/src/github.com/cloudfoundry/cli \
  && CGO_ENABLED=0 go build -o $GOPATH/bin/cf ./main \

