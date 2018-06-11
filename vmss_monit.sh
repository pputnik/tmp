#!/bin/bash -vx

# for Ubuntu on azure!

touch /var/log/num.log
chmod 666 /var/log/num.log

wget https://raw.githubusercontent.com/pputnik/tmp/master/pinger.sh
mv pinger.sh /tmp/pinger.sh
chmod 755 /tmp/pinger.sh

# old cron tasks will be deleted! Modify if needed
echo "* * * * * /tmp/pinger.sh" > /var/spool/cron/crontabs/azureuser
chown azureuser.azureuser /tmp/pinger.sh /var/spool/cron/crontabs/azureuser /var/log/num.log

echo whoami $(whoami)
/etc/init.d/cron restart
