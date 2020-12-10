#!/bin/sh

echo "changeLogFile=deploy.xml" > liquibase.properties
echo "classpath=postgresql.jar" >> liquibase.properties
echo "driver=org.postgresql.Driver" >> liquibase.properties
echo "url=$URL" >> liquibase.properties
echo "username=$USERNAME" >> liquibase.properties
echo "password=$PASSWORD" >> liquibase.properties
echo "contexts=init" >> liquibase.properties

exec "$@"