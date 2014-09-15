#!/bin/sh
#desc:Update Cloud token
#package:odevents

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

UIDFILE="/etc/opendomo/uid"
uid=`cat  $UIDFILE `
source /etc/opendomo/udata/admin.info
URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&MAIL=$EMAIL"
wget -q -O /var/opendomo/tmp/refreshToken.tmp $URL 2>/dev/null
