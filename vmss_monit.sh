#!/bin/bash -vx

echo whoami $(whoami)
pwd

# for Ubuntu on azure!
touch /var/log/num.log
chmod 666 /var/log/num.log

wget https://raw.githubusercontent.com/pputnik/tmp/master/pinger.sh
mv pinger.sh /tmp/pinger.sh
chmod 755 /tmp/pinger.sh

# old cron tasks will be deleted! Modify if needed
echo "* * * * * /tmp/pinger.sh" > /var/spool/cron/crontabs/azureuser
chmod 600 /var/spool/cron/crontabs/azureuser 
chown azureuser.azureuser /tmp/pinger.sh /var/log/num.log /var/spool/cron/crontabs/azureuser 

/etc/init.d/cron restart
sleep 20
/etc/init.d/cron restart

