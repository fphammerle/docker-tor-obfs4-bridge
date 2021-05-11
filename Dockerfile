# https://pkgs.alpinelinux.org/packages?name=obfs4proxy&arch=x86_64
FROM alpine:3.13.5

ARG TOR_PACKAGE_VERSION=0.4.3.5-r0
ARG OBFS4PROXY_PACKAGE_VERSION=0.0.11-r2
RUN apk add --no-cache tor=$TOR_PACKAGE_VERSION \
    && apk add --no-cache obfs4proxy=$OBFS4PROXY_PACKAGE_VERSION \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

#RUN apk add --no-cache \
#        less \
#        man-db \
#        tor-doc=$TOR_PACKAGE_VERSION
#ENV PAGER=less

ENV OR_PORT=
ENV PT_PORT=
ENV CONTACT_INFO=
COPY torrc.template entrypoint.sh /
RUN chmod -c a+rX /torrc.template /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER tor
VOLUME /var/lib/tor
CMD ["tor", "-f", "/tmp/torrc"]
