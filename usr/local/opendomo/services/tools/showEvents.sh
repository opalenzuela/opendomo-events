#!/bin/sh
#desc:Show events
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

LOGFILE="/var/opendomo/log/events.log"
SEDFILTER='s/^/\t-/g'

if ! test -r $LOGFILE; then
        echo "#ERR: Access denied!"
        exit 1
fi

if test -z "$1" || test "$1" = "filter"; then
		echo "#> Events"
		echo "list:`basename $0`"
		case $2 in
				warn)
						FILTER=' -e warn -e error -e crit '
				;;
				error)
						FILTER=' -e error -e crit '
				;;
				*)
						FILTER=' -v debug '
				;;
		esac
		sort -r $LOGFILE | grep $FILTER | sed $SEDFILTER | head -n 100  
		echo
		echo "#>Filter"
		echo "form:`basename $0`"
		echo "	type	type	hidden 	filter"
		echo "	filter	Filter	list[all,warn,error]	$1"
		echo "actions:"
		echo "	showEvents.sh	Apply filter"
else
		TIME=`grep $1 $LOGFILE | cut -f1`
		DESC=`grep $1 $LOGFILE | cut -f2`
		TYPE=`grep $1 $LOGFILE | cut -f3`
		echo "#>Event information"
		echo "form:$TYPE"
		echo "	time	Time	readonly	$TIME"
		echo "	type	Type	readonly	$TYPE"
		echo "	desc	Description	readonly	$DESC"
		echo "actions:"
		echo "	goback	Back to list"
fi
echo