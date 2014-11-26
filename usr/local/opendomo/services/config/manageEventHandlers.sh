#!/bin/sh
#desc:Event manager
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

EHPATH="/usr/local/opendomo/eventhandlers"
EVPATH="/usr/local/opendomo/events"
ACTPATH="/etc/opendomo/actions"
CFGDIR="/etc/opendomo/eventhandlers"

EHS=""
EVENTS=""

# Loading list with available event handlers
for eh in $EHPATH/*.sh; do
	desc=`grep '#desc:' $eh | head -n1 | cut -f2 -d:`
	EHS="$EHS,$eh:$desc"
done
# ... and we add the actions !
for eh in $ACTPATH/*.action; do
	if test -f $eh; then
		desc=`grep '#desc:' $eh | head -n1 | cut -f2 -d:`
		EHS="$EHS,$eh:$desc"
	fi
done


# Loading list with defined events
for p in `ls $EVPATH/*`; do
	BN=`basename $p`
	DESC=`cat $p`
	# Discarding the already configured
	if ! test -f $EHPATH/$BN; then
		EVENTS="$EVENTS,$BN:$DESC"
	fi
done

# Two parameters: saving an eventhandler
if ! test -z "$2"; then
	EH="$CFGDIR/$1"
	BNAME=`basename $EH`
	SCRIPT=$2
	if test -x "$SCRIPT"
	then
		if ln -s "$SCRIPT" $EH
		then
			#echo "# Eventhandler [$EH] created"
			logevent notice odevents "Eventhandler [$BNAME] created"
		else
			echo "#ERR Eventhandler couldn't be created"
			logevent notice odevents "Error creating [$BNAME]"
			echo
		fi 
	else
		echo "#ERR Eventhandler not found"
		logevent notice odevents "Error creating [$BNAME]"
		echo
	fi
fi


# Listamos los EH configurados
echo "#> Installed eventhandlers"
echo "list:`basename $0`	detailed selectable"
cd $CFGDIR
for ehf in *; do
	NAME=`grep '#desc' "$ehf" |cut -f2- -d':'` 2>/dev/null
	EHFBN=`basename $ehf`
	if test -f $EVPATH/$EHFBN; then
		EVENTNAME=`cat $EVPATH/$EHFBN`
	else
		EVENTNAME="$EHFBN"
	fi
	if test -x "$ehf"; then
		echo "	$EHFBN	$EVENTNAME	eventhandler	$NAME"
	fi
done
echo "actions:"
echo "	delEventHandler.sh	Delete"
if test -x /usr/local/opendomo/manageRules.sh; then
	echo "	manageRules.sh	Manage rules"
fi
echo
echo "#> Add new eventhandler"
#ACDESC=`grep '#desc' $EHPATH/$1 | cut -f2 -d: |head -n1`
echo "form:`basename $0`"
echo "	event	Event	list[$EVENTS]	$1"
echo "	handler	Action	list[$EHS]"
echo
