FROM ubuntu

# installing packages for Lighttpd (to serve frontend) and System monitoring, including MRTG
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cron \
  libcrypt-hcesha-perl \
  libcrypt-des-perl \
  libdigest-hmac-perl \
  libnet-snmp-perl \
  libsnmp-dev \
  lighttpd \
  snmp \
  snmpd \
  rrdtool \
  mrtg \
  snmp \
  snmp-mibs-downloader \
  software-properties-common \
  sysstat \
 && sed -i -e 's/= "\/var\/www\/html/= "\/var\/www\//g' /etc/lighttpd/lighttpd.conf \
 && sed -i -e 's/= 80/= 681/g' /etc/lighttpd/lighttpd.conf \
 && lighty-enable-mod auth \
 && lighty-enable-mod ssi \
 && mkdir -p /opt/mrtg

COPY etc/* /etc/
COPY scripts/*.sh /opt/mrtg/
COPY cron.d/* /etc/cron.d/

CMD chmod /opt/mrtg/*.sh && bash /opt/mrtg/init.sh

EXPOSE 681
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

