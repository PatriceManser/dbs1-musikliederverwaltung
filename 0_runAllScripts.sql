DROP DATABASE IF EXISTS audioverwaltung;
DROP ROLE IF EXISTS audioverwaltung_user;

CREATE ROLE audioverwaltung_user WITH LOGIN PASSWORD 'audioverwaltung';
CREATE DATABASE audioverwaltung OWNER audioverwaltung_user ENCODING 'UTF8';

\c audioverwaltung

\ir 2_schema.sql
\ir 3_inserts.sql
\ir 4_constraints.sql
