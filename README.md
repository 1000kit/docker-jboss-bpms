# Dockerized 1000kit JBoss BPM Suite image

This repository contains `JBoss BPM Suite 6.3.0` image.



### Installed versions:

 JBoss BPM Suite 6.4.0
 
 Dependency to JBoss EAP 7.0.3

### Availability

The `Dockerfile` is available in the `trunk` branch and is built in the Docker HUB as `1000kit/jboss-bpms:6.4.0`.

## Build Image

Please download the BPM Suite 6.4.0GA deployable for JBoss EAP 7 zip package from redhat in the install directory.

Take a Dockerfile and build with the default arguments:

~~~~
$ docker build -t 1000kit/jboss-bpms:6.4.0 .
~~~~

or simply use the `build.sh` script

