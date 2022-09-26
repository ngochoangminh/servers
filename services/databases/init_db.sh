#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" << SQL
CREATE DATABASE user_db;
CREATE USER user_service WITH ENCRYPTED PASSWORD '$USER_DB_PASS';
GRANT ALL PRIVILEGES ON DATABASE user_db TO user_service;
SQL