
Ubuntu 16.04, Oracle JDK 8 and Tomcat 8 based docker container.

[![](https://images.microbadger.com/badges/version/zauxst/tomcat.svg)](https://microbadger.com/images/zauxst/tomcat "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/zauxst/tomcat.svg)](https://microbadger.com/images/zauxst/tomcat "Get your own image badge on microbadger.com")


## UPDATE v0.4.2 - RC
# Big update RC
 - This update contains multiple modifications
 - Dockerfile modifications:
	* Configured ENV's for managemenet 
		- MANAGEMENT_ALLOW_REMOTE=true - in order to activate /*manager for login DEFAULT USER: admin DEFAULT PASSWORD: admin (anything else is considered false)
		- MANAGER_USER= User Defined admin USERNAME; DEFAULT=admin if nothing is set (self explenatory, might change variable for better explanation)
		- MANAGER_PASSWORD= User Defined admin PASSWORD; DEFAULT= admin if nothing is set
 	* Configured ENV's for future concept of moving the webapps folder somewhere different to not interfere with /manager (at the moment if user defines VOLUME, manager needs to be added manually and configured)
	* More testing ENV, not affecting the image overall.
	* less images to reduce te size even more.
 - Configured entrypoint.sh:
	* For the moment accepts default input start, which runs tomcat, but before doing that it checks for the above ENVs if they are configured.
 - Configured tomcat-users.xml:
	* instead of user and password admin, I've used the MANAGER_REMOTE_PASSWORD and MANAGER_REMOTE_USER to be able to identify with an ENV and replace using sed.
 - Added a CHANGELOG.md:
	* Self explenatory, need a way to format this list to keep the details.

# TODO
 * Separate developement and production img (remove vim, mc and use only the bare neceseties)
 * Configure corectly the manager application to work -- works w/o being mounted, needs fix in next update.


## Description
You should run this container on the background and mount the volume with your web app inside.

Includes:
 - Ubuntu 16.04
 - Oracle JDK 1.8.111
 - Tomcat 8.0.39
 - Git, wget, curl, build-essential, vim, mc
  
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

## A warning regarding admin user for tomcat management console
Please note that the image contains a `tomcat-users.xml` file, including an `admin` user (password `admin`). For the time being, should you wish to change that, fork this repo and modify the xml file accordingly.


## LAST 3 CHANGELOGS
# V0.3
 - Modifications to Dockerfile:
        * Configured the img to support more ENVs.

# V0.2
 - Modifications to README:
        * Modifications to reflect group ownership and the correct way to start the docker container using this img.
        * Added microbadges
        * Added updates section to reflect the last 3 updates

# V0.1
 - Added vim, mc;




ORIGINAL CREATOR : https://hub.docker.com/r/dordoka/tomcat/~/dockerfile/ 
Thanks!
