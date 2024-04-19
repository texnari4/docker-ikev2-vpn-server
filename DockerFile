FROM alpine:3.15

LABEL tags="alpine-3.15" \
      build_ver="01-01-2022"

COPY etc /etc
COPY usr/bin /usr/bin

RUN apk add --no-cache \
    strongswan=5.9.12-r0 \
    && rm -rf /var/cache/apk/* \
    && rm -f /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["start-vpn"]