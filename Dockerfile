FROM 1000kit/jboss-eap:6.4.9

MAINTAINER Dr. Stefan Tausendpfund <docker@1000kit.org>

LABEL Vendor="1000kit"
LABEL License=GPLv3
LABEL Version=1.0.0

ENV BPMS_BASE  6.3.0.GA

USER root

ADD ./install/jboss-bpmsuite-${BPMS_BASE}-deployable-eap6.x.zip /tmp/     

# define the deployments directory as a volume that can be mounted
#VOLUME ["/opt/jboss/standalone/configuration",\
#       "/opt/jboss/standalone/log", \
#       "/opt/jboss/standalone/deployments"]
       
RUN /usr/bin/unzip -o /tmp/jboss-bpmsuite-${BPMS_BASE}-deployable-eap6.x.zip -d ${JBOSS_BASE}/ \
    && chown -R jboss:jboss ${JBOSS_HOME}/ \
    && /bin/rm /tmp/jboss-bpmsuite*.zip
 
# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
#ENV LAUNCH_JBOSS_IN_BACKGROUND true


USER jboss


#CMD /opt/jboss/server/jboss/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
CMD ["/opt/jboss/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" , "--debug"]

####END

