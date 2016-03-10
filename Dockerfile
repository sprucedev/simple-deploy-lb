FROM alpine:3.2

RUN apk add --update bash haproxy inotify-tools

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg
CMD ["/usr/sbin/haproxy", "-db", "-f", "/etc/haproxy/haproxy.cfg"]

EXPOSE 5000
