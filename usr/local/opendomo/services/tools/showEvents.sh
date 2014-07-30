#!/bin/sh
#desc:Show events
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

LOGFILE="/var/opendomo/log/events.log"
SEDFILTER='s/^\([0-9:;]*\)\t\([a-z]*\).\([a-z]*\)\t\([^/]*\)/\t-\1-\2.\3\t\4\t\3\t\1/g'

if ! test -r $LOGFILE; then
        echo "#ERR: Access denied!"
        exit 1
fi

if test -z "$1" || test "$1" = "filter"; then
		echo "#> Events"
		echo "list:`basename $0`"
		case $2 in
				warn)
						FILTER=' -e .warn -e .error -e .crit '
				;;
				error)
						FILTER=' -e .error -e .crit '
				;;
				*)
						FILTER=' -v .debug '
				;;
		esac
		sort -r $LOGFILE | grep $FILTER | sed $SEDFILTER | head -n 100  
		echo
		echo "#>Filter"
		echo "form:`basename $0`"
		echo "	type	type	hidden 	filter"
		echo "	filter  Filter	list[all,warn,error]	$1"
		echo "actions:"
		echo "	showEvents.sh	Apply filter"
else
		echo "# Event information"
		TIME=`echo $1 | cut -f1 -d-`
		TYPE=`echo $1 | cut -f2 -d-`
		grep $TIME $LOGFILE | grep $TYPE | sed 's/^/# /'
		echo "actions:"
		echo "	showEvents.sh	Back to list"
fi
echo