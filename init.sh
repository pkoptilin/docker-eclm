if [ "x$JDBCURL" = "x" ]; then
  JDBCURL="jdbc:oracle:thin:@oracle:1521:XE"
fi

sed -i.bak "s/<connection-url>.*<\/connection-url>/<connection-url>$JDBCURL<\/connection-url>/" /opt/jboss/datasource.xml
sed -i.bak '/<datasources>/r /opt/jboss/datasource.xml' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml

sed -i.bak "s/default-stack=\"udp\"/default-stack=\"tcp\"/" /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml
sed -i.bak "s/<protocol type=\"MPING\" socket-binding=\"jgroups-mping\"\/>/<protocol type=\"TCPPING\"><property name=\"initial_hosts\">localhost\[7600\]<\/property><property name=\"port_range\">0<\/property><\/protocol>/" /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml

sed -i.bak 's/<cache-container name=\"web\"/<!--<cache-container name=\"web\"/' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml
sed -i.bak 's/<cache-container name=\"ejb\"/--> <cache-container name=\"ejb\"/' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml
sed -i.bak '/subsystem xmlns=\"urn:jboss:domain:infinispan:2.0\"/r /opt/jboss/cache-container.xml' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml

