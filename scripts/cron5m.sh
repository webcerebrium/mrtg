#!/bin/bash
export LANG=C
if [ ! -d /var/lock/mrtg ]; then mkdir /var/lock/mrtg; fi;
netstat -an > /var/log/netstat.log
/usr/bin/mrtg /etc/mrtg/mrtg.cfg --logging /var/www/mrtg/mrtg.log
echo > /var/log/iostat.log
