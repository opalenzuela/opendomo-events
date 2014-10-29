#!/bin/sh
#desc:Show prompted events
#type:local
#package:odevents
 
# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

PROMPTFILE="/var/www/data/prompts.txt"
SEDFILTER='s/^/\t-/g'

echo "#> Events"
echo "list:`basename $0`	" #filterable
cat $PROMPTFILE  | sed $SEDFILTER 
echo
