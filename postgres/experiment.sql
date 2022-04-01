drop database maindb;
drop database database2;
drop database database3;
drop database database4;

drop user user1;
drop user user2;
drop user user3;
drop user user4;


-- warm up

CREATE DATABASE maindb;
CREATE USER user1 with PASSWORD 'user1password';
GRANT ALL PRIVILEGES ON DATABASE maindb TO user1;

\c maindb

CREATE TABLE usertable (
    id SERIAL PRIMARY KEY,
    client_id VARCHAR(20) NOT NULL,
    api_key VARCHAR(100) NOT NULL,
    api_secret VARCHAR(100) NOT NULL,
    auth_token VARCHAR(128) NOT NULL );


-- 实验一

CREATE DATABASE database2;
CREATE USER user2 with PASSWORD 'user2password';
GRANT ALL PRIVILEGES ON DATABASE database2 TO user2;

\c database2
create schema myschema;
create table myschema.mycontacttable(
    name VARCHAR(20) NOT NULL
);


-- 实验二
CREATE DATABASE database3;
CREATE USER user3 with PASSWORD 'user3password';
GRANT ALL PRIVILEGES ON DATABASE database3 TO user3;

\c database3

create schema myschema;

CREATE TABLE myschema.contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    age Integer);

CREATE TABLE myschema.usertable (
    id SERIAL PRIMARY KEY,
    client_id VARCHAR(20) NOT NULL,
    api_key VARCHAR(100) NOT NULL,
    api_secret VARCHAR(100) NOT NULL,
    auth_token VARCHAR(128) NOT NULL );

INSERT INTO myschema.contacts (name, address, age)
VALUES
('Alice', 'Caifornia', 32),
('Bob', 'Texas', 18),
('Cathy', 'Wisconsin', 50);


CREATE OR REPLACE FUNCTION myschema.totalRecords ()
RETURNS integer AS $total$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM myschema.contacts;
   RETURN total;
END;
$total$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION myschema.totalNumbers ()
RETURNS integer AS $total$
declare
    total integer;
BEGIN
   SELECT count(*) into total FROM myschema.contacts;
   RETURN total;
END;
$total$ LANGUAGE plpgsql;

GRANT USAGE ON SCHEMA myschema TO user3;
GRANT ALL on myschema.contacts to user3;
REVOKE ALL ON FUNCTION myschema.totalRecords() from public;

-- 实验三

CREATE DATABASE database4;
CREATE USER user4 with PASSWORD 'user4password';
GRANT ALL PRIVILEGES ON DATABASE database4 TO user4;

\c database4

CREATE TABLE customersstats(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);
