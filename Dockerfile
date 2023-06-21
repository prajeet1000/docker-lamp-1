FROM mattrayner/lamp:latest-1804

# Your custom commands

CMD ["/run.sh"]
RUN apt-get update && apt-get upgrade -y

EXPOSE 80
EXPOSE 3306

RUN apt update && git clone https://github.com/prajeet1000/docker-lamp-1.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/html/*
RUN cp -r docker-lamp-1/* /var/www/html/

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /dev/null
