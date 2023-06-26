# Use a base image with Java
FROM adoptopenjdk:11-jdk-hotspot

# Set environment variables
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_VERSION 3.8.2
ENV PATH $MAVEN_HOME/bin:$PATH


# Install Maven
RUN apt-get update && \
    apt-get install -y wget && \
    wget --no-verbose -O /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz && \
    tar xf /tmp/apache-maven.tar.gz -C /usr/share && \
    mv /usr/share/apache-maven-3.9.2 $MAVEN_HOME && \
    ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn && \
    rm -f /tmp/apache-maven.tar.gz



# Copy project files into the container
COPY . /usr/share/maven
WORKDIR /usr/share/maven
RUN chmod -R 777 /usr/share/maven && chown -R $user:$user /usr/share/maven
# Build your project with Maven
RUN mvn clean install

# Specify the command to run when the container starts
CMD ["java", "-jar", "target/myproject.jar"]
#RUN cp -rf /usr/share/maven/ ./mnt/maven-code/













#Base image
FROM php:7.2-apache

#Install musqli
RUN docker-php-ext-install mysqli


RUN a2enmod headers
RUN echo "ServerTokens Prod" >> /etc/apache2/apache2.conf \
    && echo "ServerSignature Off" >> /etc/apache2/apache2.conf \
    && echo "Header always unset X-Powered-By" >> /etc/apache2/apache2.conf \
    && echo "Header always append X-Powered-By Prajeet-devops" >> /etc/apache2/apache2.conf

RUN echo "Header always set X-Frame-Options SAMEORIGIN" >> /etc/apache2/apache2.conf \
    && echo "Header always set X-Content-Type-Options nosniff" >> /etc/apache2/apache2.conf \
    && echo "Header always set X-XSS-Protection '1; mode=block'" >> /etc/apache2/apache2.conf \
    && echo "Header always set Cache-Control 'no-store'" >> /etc/apache2/apache2.conf \
    && echo "Header always set Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload'" >> /etc/apache2/apache2.conf \
    && echo "Header always set Access-Control-Allow-Origin '*'" >> /etc/apache2/apache2.conf \
    && echo "Header always set Content-Security-Policy \"default-src 'self'\"" >> /etc/apache2/apache2.conf
RUN sed -i '/<VirtualHost \*:443>/a SSLProtocol all -SSLv2 -SSLv3 -TLSv1 -TLSv1.1' /etc/apache2/sites-available/default-ssl.conf \
    && sed -i '/<VirtualHost \*:443>/a SSLProtocol +TLSv1.2 +TLSv1.3' /etc/apache2/sites-available/default-ssl.conf

    
    # Remove X-Powered-By header
RUN echo "Header unset X-Powered-By" >> /etc/apache2/conf-available/docker-php.conf \
    && a2enconf docker-php


RUN apt update && apt install -y git
RUN git clone https://github.com/prajeet1000/docker-lamp-1.git

RUN chmod -R 755 /var/www/html && chown -R $user:$user /var/www/html/
RUN cp -r docker-lamp-1/* /var/www/html/
RUN mkdir -p /var/lib/jenkins/workspace/mymavenproject12 && cp -r docker-lamp-1/pom.xml /var/lib/jenkins/workspace/mymavenproject12/
EXPOSE 80 9000
RUN service apache2 start


CMD ["apache2ctl", "-D", "FOREGROUND"]







