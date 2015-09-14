#!/bin/sh
# -----------------------------------------------------------------------------
# docker-teamspeak /start script
#
# Authors: Rajko Albrecht
# Updated: Sep 11, 2015
# -----------------------------------------------------------------------------


ARGS=$(getopt -o ?hbri -l "help,backup,restore,import" -n "getopt.sh" -- "$@");
eval set -- "$ARGS";

#Bad arguments
if [ $? -ne 0 ];
then
  exit 1
fi

while true; do
    case $1 in
        -b|--backup)
            shift;
            /backup_data.sh
            exit $?
            ;;
        -r|--restore)
            shift;
            /restore_data.sh
            exit $?
            ;;
        --)
            shift;
            break
            ;;
    esac
done

# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak


if [ ! -f /data/ts3server.ini ]; then
    EXTRA="createinifile=1"
fi
/opt/teamspeak/ts3server_linux_amd64 logpath=/data/logs/ dbsqlpath=/opt/teamspeak/sql/ ${EXTRA}

