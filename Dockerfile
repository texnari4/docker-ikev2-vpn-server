FROM alpine:3.17

LABEL tags="alpine-3.17" \
      build_ver="13-02-2023"

COPY etc /etc
COPY usr/bin /usr/bin

RUN apk add --no-cache \
                strongswan=5.9.8-r1 \
                    && rm -rf /var/cache/apk/* \
                    && rm -f /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["start-vpn"]

