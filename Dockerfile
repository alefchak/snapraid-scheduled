FROM alpine:3

RUN set -eux ;\
    apk add --no-cache --update smartmontools python3 supervisor ;\
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing snapraid ;\
    apk add --no-cache --virtual .deps curl ;\
    mkdir -p /opt/snapraid-runner ;\
    curl -o /usr/bin/snapraid-runner.py https://raw.githubusercontent.com/Chronial/snapraid-runner/master/snapraid-runner.py ;\
    chmod +x /usr/bin/snapraid-runner.py ;\
    mkdir -p /var/log/supervisor ;\
    apk del .deps

COPY supervisor_snapraid.ini /etc/supervisor.d/
COPY scripts/* /usr/bin/

VOLUME /config

ENV CRON_BACKUP_EXPRESSION "0 0 * * *"

ENTRYPOINT ["supervisord"]
CMD ["-c", "/etc/supervisord.conf"]
