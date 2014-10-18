#!/bin/sh
### BEGIN INIT INFO
# Provides:          odauto
# Required-Start:    
# Required-Stop:
# Should-Start:      
# Default-Start:     1 2 3 4 5
# Default-Stop:      0 6
# Short-Description: Cloud access service
# Description:       Cloud access service
#
### END INIT INFO
### Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

. /lib/lsb/init-functions
PIDFILE="/var/opendomo/run/token.pid"
TMPFILE="/var/opendomo/tmp/cloudaccessservice.tmp"
UIDFILE="/etc/opendomo/uid"
ADMININFO="/etc/opendomo/udata/admin.info"

do_background() {
	echo "ON" >$PIDFILE
	
	
	uid=`cat  $UIDFILE `
	#source /etc/os-release
	source $ADMININFO
		
	while test -f $PIDFILE
	do
		URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&VER=$VERSION&MAIL=$EMAIL"
		#URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&MAIL=$EMAIL"
		wget -q -O $TMPFILE $URL 2>/dev/null
		sleep 600
	done
	# Service stopped here:
	URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&MAIL=$EMAIL&ACTION=STOP"
	wget -q -O $TMPFILE $URL 2>/dev/null		
}

do_start(){
	log_action_begin_msg "Starting Cloud access service"
	$0 background > /dev/null &
	log_action_end_msg $?
}

do_stop () {
	log_action_begin_msg "Stopping Cloud access service"	
	rm $PIDFILE 2>/dev/null
	log_action_end_msg $?
}

do_status () {
	if test -f $PIDFILE; then
		echo "$basename $0 is running"
		exit 0
	else
		eche "$basename $0 is not running"
		exit 1
	fi
}

case "$1" in
	background)
		do_background
		;;
	start)
		do_start
		;;
	restart|reload|force-reload)
		do_stop
		do_start
		exit 3
		;;
	stop)
		do_stop
		exit 3
	;;
	status)
		do_status
		exit $?
		;;
	*)
		echo "Usage: $0 [start|stop|restart|status]" >&2
		exit 3
		;;
esac
