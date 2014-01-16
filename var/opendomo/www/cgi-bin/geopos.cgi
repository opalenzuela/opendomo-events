#!/bin/sh
echo "Content-type: text/plain"
echo

LAT=""
LON=""

QUERY=$(echo $QUERY_STRING | sed -e 's/&/ /g')

if ! test -z "$QUERY"; then
	for param in $QUERY; do
		varname=$(echo $param | cut -f1 -d=)
		varvalue=$(echo $param | cut -f2 -d=)
		
		test "$varname" = "lon" && lat=$varvalue
		test "$varname" = "lat" && lon=$varvalue		
	done
fi

if ! test -z "$lat"; then
	/bin/logevent notice odevents "Positioning in [$lat-$lon]"
fi