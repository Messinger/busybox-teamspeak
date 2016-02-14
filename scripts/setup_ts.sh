#!/bin/sh

echo "Installing Teamspeak ${TS_VERSION}"
curl "http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2" -o teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2

mkdir -p /opt && \
bunzip2 teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 &&\
tar xf teamspeak3-server_linux_amd64-${TS_VERSION}.tar &&\
mv teamspeak3-server_linux_amd64 /opt/teamspeak &&\
rm teamspeak3-server_linux_amd64-${TS_VERSION}.tar

