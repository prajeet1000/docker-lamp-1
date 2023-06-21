FROM lampson0505/ubuntu-phy


CMD service apache2 start && service mysql start && tail -f /dev/null
