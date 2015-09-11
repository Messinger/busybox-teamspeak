#!/bin/sh
# -----------------------------------------------------------------------------
# docker-teamspeak /start script
#
# Authors: Rajko Albrecht
# Updated: Sep 11, 2015
# -----------------------------------------------------------------------------



# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak
if [ ! -f /data/ts3server.ini ]; then
    EXTRA="createinifile=1"
fi
/opt/teamspeak/ts3server_linux_amd64 logpath=/data/logs/ dbsqlpath=/opt/teamspeak/sql/ ${EXTRA}

