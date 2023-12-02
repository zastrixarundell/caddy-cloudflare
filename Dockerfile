FROM caddy:2.7.5-builder-alpine AS builder

RUN xcaddy build \
    -- with https://github.com/caddy-dns/cloudflare

FROM caddy:2.7.5-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy