#Base image
FROM php:7.2-apache

#Install musqli
RUN docker-php-ext-install mysqli

RUN chmod -R 755 /var/www/html && chown -R $user:$user /var/www/html/
