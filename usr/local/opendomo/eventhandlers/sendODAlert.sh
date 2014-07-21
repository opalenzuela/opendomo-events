#!/bin/sh
#desc:Generate an alert to the cloud
#type:redundant
#package:email

LEVEL="$1"
MODULE="$2"
URL="http://cloud.opendomo.com/alert/index.php"
TMPFILE="/var/opendomo/tmp/msgconfirmation.tmp"

TEXT=`/usr/local/bin/i18n.sh "$3" | sed 's/ /+/g'`
AUID=`cat /etc/opendomo/uid`
UMAIL=`cat /etc/opendomo/udata/admin/email`
FURL="$URL?UID=$AUID&MAIL=$UMAIL&TEXT=$TEXT&LEVEL=$LEVEL&MODULE=$MODULE"

rm -fr $TMPFILE 2>/dev/null
wget -q $FURL -O $TMPFILE 2>/dev/null
if grep -q ERROR $TMPFILE; then
        exit 1
else
        exit 0
fi