#!/bin/bash -v

apt-get install munin munin-common munin-node munin-plugins-extra libwww-perl lynx apache2 -y
sed '14i Alias /_munin /var/cache/munin/www' /etc/apache2/sites-enabled/000-default.conf -i
/usr/sbin/apachectl restart

