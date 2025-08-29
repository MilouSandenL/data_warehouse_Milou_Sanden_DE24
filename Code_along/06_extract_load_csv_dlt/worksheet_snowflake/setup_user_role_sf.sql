-- switch to an appropriate role
USE ROLE USERADMIN;
--create dlt user (om man är säker på att den inte finns så behöver man inte skriva IF NOT EXISTS)
CREATE USER IF NOT EXISTS extract_loader
    PASSWORD = '12345ABCDE'
    DEFAULT_WAREHOUSE = COMPUTE_WH;
-- create dlt role
-- om det redan finns en roll med namnet så: DROP ROLE movies_dlt_role;
CREATE ROLE IF NOT EXISTS movies_dlt_role;

-- switch to an appropriate role to grant privilages to role and grant role to user
USE ROLE SECURITYADMIN;
-- grant role to user
GRANT ROLE movies_dlt_role TO USER extract_loader;
-- grant privileges to a role
-- this role need to use warehouse, database and schema
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE movies_dlt_role;
GRANT USAGE ON DATABASE movies TO ROLE movies_dlt_role;
GRANT USAGE ON SCHEMA movies.staging TO ROLE movies_dlt_role;
-- this role need some special usage for the database and schema
GRANT CREATE TABLE ON SCHEMA movies.staging TO ROLE movies_dlt_role;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA movies.staging TO ROLE movies_dlt_role;
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA movies.staging TO ROLE movies_dlt_role;

-- check if the user and role is created and the grants are in place
SHOW GRANTS TO ROLE movies_dlt_role;
