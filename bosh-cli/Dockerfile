FROM ruby:2.2-alpine

RUN apk add --update openssl openssh-client file git && rm -rf /var/cache/apk/*
ADD Gemfile /
RUN bundle install


