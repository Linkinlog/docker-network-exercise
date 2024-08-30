FROM caddy:2.8.4-builder AS builder

RUN xcaddy build \
    --with github.com/caddyserver/nginx-adapter \
    --with github.com/hairyhenderson/caddy-teapot-module@v0.0.3-0

FROM php:8.3.10-fpm-alpine3.20 as server

WORKDIR /app

RUN apk update && apk add --no-cache supervisor

COPY build/option4/php-fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY build/option4/supervisord.conf /etc/supervisord.conf
COPY build/option4/server.Caddyfile /app/Caddyfile
COPY src/index.php /app/index.php
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN /usr/bin/caddy fmt --overwrite

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
