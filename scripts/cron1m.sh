#!/bin/bash
iostat -x /dev/sda /dev/sdb 4 12 >> /var/log/iostat.log