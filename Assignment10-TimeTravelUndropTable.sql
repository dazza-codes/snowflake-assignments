-- 1. Create a database & Schema
CREATE DATABASE TIMETRAVEL_EXERCISE;
USE DATABASE TIMETRAVEL_EXERCISE;

CREATE SCHEMA TIMETRAVEL_EXERCISE.COMPANY_X;
USE TIMETRAVEL_EXERCISE.COMPANY_X;

-- 2. Create a customers table
CREATE TABLE CUSTOMER AS
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
LIMIT 500;

-- 3. Drop the schema (assuming it happened by accident)
DROP SCHEMA TIMETRAVEL_EXERCISE.COMPANY_X;

-- 4. Verify table doesn't exist anymore
select * from CUSTOMER;

-- 5. Undrop Schema
UNDROP SCHEMA TIMETRAVEL_EXERCISE.COMPANY_X;
USE TIMETRAVEL_EXERCISE.COMPANY_X;

select * from CUSTOMER;

-- Questions for this assignment
-- Have you been able to undrop the schema and bring back the table again?
-- Yes

DROP DATABASE TIMETRAVEL_EXERCISE;
