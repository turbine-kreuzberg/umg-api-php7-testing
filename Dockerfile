FROM php:7.0.10-cli

RUN docker-php-ext-install pdo_mysql

RUN apt-get update
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip

ADD https://getcomposer.org/installer composer-setup.php
RUN php composer-setup.php && unlink composer-setup.php

RUN apt-get install -y git
RUN git clone -b php7 https://github.com/phpredis/phpredis.git
RUN cd phpredis && phpize && ./configure && make && make install && cd .. && rm -rf ./phpredis
RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
