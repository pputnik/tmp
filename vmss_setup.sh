#!/bin/bash -vx

if [ "x$1" = "x" ] ; then
    echo usage: $0 logger_host_or_ip
        exit -1
fi

# for Ubuntu on azure!

echo 'postfix postfix/mailname string your.hostname.com' | debconf-set-selections
echo 'postfix postfix/main_mailer_type string "Internet Site"' | debconf-set-selections
/usr/bin/apt-get install postfix mailutils -y

touch /var/log/num.log
chmod 666 /var/log/num.log

wget https://raw.githubusercontent.com/pputnik/tmp/master/pinger.sh
mv pinger.sh /tmp/pinger.sh
chmod 755 /tmp/pinger.sh 

sed -i "s/logger/$1/" /tmp/pinger.sh
sed -i "s/myId/`hostname`/" /tmp/pinger.sh

# old cron tasks will be deleted! Modify if needed
echo "* * * * * /tmp/pinger.sh >> /var/log/num.log 2>&1" > /var/spool/cron/crontabs/azureuser
chmod 600 /var/spool/cron/crontabs/azureuser 
chown azureuser.azureuser /tmp/pinger.sh /var/log/num.log /var/spool/cron/crontabs/azureuser 

/etc/init.d/cron restart
