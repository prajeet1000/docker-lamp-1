FROM mattrayner/lamp:latest-1804

# Your custom commands

CMD ["/run.sh"]

CMD service apache2 start && service mysql start && tail -f /dev/null
