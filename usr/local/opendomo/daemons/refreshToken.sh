#!/bin/sh
### BEGIN INIT INFO
# Provides:          odauto
# Required-Start:    
# Required-Stop:
# Should-Start:      
# Default-Start:     1 2 3 4 5
# Default-Stop:      0 6
# Short-Description: Update Cloud token
# Description:       Update Cloud token
#
### END INIT INFO
### Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

. /lib/lsb/init-functions
PIDFILE="/var/opendomo/run/token.pid"

do_background() {
	echo "ON" >$PIDFILE
	while test -f $PIDFILE
	do
		UIDFILE="/etc/opendomo/uid"
		uid=`cat  $UIDFILE `
		source /etc/opendomo/udata/admin.info
		URL="http://cloud.opendomo.com/activate/index.php?UID=$uid&MAIL=$EMAIL"
		wget -q -O /var/opendomo/tmp/refreshToken.tmp $URL 2>/dev/null
		sleep 3600
	done
}

do_start(){
	log_action_begin_msg "Starting token service"
	$0 background > /dev/null &
	log_action_end_msg $?
}

do_stop () {
	log_action_begin_msg "Stopping token service"
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
