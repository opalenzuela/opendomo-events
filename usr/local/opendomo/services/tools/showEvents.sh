#!/bin/sh
#desc:Show events
#type:local
#package:odevents

LOGFILE="/var/opendomo/log/events.log"
echo "list:showEvents.sh"
if test -f $LOGFILE
then
	tail -n100 $LOGFILE |sed 's/^/\t/' |sed 's/ /-/g' |sed 's/ /\t/' | sed 's/$/\t event/'
else
	echo "#ERROR Invalid file $LOGFILE"
fi
echo
