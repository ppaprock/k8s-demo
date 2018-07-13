FROM jboss/wildfly

COPY container_resources /opt/jboss/wildfly/customization/

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_SERVICE_SERVICE_HOST
ARG MYSQL_SERVICE_SERVICE_PORT

USER root
RUN chown jboss /opt/jboss/wildfly/customization/createDatasrouce.sh && \
	chown jboss /opt/jboss/wildfly/customization/mysql-connector-java-8.0.11.jar && \
	chmod +x /opt/jboss/wildfly/customization/createDatasrouce.sh

USER jboss
RUN /opt/jboss/wildfly/customization/createDatasrouce.sh && \
	/opt/jboss/wildfly/bin/add-user.sh admin abc123 --silent

ADD app.war /opt/jboss/wildfly/standalone/deployments/
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
