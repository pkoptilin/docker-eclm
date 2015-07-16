if [ "x$JDBCURL" = "x" ]; then
  JDBCURL="jdbc:oracle:thin:@oracle:1521:XE"
fi
if [ "x$FULLHA" = "x" ]; then
  FULLHA="/opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml"
fi
if [ "x$CPATH" = "x" ]; then
  CPATH="/opt/jboss"
fi
#remove all comments
sed -i.bak 's/<!--.*-->//' $FULLHA


sed -i.bak "s/<connection-url>.*<\/connection-url>/<connection-url>$JDBCURL<\/connection-url>/" $CPATH/datasource.xml
sed -i.bak "/<datasources>/r $CPATH/datasource.xml" $FULLHA

sed -i.bak "s/default-stack=\"udp\"/default-stack=\"tcp\"/" $FULLHA
sed -i.bak "s/<protocol type=\"MPING\" socket-binding=\"jgroups-mping\"\/>/<protocol type=\"TCPPING\"><property name=\"initial_hosts\">localhost\[7600\]<\/property><property name=\"port_range\">0<\/property><\/protocol>/" $FULLHA

sed -i.bak 's/<cache-container name=\"web\"/<!--<cache-container name=\"web\"/' $FULLHA
sed -i.bak 's/<cache-container name=\"ejb\"/--> <cache-container name=\"ejb\"/' $FULLHA
sed -i.bak "/subsystem xmlns=\"urn:jboss:domain:infinispan:2.0\"/r $CPATH/cache-container.xml" $FULLHA

#remove messaging
sed -i.bak 's/<extension module=\"org.jboss.as.messaging\"\/>/<!-- <extension module=\"org.jboss.as.messaging\"\/> -->/' $FULLHA
sed -i.bak 's/<subsystem xmlns=\"urn:jboss:domain:messaging:2.0\"/<!-- <subsystem xmlns=\"urn:jboss:domain:messaging:2.0\"/' $FULLHA
sed -i.bak 's/<subsystem xmlns=\"urn:jboss:domain:modcluster:1.2\"/--> <subsystem xmlns=\"urn:jboss:domain:modcluster:1.2\"/' $FULLHA
