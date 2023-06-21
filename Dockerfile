FROM dockette/devstack

# Your custom commands

CMD ["/run.sh"]

CMD service apache2 start && service mysql start && tail -f /dev/null
