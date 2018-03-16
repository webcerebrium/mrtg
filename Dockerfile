FROM ubuntu

# install SNMP and MRTG
RUN apt-get update \
 && apt-get install -y software-properties-common \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install sysstat snmp libnet-snmp-perl libcrypt-hcesha-perl libcrypt-des-perl libdigest-hmac-perl snmp snmpd libsnmp-dev rrdtool mrtg \
 && apt-get -y install snmp-mibs-downloader

# install LIGHTTTPD to serve stats
# TODO: append authorization
RUN apt-get -y install lighttpd \
 && sed -i -e 's/= "\/var\/www\/html/= "\/var\/www\//g' /etc/lighttpd/lighttpd.conf \
 && sed -i -e 's/= 80/= 681/g' /etc/lighttpd/lighttpd.conf \
 && echo mrtg:mrtg > /etc/lighttpd/lighttpd.passwd \
 && lighty-enable-mod auth \
 && lighty-enable-mod ssi \
 && service lighttpd start

RUN mkdir /var/www/mrtg /opt/cron.d /opt/mrtg
ADD scripts/*.sh /opt/mrtg/
ADD etc/ /etc/

# TOTO: detect real harddrives (affects on cron1m.sh), real network identifiers
# if mysql is an option, add mysql section
# if there are other sections as environment variables, add them to

# READY TO UPDATE IT THE FIRST TIME
RUN chmod +x /opt/mrtg/*.sh && bash /opt/mrtg/update.sh

# TODO: add crontab
copy cron.d /opt/

EXPOSE 681

CMD bash scripts/init.sh
