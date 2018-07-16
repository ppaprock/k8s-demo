#!/bin/bash


# This file was created based on
# https://github.com/arun-gupta/docker-images/blob/master/wildfly-mysql-javaee7/customization/execute.sh

# Usage: execute.sh [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG &

echo "=> Waiting for the server to boot"
wait_for_server


$JBOSS_CLI -c << EOF
batch

set CONNECTION_URL=jdbc:mysql://$MYSQL_SERVICE_SERVICE_HOST:$MYSQL_SERVICE_SERVICE_PORT/$MYSQL_DATABASE
echo "Connection URL: " $CONNECTION_URL

# Add MySQL module
module add --name=com.mysql --resources=/opt/jboss/wildfly/customization/mysql-connector-java-8.0.11.jar --dependencies=javax.api,javax.transaction.api

# Add MySQL driver
/subsystem=datasources/jdbc-driver=mysql:add(driver-name=mysql,driver-module-name=com.mysql,driver-xa-datasource-class-name=com.mysql.cj.jdbc.MysqlXADataSource)

# Add the datasource
data-source add --name=mysqlDS --driver-name=mysql --jndi-name=java:jboss/datasources/ExampleMySQLDS --connection-url=jdbc:mysql://$MYSQL_SERVICE_SERVICE_HOST:$MYSQL_SERVICE_SERVICE_PORT/$MYSQL_DATABASE --user-name=$MYSQL_USER --password=$MYSQL_PASSWORD --use-ccm=false --max-pool-size=25 --blocking-timeout-wait-millis=5000 --enabled=true

# Execute the batch
run-batch
EOF

echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi

