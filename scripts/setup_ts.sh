#!/bin/sh

TS_VERSION=`wget --no-check-certificate -qO - https://www.server-residenz.com/tools/ts3versions.json|grep latest|awk '{print $2}'|sed s/\"//g|sed s/,//g`
echo "Installing Teamspeak ${TS_VERSION}"
curl "http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz" -o teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz &&\
mkdir -p /opt && \
gunzip teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz &&\
tar xf teamspeak3-server_linux-amd64-${TS_VERSION}.tar &&\
mv teamspeak3-server_linux-amd64 /opt/teamspeak &&\
rm teamspeak3-server_linux-amd64-${TS_VERSION}.tar

