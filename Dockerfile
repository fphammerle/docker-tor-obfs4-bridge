# https://pkgs.alpinelinux.org/packages?name=lyrebird&arch=x86_64
FROM docker.io/alpine:3.18.2

# https://gitweb.torproject.org/tor.git/plain/ChangeLog
# https://git.alpinelinux.org/aports/log/community/tor?h=3.18-stable
ARG TOR_PACKAGE_VERSION=0.4.8.5-r0
# https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird/-/blob/main/ChangeLog
# https://git.alpinelinux.org/aports/log/testing/lyrebird
# https://gitlab.com/yawning/obfs4/-/blob/master/ChangeLog
# https://git.alpinelinux.org/aports/log/testing/obfs4proxy
# https://git.alpinelinux.org/aports/commit/?id=08aa4bff0894ead479db96642aac67a4a0d1835
ARG LYREBIRD_PACKAGE_VERSION=0.1.0-r0
RUN apk add --no-cache tor=$TOR_PACKAGE_VERSION \
    && apk add --no-cache lyrebird=$LYREBIRD_PACKAGE_VERSION \
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
LABEL org.opencontainers.image.title="tor bridge providing obfs4 obfuscation protocol via lyrebird" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-tor-obfs4-bridge" \
    org.opencontainers.image.revision="$REVISION"
