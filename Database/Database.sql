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

CREATE TABLE public.bills
(
    id integer NOT NULL DEFAULT nextval('bills_id_seq'::regclass),
    name character varying(200) COLLATE pg_catalog."default" NOT NULL,
    description character varying(500) COLLATE pg_catalog."default",
    payday timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    barcode character varying(100) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT bills_pkey PRIMARY KEY (id),
    CONSTRAINT bills_email_fkey FOREIGN KEY (email)
        REFERENCES public.users (email) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.bills
    OWNER to postgres;

CREATE TABLE public.users
(
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    username character varying(100) COLLATE pg_catalog."default" NOT NULL,
    name character varying(200) COLLATE pg_catalog."default" NOT NULL,
    password character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (email),
    CONSTRAINT users_username_key UNIQUE (username)
)

TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to postgres;

GRANT ALL ON TABLE public.bills TO byebillsadm;

GRANT ALL ON TABLE public.users TO byebillsadm;