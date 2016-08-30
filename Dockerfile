FROM php:7.0.10-cli

RUN docker-php-ext-install pdo_mysql

RUN apt-get update && \
  apt-get install -y libzip-dev && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-install zip

RUN curl -o composer-setup.php https://getcomposer.org/installer && php composer-setup.php && unlink composer-setup.php

RUN apt-get update && \
  apt-get install -y git && \
  rm -rf /var/lib/apt/lists/*

RUN git clone -b php7 https://github.com/phpredis/phpredis.git
RUN cd phpredis && phpize && ./configure && make && make install && cd .. && rm -rf ./phpredis
RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
