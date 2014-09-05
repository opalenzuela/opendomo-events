#!/bin/sh
#desc:Write to log file
USER=`whoami`
DATE=`date +"%Y-%m-%d.%h:%M:%S.%N"`
echo $DATE $USER $1 $2 $3 $4 $5 >> /var/opendomo/log/events.log