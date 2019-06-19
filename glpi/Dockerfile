# Referance Image: https://hub.docker.com/_/php
FROM php:7.2-apache

# Install MySQLi PHP Extension
RUN docker-php-ext-install -j$(nproc) mysqli

# Change Apache settings
#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

COPY glpi/. /var/www/html/
