#!/bin/bash
/usr/bin/indexmaker --title="`hostname -s | tr [:lower:] [:upper:]` MRTG" --pagetop="<CENTER>" --pageend="<HR></CENTER>" --columns=1 --enumerate --nolegend --prefix="/mrtg/" --output=/var/www/mrtg/index.shtml /etc/mrtg/mrtg.cfg
