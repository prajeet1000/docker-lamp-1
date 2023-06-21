#Base image
FROM php:7.2-apache

#Install musqli
RUN docker-php-ext-install mysqli

RUN apt update && apt install -y git
RUN git clone https://github.com/prajeet1000/docker-lamp-1.git

RUN chmod -R 755 /var/www/html && chown -R $user:$user /var/www/html/
RUN cp -r docker-lamp-1/* /var/www/html/
EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
