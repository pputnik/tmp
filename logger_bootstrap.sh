#!/bin/bash -v

if [ "x$1" = "x" ] ; then
    echo usage: $0 recipient_email
        exit -1
fi


#apt-get install munin munin-common munin-node munin-plugins-extra libwww-perl lynx apache2 php7.0 php7.0-cgi php7.0-cli php7.0-common libapache2-mod-php7.0 -y

apt-get install lynx apache2 php7.0 php7.0-cgi php7.0-cli php7.0-common libapache2-mod-php7.0 -y

# insert alias at 14th line
#sed '14i Alias /_munin /var/cache/munin/www' /etc/apache2/sites-enabled/000-default.conf -i
#sed '15i <Directory /var/cache/munin/www>' /etc/apache2/sites-enabled/000-default.conf -i
#sed '16i         Require all granted' /etc/apache2/sites-enabled/000-default.conf -i
#sed '17i </Directory>' /etc/apache2/sites-enabled/000-default.conf -i

/usr/bin/wget --no-cache https://raw.githubusercontent.com/pputnik/tmp/master/pinger.php 
mv pinger.php /var/www/html/
mkdir /var/cache/munin/vmss -p
#chown munin.munin /var/cache/munin/vmss
chmod 777 /var/cache/munin/vmss


/usr/sbin/apachectl restart

cd /root
/usr/bin/wget --no-cache https://raw.githubusercontent.com/pputnik/tmp/master/check_statuses.sh
chmod 700 /root/check_statuses.sh


ct=$(echo "MAILTO=$1"; echo '* * * * * /root/check_statuses.sh');	# thus we'll have two lines in one variable, separated by "\n". Needed for crontab.
echo "$ct" | crontab -
