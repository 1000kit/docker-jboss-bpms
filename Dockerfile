FROM 1000kit/jboss-eap:7.0.3

MAINTAINER Dr. Stefan Tausendpfund <docker@1000kit.org>

LABEL Vendor="1000kit"
LABEL License=GPLv3
LABEL Version=1.0.0

ENV BPMS_BASE=6.4.0.GA

USER jboss

ARG BPMS_DOWNLOAD_URL

RUN echo "BPMS: ${BPMS_DOWNLOAD_URL}/jboss-bpmsuite-${BPMS_BASE}-deployable-eap7.x.zip" \   
    && curl -L ${BPMS_DOWNLOAD_URL}/jboss-bpmsuite-${BPMS_BASE}-deployable-eap7.x.zip > /tmp/jboss-bpmsuite-${BPMS_BASE}-deployable-eap7.x.zip \

    && /usr/bin/unzip -oq /tmp/jboss-bpmsuite-${BPMS_BASE}-deployable-eap7.x.zip -d ${JBOSS_BASE}/ \
    && /bin/rm /tmp/jboss-bpmsuite*.zip


#CMD /opt/jboss/server/jboss/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
CMD ["/opt/jboss/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" , "--debug"]

####END

