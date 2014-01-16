#!/bin/sh
#desc:Geopositioning
#type:local
#package:odevents

if ! test -z "$lat"; then
	/bin/logevent notice odevents "Positioning in [$lat-$lon]"
fi

echo "form:geopositioning.sh"
echo "	lat	Latitude	text"
echo "	lon	Longitude	text"
echo