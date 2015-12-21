FROM alpine:3.2

RUN apk add --update bash haproxy inotify-tools

COPY ./haproxy.cfg.d/ /etc/haproxy/haproxy.cfg.d
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

EXPOSE 5000
