#!/bin/sh
#desc:Write to log file
USER=`whoami`
DATE=`date +"%Y-%m-%d.%H:%M:%S.%N"`
echo $DATE	$4	$USER $1-$2 $3 	$5 >> /var/opendomo/log/events.log