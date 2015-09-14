#!/bin/sh

if [ ! -d /backupdata ]; then
    echo "Did you mount the backup folder?"
    echo "Use '-v /path/to/backupfolder:/backupdata' while running this script!"
    echo "and ensure folder and data inside are readable for user ID 1000"
    exit 1
fi

cd /data
tar xvf /backupdata/ts3.backup.tar

exit 0
