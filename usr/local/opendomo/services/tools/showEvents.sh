#!/bin/sh
#desc:Show events
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

LOGFILE="/var/opendomo/log/events.log"
SEDFILTER='s/^/\t-/g'
PAGECOUNT=100 

if ! test -r $LOGFILE; then
        echo "#ERR: Access denied!"
        exit 1
fi

if test -z "$1" || test "$1" = "filter"; then
		echo "#> Events"
		echo "list:`basename $0`	filterable"
		case $2 in
				error)
						FILTER=' -e error -e crit '
				;;
				warn)
						FILTER=' -e warn -e error -e crit '
				;;
				notice)
						FILTER=' -e notice -e warn -e error -e crit '
				;;
				debug)
						FILTER=' -e debug -e notice -e warn -e error -e crit '
				;;				
				*)
						FILTER=' -v -e debug -e notice'
				;;
		esac
		grep $FILTER $LOGFILE | tail -n $PAGECOUNT  | sort -r  | sed $SEDFILTER 
		echo
		echo "#>Filter"
		echo "form:`basename $0`"
		echo "	type	type	hidden 	filter"
		echo "	filter	Filter	list[all,warn,notice,error,debug]	$1"
		echo "actions:"
		echo "	showEvents.sh	Apply filter"
else
	line=`grep $1 $LOGFILE | sed's/\t/@/g'`
	TIME=`echo $line | cut -f1 -d@`
	DESC=`echo $line | cut -f2 -d@`
	TYPE=`echo $line | cut -f3 -d@ | cut -f2 -d' '`
	ORIGIN=`echo $line | cut -f3 -d@ | cut -f1 -d' '`
	
	echo "#>Event information"
	echo "form:$TYPE.sh"
	echo "	time	Time	readonly	$TIME"
	echo "	type	Type	readonly	$TYPE"
	echo "	origin	Originator	readonly	$ORIGIN"
	echo "	desc	Description	readonly	$DESC"
	echo "actions:"
	echo "	goback	Back to list"
fi
echo
