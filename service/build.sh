#!/bin/bash

mvn clean install
cp target/SimplePrimefacesApp-1.0.war app.war
docker build --rm \
--build-arg MYSQL_SERVICE_SERVICE_HOST=db \
--build-arg MYSQL_SERVICE_SERVICE_PORT=3306 \
--build-arg MYSQL_USER=test \
--build-arg MYSQL_PASSWORD=thisissecret \
--build-arg MYSQL_DATABASE=example \
-t ppaprock/prime-demo .
