#
# Application
#
FROM php:8.1.4-fpm

RUN docker-php-ext-install pdo_mysql

COPY --from=composer:2.3.2 /usr/bin/composer /usr/local/bin/composer

COPY /app /var/www/app

WORKDIR /var/www/app/

RUN apt-get update \
    && apt-get install -y git \
    curl \
    libzip-dev \
    zip \
    sudo \
    unzip \
    make \
  && docker-php-ext-install zip

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN make setup \
    && make test

CMD ["php-fpm"]

EXPOSE 9000