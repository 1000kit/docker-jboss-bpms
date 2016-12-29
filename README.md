# Dockerized 1000kit JBoss BPM Suite image

This repository contains `JBoss BPM Suite 6.4.0` image.



### Installed versions:

 JBoss BPM Suite 6.4.0

 Dependency to JBoss EAP 7.0.3

### Availability

The `Dockerfile` is available in the `trunk` branch and is built in the Docker HUB as `1000kit/jboss-bpms:6.4.0`.

## Build Image

Please download the  BPM Suite 6.4.0GA deployable for JBoss EAP 7 zip package from redhat.

Take a Dockerfile and build with the default arguments:
* BPMS_DOWNLOAD_URL: download http url where bpms deployable for JBoss EAP 7 is downloaded
 
~~~~
$ docker 	build --build-arg BPMS_DOWNLOAD_URL="${BPMS_DOWNLOAD_URL}" --rm --force-rm -t 1000kit/jboss-bpms:6.4.0 .
~~~~

or simply use the `build.sh` script. This will start the `1000kit/apache` server for download if necessary.

* Use Default download dir: `~/Downloads/redhat/suite6.4` used by apache server for download
~~~~
$ build.sh
~~~~

* alternative path used by apache server
~~~~
$ build.sh /opt/downloads
~~~~

* use external download URL:
~~~~
$ export BPMS_DOWNLOAD_URL=https://<host>/<link>
$ build.sh
~~~~

## run
~~~~
$ docker run -it 1000kit/jboss-bpms:6.4.0
~~~~
