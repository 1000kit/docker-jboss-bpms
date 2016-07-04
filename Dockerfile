FROM 1000kit/jboss-eap:6.4.8

MAINTAINER Dr. Stefan Tausendpfund <docker@1000kit.org>

LABEL Vendor="1000kit"
LABEL License=GPLv3
LABEL Version=1.0.0

ENV BPMS_BASE  6.3.0.GA
#ENV JBOSS_HOME /opt/jboss


USER root

ADD ./install/jboss-bpmsuite-${BPMS_BASE}-deployable-eap6.x.zip /tmp/     
RUN chown jboss:jboss /tmp/jboss-bpmsuite*

USER jboss

RUN /usr/bin/unzip -q /tmp/jboss-bpmsuite-${BPMS_BASE}-deployable-eap6.x.zip -d ${JBOSS_HOME}/ \
    && /bin/rm /tmp/jboss-bpmsuite*.zip
 
# Expose Ports 
EXPOSE 8080 9990

# define the deployments directory as a volume that can be mounted
VOLUME ["/opt/jboss/server/jboss/standalone/configuration","/opt/jboss/server/jboss/standalone/log"]
VOLUME ["/opt/jboss/server/jboss/standalone/deployments"]


# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true


#CMD /opt/jboss/server/jboss/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
CMD ["/opt/jboss/server/jboss/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0" , "--debug"]

####END

