# v0.4.7 - Further Security
 - Fixed Manager, now it will work as long as it is not mounted using volumes, and it will be disabled by default if using "prod environment"
 - Added 2 new Environment rules, "dev"/"development" and "prod"/"production"(defaults to production); Developement can use manager but withouth volumes still working on it for a hack.

# v0.4.6 - Image Security
 - Working towards hardening the security of the image and marking more checks on docker-bench-security ( https://github.com/docker/docker-bench-security )
 - Changed MAINTAINER with labels.
 - erased the "add" function.
 - Started using USER Namespace:
        * Docker will not run on the user tom and the group cat (UID & GID 27300);
 - Volumes are a bit complicated to set up but they work corectly, need more details on how to set up.
        ** NOTE: If there are issues while using VOLUME with files not being deployed you can change the folder user and group which is recommended to 27300 you are mounting. (chown -R 27300:27300 /srv/tomcat)
 - Manager (Will not work and if MANAGER_ALLOW_REMOTE=true and using Volumes, it will crash the container, needs hot fix);

# v0.4.4 - Image Size + ENV configuration
 - Fixed a bug where it would append comment blocks everytime the container restarted. Used a file in host ROOT dir that is created when the container is runned for the first time, and then it skips MANAGER ENV instructions eveyrtime it's restarting the container.
 - Manager works, MANAGER_ROOT_DIR env doesn't work yet.
 - Drastically reduced the img size (see v0.4.3 which was skipped)

# V0.4.3 - image Size
 - This update focuses on img size: Reduced the image size by 300mb of uncompressed data, this update is only usable for PRODUCTION. This reduces the img size while removing important debug tools like txt editor VIM, MCEDIT)
 - Verified small functionalities, needs to be tested but pushing this img to master RC update.


## Big update RC
# V0.4.2
 - This update contains multiple modifications
 - Dockerfile modifications:
        * Configured ENV's for managemenet
                - MANAGEMENT_ALLOW_REMOTE=true - in order to activate /*manager for login DEFAULT USER: admin DEFAULT PASSWORD: admin (anything else is considered false)
                - MANAGER_USER= User Defined admin USERNAME (self explenatory, might change variable for better explanation)
                - MANAGER_PASSWORD= User Defined admin PASSWORD
        * Configured ENV's for future concept of moving the webapps folder somewhere different to not interfere with /manager (at the moment if user defines VOLUME, manager needs to be added manually and configured)
        * More testing ENV, not affecting the image overall.
        * less images to reduce te size even more.
 - Configured entrypoint.sh:
        * For the moment accepts default input start, which runs tomcat, but before doing that it checks for the above ENVs if they are configured.
 - Configured tomcat-users.xml:
        * instead of user and password admin, I've used the MANAGER_REMOTE_PASSWORD and MANAGER_REMOTE_USER to be able to identify with an ENV and replace using sed.
 - Added a CHANGELOG.md:
        * Self explenatory, need a way to format this list to keep the details.

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
[![](https://images.microbadger.com/badges/version/dordoka/tomcat.svg)](http://microbadger.com/images/dordoka/tomcat "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/dordoka/tomcat.svg)](http://microbadger.com/images/dordoka/tomcat "Get your own image badge on microbadger.com")
[![dockeri.co](http://dockeri.co/image/dordoka/tomcat)](https://registry.hub.docker.com/u/dordoka/tomcat/)
