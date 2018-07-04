#!/bin/bash -v

apt-get install munin munin-common munin-node munin-plugins-extra libwww-perl lynx apache2 php7.0 php7.0-cgi php7.0-cli php7.0-common libapache2-mod-php7.0 -y

# insert alias at 14th line
sed '14i Alias /_munin /var/cache/munin/www' /etc/apache2/sites-enabled/000-default.conf -i
sed '15i <Directory /var/cache/munin/www>' /etc/apache2/sites-enabled/000-default.conf -i
sed '16i         Require all granted' /etc/apache2/sites-enabled/000-default.conf -i
sed '17i </Directory>' /etc/apache2/sites-enabled/000-default.conf -i

/usr/bin/wget --no-cache https://raw.githubusercontent.com/pputnik/tmp/master/pinger.php 
mv pinger.php /var/www/html/
mkdir /var/cache/munin/vmss
chown munin.munin /var/cache/munin/vmss
chmod 777 /var/cache/munin/vmss


/usr/sbin/apachectl restart

