#!/bin/sh
#desc:Show events
#type:local
#package:odevents

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

LOGFILE="/var/opendomo/log/events.log"
echo "list:showEvents.sh"
if test -f $LOGFILE
then
	tail -n100 $LOGFILE |sed 's/^/\t-/' | sed 's/ /\t/' | sed 's/$/\t event/'
else
	echo "#ERROR Invalid file $LOGFILE"
fi
echo
