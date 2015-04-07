if [ "x$JDBCURL" = "x" ]; then
  JDBCURL="jdbc:oracle:thin:@localhost:1521:orcl"
fi
cat /opt/jboss/datasource1.xml | grep connection-url
cat /opt/jboss/datasource.xml | sed "s/<connection-url>.*<\/connection-url>/<connection-url>$JDBCURL<\/connection-url>/" >/opt/jboss/datasource1.xml
sed -i '/<datasources>/r /opt/jboss/datasource1.xml' /opt/jboss/wildfly/standalone/configuration/standalone-full-ha.xml
cat /opt/jboss/datasource1.xml | grep connection-url
