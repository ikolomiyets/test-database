--liquibase formatted sql

--changeset create schema:1
CREATE TABLE department (
    id integer PRIMARY KEY,
    name varchar(40) NOT NULL
);

CREATE TABLE employee (
    id integer PRIMARY KEY,
    department_id integer NOT NULL,
    first_name varchar(40),
    last_name varchar(40) NOT NULL
);

ALTER TABLE employee ADD FOREIGN KEY (department_id) REFERENCES department (id);
