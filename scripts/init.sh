#!/bin/bash

DISKS=`/sbin/parted -l | grep /dev | grep -v mapper | awk '{print $2;}'| tr '\n' ' ' | sed -e 's/://'`
echo "#!/bin/bash" > /opt/mrtg/cron1m.sh 
echo "iostat -x $DISKS 4 12 >> /var/log/iostat.log" >> /opt/mrtg/cron1m.sh

bash /opt/mrtg/update.sh

