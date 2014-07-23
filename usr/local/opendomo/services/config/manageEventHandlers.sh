#!/bin/sh
#desc:Event manager
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

EHPATH="/usr/local/opendomo/eventhandlers"

if ! test -f /usr/share/events/all-all; then
	echo "All" > /usr/share/events/all-all
fi
EHS=""
EVENTS=""

# Cargamos el listado con los EH disponibles
for eh in $EHPATH/*.sh; do
	desc=`grep '#desc:' $eh | head -n1 | cut -f2 -d:`
	EHS="$EHS,`basename $eh`:$desc"
done

# Cargamos el listado de eventos detectables
for p in `ls /usr/local/opendomo/events/*`; do
	BN=`basename $p`
	DESC=`cat $p`
	# Descartamos los ya configurados
	if ! test -f /etc/opendomo/eventhandlers/$BN; then
		EVENTS="$EVENTS,$BN:$DESC"
	fi
done

EH=$1
SCRIPT=$2
if ! test -z "$1"; then
	if test -x "$EHPATH/$SCRIPT"
	then
		if ln -s "$EHPATH/$SCRIPT" /etc/opendomo/eventhandlers/$EH
		then
			echo "# Eventhandler [$EH] created"
			/bin/logevent notice odevents "Eventhandler [$EH] created"
		else
			echo "#ERR Eventhandler couldn't be created"
			/bin/logevent notice odevents "Error creating [$EH]"
			echo
			exit 1
		fi 
	else
		echo "#ERR Eventhandler not found"
		/bin/logevent notice odevents "Error creating [$EH]"
		echo
		exit 2
	fi
fi


# Listamos los EH configurados
echo "#> Installed eventhandlers"
echo "list:`basename $0`        detailed"
for ehf in /etc/opendomo/eventhandlers/*; do
	NAME=`grep '#desc' "$ehf" |cut -f2- -d':'` 2>/dev/null
	EHFBN=`basename $ehf`
	if test -f /usr/local/opendomo/events/$EHFBN; then
		EVENTNAME=`cat /usr/local/opendomo/events/$EHFBN`
	else
		EVENTNAME="$EHFBN"
	fi
	if test -x "$ehf"; then
		echo "	$EHFBN	$EVENTNAME	eventhandler	$NAME"
	fi
done
echo "actions:"
echo "	delEventHandler.sh	Delete eventhandler"
echo
echo "#> Add new eventhandler"
ACDESC=`grep '#desc' /etc/opendomo/eventhandlers/$1 | cut -f2 -d: |head -n1`
echo "form:`basename $0`"
echo "	event	Event	list[$EVENTS]"
echo "	handler	Action	list[$EHS]"
echo