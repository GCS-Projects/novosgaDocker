# Image official of php 5.6 with apache
FROM php:5-apache

MAINTAINER Baldissera <guilhermebaldissera@hotmail.com>

COPY ./php.ini /usr/local/etc/php/

# Update
RUN apt-get update

# Need for novosga
RUN docker-php-ext-install mysql mysqli gettext pdo_mysql

# Install git extensions
 RUN apt-get install -y git

# Download composer install
 RUN curl –sS https://getcomposer.org/installer | php
 RUN mv composer.phar /usr/local/bin/composer