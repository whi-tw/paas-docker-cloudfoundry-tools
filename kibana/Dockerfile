FROM docker.elastic.co/kibana/kibana-oss:6.4.3

USER root

RUN curl -sSL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /usr/local/bin/jq && \
    chmod +x /usr/local/bin/jq

COPY entrypoint.sh /usr/local/bin/docker_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]

CMD ["/usr/local/bin/kibana-docker"]

USER kibana
