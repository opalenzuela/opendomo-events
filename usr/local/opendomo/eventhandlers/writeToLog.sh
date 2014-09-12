#!/bin/sh
#desc:Write to log file
USER=`whoami`
DATE=`date +"%Y-%m-%d.%H:%M:%S.%N"`
echo "$DATE	$3	$USER $2-$1 $4	$5" >> /var/opendomo/log/events.log