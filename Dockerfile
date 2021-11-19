# https://pkgs.alpinelinux.org/packages?name=obfs4proxy&arch=x86_64
FROM alpine:3.14.3

ARG TOR_PACKAGE_VERSION=0.4.5.10-r0
ARG OBFS4PROXY_PACKAGE_VERSION=0.0.11-r4
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

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="tor bridge providing obfs4 obfuscation protocol" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-tor-obfs4-bridge" \
    org.opencontainers.image.revision="$REVISION"
