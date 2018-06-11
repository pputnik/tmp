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

############ part2
# https://blogs.technet.microsoft.com/mohammedabutaleb/2017/10/07/collect-linux-data-using-custom-json-data-source/
wget https://raw.githubusercontent.com/pputnik/tmp/master/pinger2.sh
mv pinger2.sh /tmp/pinger2.sh
chmod 755 /tmp/pinger2.sh
chown omsagent:omiusers /tmp/pinger2.sh
WsCustomerId=$(ls  /etc/opt/microsoft/omsagent/ |awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- | tail -n 1)

wget https://raw.githubusercontent.com/pputnik/tmp/master/serverdetails.conf
mv serverdetails.conf /etc/opt/microsoft/omsagent/$WsCustomerId/conf/omsagent.d/
sed -i 's/WsCustomerId/$WsCustomerId/g' /etc/opt/microsoft/omsagent/$WsCustomerId/conf/omsagent.d/serverdetails.conf