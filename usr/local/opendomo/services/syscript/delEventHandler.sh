#!/bin/sh
#desc:Delete eventhandler
#type:local
#package:odevents

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

if test -z "$1"; then
        echo "#ERROR: Eventhandler not specified"
        exit 1
fi

if test -f /etc/opendomo/eventhandlers/$1; then
        rm /etc/opendomo/eventhandlers/$1 || exit 3
        echo "#INFO:Eventhandler removed"
        /usr/local/opendomo/manageEventHandlers.sh
else
        echo "#ERROR: Eventhandler not found"
        exit 2
fi
exit
