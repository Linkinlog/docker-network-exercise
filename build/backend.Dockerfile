FROM phpswoole/swoole:5.1-php8.2 AS server

COPY ./src/server.php /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD ["php", "/var/www/html/server.php"]
