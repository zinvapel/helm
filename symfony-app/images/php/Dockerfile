FROM php:7.4-fpm

WORKDIR /
RUN apt-get update && apt-get install -y \
        openssl \
        curl \
        wget \
        git \
        unzip \
        libpq-dev \
        libicu-dev \
        libcurl4-openssl-dev \
        libxml2-dev

RUN docker-php-ext-install pdo pdo_pgsql intl curl json opcache xml
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN wget -O /usr/bin/composer https://getcomposer.org/composer-1.phar && chmod +x /usr/bin/composer

ARG TAG=master
# URL ENCODED
ARG REPO
ARG APP_ENV=prod

RUN rm -rf /var/www && git clone --depth 1 --branch $TAG $REPO /var/www
WORKDIR /var/www

RUN composer install --ignore-platform-reqs --no-dev --optimize-autoloader --no-scripts
RUN APP_ENV=${APP_ENV} bin/console cache:warmup
RUN cp var/cache/prod/*.preload.php var/cache/prod/preload.php || echo '<?php' >> var/cache/prod/preload.php
RUN sed "s%;opcache.preload=%opcache.preload=/var/www/var/cache/prod/preload.php%g" $PHP_INI_DIR/php.ini > /dev/null
RUN chmod -R 777 /var/www
