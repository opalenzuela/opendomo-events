#!/bin/sh
#desc:Send e-mail
#type:redundant
#package:email

PAIR="$1-$2"
TEXT="$@"
if test -n "$4" && test -f "$4" ; then
        ATT=" -a $4"
fi

if test -f /etc/opendomo/udata/admin/email; then
        ADDRESS=`cat /etc/opendomo/udata/admin/email`
        CFGFILE="/etc/opendomo/email.conf"
        TMPFILE="/var/opendomo/tmp/email.tmp"
        if test -f /etc/opendomo/email.conf; then
                #TODO Expand the message body depending on parameters 1 and 2
                echo "$TEXT" > $TMPFILE
                cat $TMPFILE | /usr/bin/email -s"$3" -c $CFGFILE "$ADDRESS" "$ATT"
        else
                # If the e-mail client is not configured, fallback to OD Alerts
                . /usr/local/opendomo/sendODAlert.sh 
        fi
else
        exit 2
fi