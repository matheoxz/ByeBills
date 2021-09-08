-- Role: "admin-fazenda"
-- DROP ROLE "admin-fazenda";

CREATE ROLE "byebillsadm" WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'byebills123';

-- Database: ByeBills

CREATE DATABASE "ByeBills"
    WITH 
    OWNER = 'byebillsadm'
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

\c ByeBills;

CREATE TABLE users
(
    email VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    name VARCHAR(200) NOT NULL,
    password VARCHAR(100) NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (email),
    CONSTRAINT users_username_key UNIQUE (username)
)

CREATE TABLE bills
(
    id SERIAL,
    name VARCHAR(200) NOT NULL,
    description VARCHAR(500),
    payday TIMESTAMP NOT NULL,
    value DOUBLE PRECISION NOT NULL,
    barcode VARCHAR(100),
    email VARCHAR (100),
    CONSTRAINT bills_pkey PRIMARY KEY (id),
    CONSTRAINT bills_email_fkey FOREIGN KEY (email)
        REFERENCES users (email)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

GRANT ALL PRIVILEGES ON TABLE bills TO byebillsadm;

GRANT ALL PRIVILEGES ON TABLE users TO byebillsadm;