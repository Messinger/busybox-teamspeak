# -----------------------------------------------------------------------------
# docker-busybox-teamspeak
#
# Builds a basic docker image that can run TeamSpeak based on busybox
# (http://teamspeak.com/).
#
# Original Authors: Isaac Bythewood
# Authors: Rajko Albrecht
# Updated: Sep 11, 2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

FROM progrium/busybox

# need curl && wget
RUN opkg-install curl wget 


# Download and install TeamSpeak 3
ADD ./scripts/setup_ts.sh /setup_ts.sh
RUN sh /setup_ts.sh
RUN chown -R default /opt/teamspeak
RUN mkdir /data && chown default:default /data

# Load in all of our config files.
ADD    ./scripts/start.sh /start.sh

# Fix all permissions
RUN    chmod +x /start.sh

# /start runs it.
EXPOSE 9987/udp 10011 30033

USER default
VOLUME ["/data"]
WORKDIR /data
CMD    ["/start.sh"]

