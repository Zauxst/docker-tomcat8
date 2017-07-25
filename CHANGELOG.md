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
