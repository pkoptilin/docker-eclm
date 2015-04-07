FROM jboss/wildfly

COPY init.sh /opt/jboss/init.sh
COPY datasource.xml /opt/jboss/datasource.xml

#RUN /opt/jboss/init.sh
#RUN sed -i '/<datasources>/r /opt/jboss/datasource.xml' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml 


#ADD jenkins.war /opt/jboss/wildfly/standalone/deployments/
#RUN chmod 755 -R /opt/jboss/wildfly/standalone/deployments
#RUN chown jboss:jboss -R /opt/jboss/wildfly/standalone/deployments

CMD /opt/jboss/init.sh
