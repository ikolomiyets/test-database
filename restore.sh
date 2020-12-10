#!/bin/bash

/docker-entrypoint.sh postgres &
sleep 10

/usr/lib/postgresql/13/bin/psql -f /backup.sql -U postgres
/usr/lib/postgresql/13/bin/pg_ctl stop
