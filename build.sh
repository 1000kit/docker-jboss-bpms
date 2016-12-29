#!/bin/bash

#
#
BVERSION=6.4.0.GA
VERSION=6.4.0
IMAGE="1000kit/jboss-bpms"

cd "$( dirname "${BASH_SOURCE[0]}" )"
pwd
. ./build_lib.sh

startHTTP=false
BPMSDownloadDir=$1
if [ -z "${BPMSDownloadDir}" ]; then
	
	BPMSDownloadDir="${HOME}/Downloads/redhat/suite6.4"	
	echo "Using ${BPMSDownloadDir} as Download dir"	
fi


if [[ ! -z "${BPMS_DOWNLOAD_URL}" ]]; then	
	echo "use provided Download URL"
else
	if [ ! -e ${BPMSDownloadDir}/jboss-bpmsuite-${BVERSION}-deployable-eap7.x.zip ]; then
		echo "!! Download BPM Suite ${BVERSION} deployable eap7 in ${BPMSDownloadDir}/jboss-bpmsuite-${BVERSION}-deployable-eap7.x.zip"
		exit
	fi
	
	LOCIP=`hostname -I | cut -d' ' -f1`
	echo $LOCIP
	
	LOCIP=`hostname -I | cut -d' ' -f1`
	
	# check if apache docker runs
	echo "Start apache Server for download"
	apacheCMD start apacheBPMS 18080 "${BPMSDownloadDir}"
	startHTTP=true
	BPMS_DOWNLOAD_URL="http://${LOCIP}:18080/Downloads/"	
	docker ps
fi
sleep 10
#curl -L ${BPMS_DOWNLOAD_URL}/jboss-bpmsuite-6.4.0.GA-deployable-eap7.x.zip > /tmp/tt
#exit
echo "build jboss BPM Suite standalone image"
docker build --build-arg BPMS_DOWNLOAD_URL="${BPMS_DOWNLOAD_URL}" --rm --force-rm -t ${IMAGE}:${VERSION} .

echo "tag image with version ${VERSION}"
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest


if [ "${startHTTP}" != "false" ]; then
	docker ps
	apacheCMD stop apacheBPMS
fi


#end
