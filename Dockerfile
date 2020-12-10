FROM postgres:13.1 as deploy

ENV POSTGRES_DRIVER_VERSION 42.2.18
ENV LIQUIBASE_VERSION 4.2.0

RUN apt-get -y update \
 && apt-get -y install default-jre

ADD https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz /liquibase/

RUN cd /liquibase \
 && gzip -dc liquibase-${LIQUIBASE_VERSION}.tar.gz | tar xvf - \
 && rm liquibase-${LIQUIBASE_VERSION}.tar.gz \
 && mkdir /app \
 && chown postgres /app

ADD entrypoint.sh /app/
ADD https://jdbc.postgresql.org/download/postgresql-${POSTGRES_DRIVER_VERSION}.jar /app/postgresql.jar
ADD scripts /app/scripts
ADD deploy.xml /app/deploy.xml

WORKDIR /app

RUN chmod 755 entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["/liquibase/liquibase", "update"]

FROM deploy as build

ENV POSTGRES_PASSWORD Password1

ADD init.sh /app/
ADD liquibase.properties /app/
RUN chmod 755 /app/init.sh /app/postgresql.jar

USER postgres

RUN /app/init.sh postgres \
    && cd /app \
    && /liquibase/liquibase --contexts=test_data update \
    && pg_dumpall > /app/backup.sql \
    && pg_ctl stop

FROM postgres:13.1

ENV POSTGRES_PASSWORD Password1

COPY --from=build /app/backup.sql /
ADD restore.sh /
RUN chmod 755 /restore.sh

USER postgres

RUN /restore.sh

USER root

RUN rm /restore.sh /backup.sql

USER postgres
