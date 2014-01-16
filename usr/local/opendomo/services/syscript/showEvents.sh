#!/bin/sh
#desc:Show events
#type:local
#package:odevents

LOGFILE="/var/opendomo/log/events.log"
if test -f $LOGFILE
then
	tail -n100 $LOGFILE
else
	echo "#ERROR Invalid file $LOGFILE"
fi
echo
