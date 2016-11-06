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

# Download novosga from official github
RUN git clone https://github.com/novosga/novosga.git

# Change permissions
RUN chown www-data:www-data /var/www/html/novosga/
RUN chmod 777 /var/www/html/novosga/var/ && chmod 777 /var/www/html/novosga/config/
RUN a2enmod rewrite

# install novosga
RUN cd /var/www/html/novosga && composer install
