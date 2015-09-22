# busybox-teamspeak

A nice and easy way to get a TeamSpeak server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on TeamSpeak and check out it's [website][1].


## Building busybox-teamspeak

Running this will build you a docker image with the latest version of both
docker-teamspeak and TeamSpeak itself.

    git clone https://git.alwin-it.de/alwin/docker-busybox-teamspeak.git
    cd docker-busybox-teamspeak
    docker build -t elektritter/busybox-teamspeak .


## Running busybox-teamspeak

Running the first time will set your port to a static port of your choice so
that you can easily map a proxy to. If this is the only thing running on your
system you can map the ports to 9987, 10011, 30033 and no proxy is needed. i.e.
`-p=9987:9987/udp  -p=10011:10011 -p=30033:30033`
    
    sudo docker run --name="teamspeak3" -d=true -p=9987:9987/udp -p=10011:10011 -p=30033:30033 elektritter/busybox-teamspeak

If you want mounted data to host filesystem make sure, your mounted directory on your host machine is already created before running:
    
    mkdir -p /mnt/teamspeak && chown 1000:1000 /mnt/teamspeak

Now run the container with mount option

    sudo docker run --name="teamspeak3" -d=true -p=9987:9987/udp -p=10011:10011 -p=30033:30033 -v=/mnt/teamspeak:/data busybox/teamspeak

From now on when you start/stop busybox-teamspeak you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `elektritter/busybox-teamspeak:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>


## Server Admin Token

You can find the server admin token in /mnt/teamspeak/logs/, search the log
files for ServerAdmin privilege key created and use that token on first connect.


### Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `elektritter/busybox-teamspeak` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`


## Maintenance

When not running with permanent mounted data folder you may get your data, too.

### Backup data

If not running with mounted data folder you can simply creating a backup from your container. (we call it hier teamspeak3)

* ensure, you stopped teamspeak3
* create a local folder, eg "tsbackup"
* ensure this folder is writeable for a user wit UID 1000, eg "chown go+rw" if you're not logged in as a user with this id
* run 

    `docker run --volumes-from teamspeak3 -v $(pwd)/tsbackup:/backupdata -ti --name=bts3 elektritter/busybox-teamspeak -b`

* remove the temporary container 

    `docker rm -v bts3`

Now you'll find inside folder "tsbackup" a tar file with TS3 database, logs, uploads etc.

### Restoring data to a new busybox-teamspeack container

* create a new container

    `docker run --name="ts3new" -d=true -p=9987:9987/udp -p=10011:10011 -p=30033:30033 elektritter/busybox-teamspeak`

* stop the container

    `docker stop ts3new`

* start the restore script with a temporary container

    `docker run --volumes-from ts3new -v $(pwd)/tsbackup:/backupdata -ti --name=bts3 elektritter/busybox-teamspeak -r`

* remove the temporary container 

    `docker rm -v bts3`

When now starting the container ts3new you'll have all backuped data inside this new container. You may remove the original container and rename ts3new to teamspeak3 if you want.