FROM ubuntu:16.04
RUN apt-get update && apt-get upgrade -y


RUN debconf-set-selections /tmp/debconf.selections

RUN apt-get install -y zip unzip \
    php7.2 \
    php7.2-bz2 \
    php7.2-cgi \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-dev \
    php7.2-enchant \
     php7.2-fpm \
    php7.2-gd \
    php7.2-gmp \
    php7.2-imap \
    php7.2-interbase \
    php7.2-intl \
    php7.2-json \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-odbc \
    php7.2-opcache \
    php7.2-pgsql \
    php7.2-phpdbg \
    php7.2-pspell \
    php7.2-readline \
    php7.2-recode \
    php7.2-snmp \
    php7.2-sqlite3 \
    php7.2-sybase \
    php7.2-tidy \
    php7.2-xmlrpc \
    php7.2-xsl \
    php7.2-zip \
    apache2 libapache2-mod-php7.2 \
    mariadb-common mariadb-server mariadb-client \
     postfix \
    git nodejs npm composer nano tree vim curl ftp

RUN npm install -g bower grunt-cli gulp
RUN a2enmod rewrite
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
EXPOSE 3306

RUN apt update && git clone https://github.com/prajeet1000/docker-lamp-1.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/html/*
RUN cp -r docker-lamp-1/* /var/www/html/

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /dev/null
