#!/bin/bash -vx


touch /var/log/num.log
chmod 666 /var/log/num.log
echo "* * * * * /tmp/pinger.sh" > /var/spool/cron/nobody

mv pinger.sh /tmp/pinger.sh
chmod 700 /tmp/pinger.sh
chown nobody.nobody /tmp/pinger.sh /var/spool/cron/nobody