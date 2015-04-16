FROM jboss/wildfly

COPY module.xml /opt/jboss/wildfly/modules/oracle/jdbc/main/module.xml
COPY ojdbc6-11.2.0.3.jar /opt/jboss/wildfly/modules/oracle/jdbc/main/ojdbc6-11.2.0.3.jar

COPY init.sh /opt/jboss/init.sh
COPY datasource.xml /opt/jboss/datasource.xml
COPY cache-container.xml /opt/jboss/cache-container.xml

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent
#RUN sed -i '/<datasources>/r /opt/jboss/datasource.xml' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml

#ADD jenkins.war /opt/jboss/wildfly/standalone/deployments/

RUN /opt/jboss/init.sh

EXPOSE 9990


CMD /opt/jboss/wildfly/bin/standalone.sh --server-config standalone-full-ha.xml -b 0.0.0.0 -bmanagement 0.0.0.0
