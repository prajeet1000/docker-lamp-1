#Base image
FROM php:7.2-apache

#Install musqli
RUN docker-php-ext-install mysqli

RUN apt update && apt install -y git
RUN git clone https://github.com/prajeet1000/docker-lamp-1.git

RUN chmod -R 755 /var/www/html && chown -R $user:$user /var/www/html/
RUN cp -r docker-lamp-1/* /var/www/html/
RUN a2enmod headers

RUN echo "ServerTokens Prod" >> /etc/apache2/apache2.conf \
    && echo "ServerSignature Off" >> /etc/apache2/apache2.conf \
    && echo "Header always unset X-Powered-By" >> /etc/apache2/apache2.conf \
    && echo "Header always append X-Powered-By Prajeet-devops" >> /etc/apache2/apache2.conf

#RUN echo "Header always set X-Frame-Options SAMEORIGIN" >> /etc/apache2/apache2.conf \
#    && echo "Header always set X-Content-Type-Options nosniff" >> /etc/apache2/apache2.conf \
#    && echo "Header always set X-XSS-Protection '1; mode=block'" >> /etc/apache2/apache2.conf \
 #   && echo "Header always set Cache-Control 'no-store'" >> /etc/apache2/apache2.conf \
  #  && echo "Header always set Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload'" >> /etc/apache2/apache2.conf \
#    && echo "Header always set Access-Control-Allow-Origin '*'" >> /etc/apache2/apache2.conf \
 #   && echo "Header always set Content-Security-Policy \"default-src 'self'\"" >> /etc/apache2/apache2.conf
#RUN sed -i '/<VirtualHost \*:443>/a SSLProtocol all -SSLv2 -SSLv3 -TLSv1 -TLSv1.1' /etc/apache2/sites-available/default-ssl.conf \
  #  && sed -i '/<VirtualHost \*:443>/a SSLProtocol +TLSv1.2 +TLSv1.3' /etc/apache2/sites-available/default-ssl.conf

EXPOSE 80
RUN service apache2 start

CMD ["apache2ctl", "-D", "FOREGROUND"]
RUN apache2ctl configtest

