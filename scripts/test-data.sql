--liquibase formatted sql

--changeset test data:2 context:test_data
INSERT INTO department (id, name) VALUES (1, 'Marketing');
INSERT INTO department (id, name) VALUES (2, 'Sales');

INSERT INTO employee (id, department_id, first_name, last_name) VALUES (1, 1, 'John', 'Smith');
INSERT INTO employee (id, department_id, first_name, last_name) VALUES (2, 1, 'Diana', 'Lee');
INSERT INTO employee (id, department_id, first_name, last_name) VALUES (3, 2, 'Dave', 'Mead');
INSERT INTO employee (id, department_id, first_name, last_name) VALUES (4, 2, 'Jane', 'Kean');
