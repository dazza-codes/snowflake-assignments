
-- 1. Create exercise table
-- Switch to role of accountadmin

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE TESTXS;

CREATE or REPLACE DATABASE DEMO_DB;
USE DATABASE DEMO_DB;

-- Setting up UTC time for convenience
ALTER SESSION SET TIMEZONE = 'UTC';
SELECT CURRENT_TIMESTAMP;
SELECT DATEADD(DAY, 1, CURRENT_TIMESTAMP);

CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.PART
AS
SELECT * FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."PART";

SELECT * FROM PART
ORDER BY P_MFGR DESC;

SELECT CURRENT_TIMESTAMP;
-- 2022-10-29 19:57:56.725 +0000

-- 2. Update the table

UPDATE DEMO_DB.PUBLIC.PART
SET P_MFGR='Manufacturer#CompanyX'
WHERE P_MFGR='Manufacturer#5';

----> Note down query id here:  01a7f56e-0000-cbc8-0000-00030ce2720d

SELECT * FROM PART
ORDER BY P_MFGR DESC;

-- 3.1: Travel back using the offset until you get the result of before the update
SELECT * FROM PART
ORDER BY P_MFGR DESC;


-- Using time travel: Method 1 - 2 minutes back (wait for creation time + 2 mins)
SELECT * FROM PART
    AT (OFFSET => -60 * 2.0)
    ORDER BY P_MFGR DESC;

-- Using time travel: Method 2 - before timestamp
SELECT * FROM PART
    BEFORE (timestamp => '2022-10-29 19:57:56.725 +0000'::timestamp)
    ORDER BY P_MFGR DESC;

-- 3.2: Travel back using the query id to get the result before the update
SELECT * FROM PART
    BEFORE (statement => '01a7f56e-0000-cbc8-0000-00030ce2720d')
    ORDER BY P_MFGR DESC;

-- Questions for this assignment
-- How did you do it? Feel free to share the code or your experience.

DROP DATABASE DEMO_DB;
