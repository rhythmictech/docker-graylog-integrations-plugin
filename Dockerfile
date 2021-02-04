FROM busybox:stable AS builder

# TODO: should this be a build arg, hardcoded, or env (like it is currently)
ENV GRAYLOG_VERSION=4.0.2

WORKDIR /

RUN wget downloads.graylog.org/releases/graylog-integrations/graylog-integrations-plugins-${GRAYLOG_VERSION}.tgz \
    && tar -zxvf graylog-integrations-plugins-${GRAYLOG_VERSION}.tgz

FROM graylog/graylog:4.0.2

LABEL org.opencontainers.image.source https://github.com/rhythmictech/docker-graylog-integrations-plugin
ENV GRAYLOG_VERSION=4.0.2

COPY --from=builder /graylog-integrations-plugins-${GRAYLOG_VERSION}/plugin/graylog-plugin-integrations-${GRAYLOG_VERSION}.jar /usr/share/graylog/plugin
