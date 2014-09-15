#!/bin/sh
#desc:Write to log file

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

USER=`whoami`
DATE=`date +"%Y-%m-%d.%H:%M:%S.%N"`
echo "$DATE	$3	$USER $2-$1 $4	$5" >> /var/opendomo/log/events.log
LOGSIZE=`wc -c /var/opendomo/log/events.log | cut -f1 -d' '`
if test $LOGSIZE -gt 1000000
then
	DATE=`date +"%Y%m%d"`
	mv /var/opendomo/log/events.log /var/opendomo/log/events.$DATE.log
	gzip /var/opendomo/log/events.$DATE.log
fi
