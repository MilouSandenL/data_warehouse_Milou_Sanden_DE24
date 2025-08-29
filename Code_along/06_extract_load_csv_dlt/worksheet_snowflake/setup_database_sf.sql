SHOW DATABASES;
-- switvh to an appropriate role
USE ROLE sysadmin;
-- set up database for Dlt csv data ingestion
-- optinal: drop database if there is one aldready
-- DROP DATABASE IF EXISTS MOVIES;
-- eller: CREATE OR REPLACE DATABASE MOVIES;
CREATE DATABASE IF NOT EXISTS MOVIES;
-- set up staging schema (om man inte är i movies, så måste man specifiera movies.staging)
-- alternatively skriva USE database movies CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS staging;
