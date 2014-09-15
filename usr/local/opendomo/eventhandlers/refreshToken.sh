#!/bin/sh
#desc:Update Cloud token
#package:odevents

uid=`cat  $UIDFILE `
UIDFILE="/etc/opendomo/uid"
source /etc/opendomo/udata/admin.info
URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&MAIL=$EMAIL"
wget -q -O /var/opendomo/tmp/refreshToken.tmp $URL 2>/dev/null
