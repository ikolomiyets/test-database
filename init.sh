#!/bin/bash

/docker-entrypoint.sh $1 &
sleep 10

psql -v ON_ERROR_STOP=1 --username "$1" <<-EOSQL
CREATE USER test with encrypted password 'Password1';
alter user test CREATEDB;
alter user test CREATEROLE;
alter user test LOGIN;
alter user test INHERIT;
CREATE DATABASE testdb owner=test;
grant all privileges on database testdb to test;
EOSQL
