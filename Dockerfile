ARG ARCH=amd64
ARG OS_VERSION=3.11
FROM localhost/${ARCH}/alpine:${OS_VERSION}

LABEL maintainer="Dominik Lenhardt <dom@onkeldom.eu>"

RUN /sbin/apk --update --no-cache add dhcp libcap supervisor && \
    /usr/sbin/setcap 'cap_net_bind_service=+ep' /usr/sbin/dhcpd && \
    /bin/touch /var/lib/dhcp/dhcpd.leases && \
    /bin/touch /var/lib/dhcp/dhcpd6.leases

COPY dhcpd.conf dhcpd6.conf rndc.key /etc/dhcp/
COPY supervisord.conf /etc/

EXPOSE 67/udp 67/tcp

ENTRYPOINT ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
