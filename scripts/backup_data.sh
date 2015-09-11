#!/bin/sh

if [ ! -d /backupdata ]; then
    echo "Did you mount a backup folder?"
    echo "Use '-v /path/to/backupfolder:/backupdata' while running this script!"
    exit 1
fi

tar cvf /backupdata/ts3.backup.tar .

exit 0
