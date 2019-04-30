FROM php:7.3-apache-stretch
MAINTAINER Gideon van der Merwe "appiusa@gmail.com"
ENV REFRESHED_AT 2019-04-30

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libpng-dev \
    php7.3-xml

RUN docker-php-ext-install -j$(nproc) opcache mysqli pdo_mysql xml zip && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

RUN a2enmod rewrite

#COPY ioncube/ioncube_loader_lin_7.2.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718
COPY config/php.ini /usr/local/etc/php/
