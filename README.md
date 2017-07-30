
Ubuntu 16.04, Oracle JDK 8.5.16 and Tomcat 8 based docker container.

[![](https://images.microbadger.com/badges/version/zauxst/tomcat.svg)](https://microbadger.com/images/zauxst/tomcat "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/zauxst/tomcat.svg)](https://microbadger.com/images/zauxst/tomcat "Get your own image badge on microbadger.com")


# Last Update : 
# v0.4.7 - Further Security
 - Fixed Manager, now it will work as long as it is not mounted using volumes, and it will be disabled by default if using "prod environment"
 - Added 2 new Environment rules, "dev"/"development" and "prod"/"production"(defaults to production); Developement can use manager but withouth volumes still working on it for a hack.

# TODO
 * Separate developement and production img (remove vim, mc and use only the bare neceseties)
 * Configure corectly the manager application to work -- works w/o being mounted, needs fix in next update.


## Description
You should run this container on the background and mount the volume with your web app inside.

Includes:
 - Ubuntu 16.04
 - Oracle JDK 1.8.111
 - Tomcat 8.5.16
 
 - Older versions included dev tools. I will separate this version and fork is as production have a bare minimum.
  
## Volumes
Exports a volume on `/opt/tomcat/webapps`.
You can mount the volume on run to a local directory containing your war file or exploded war directory.
If you need the management app, remember to have a copy on your hosts volume mount point.

## Ports
Two ports are exposed:

 - 8080: default Tomcat port.
  
 - 8009: default Tomcat debug port.

Remember to map the ports to the docker host on run.


# How to run the container
## Using docker
You need docker v1.3+ installed. To get the container up and running, run:
 
```
sudo docker run -d -p 8080:8080 -p 8009:8009 -v /srv/tomcat/webapps:/opt/tomcat/webapps zauxst/tomcat
```
Remember to change `/srv/tomcat/webapps` to the directory where your app is stored.

## Using docker compose
If you have `docker-compose` installed, you can just launch:

```
sudo docker-compose up
```

# Security Check
```
docker run -it --rm --net host --pid host --cap-add audit_control \
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/systemd:/usr/lib/systemd \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security
```

## A warning regarding admin user for tomcat management console
Please note that the image contains a `tomcat-users.xml` file, including an `admin` user (password `admin`). For the time being, should you wish to change that, fork this repo and modify the xml file accordingly.

#Please leave me some feedback

ORIGINAL CREATOR : https://hub.docker.com/r/dordoka/tomcat/~/dockerfile/ 
Thanks!
