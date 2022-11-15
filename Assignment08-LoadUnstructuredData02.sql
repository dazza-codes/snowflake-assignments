create or replace database ASSIGNMENT8_DB;
use database ASSIGNMENT8_DB;

-- 1. Create a stage object pointing to 's3://snowflake-assignments-mc/unstructureddata/'
create or replace stage MANAGE_DB.external_stages.unstructured_data
    url='s3://snowflake-assignments-mc/unstructureddata/';

list @MANAGE_DB.external_stages.unstructured_data;

-- 2. Create a file format object that is using TYPE = JSON
create or replace file format MANAGE_DB.file_formats.json
    type=JSON;

-- 3. Create a table called JSON_RAW with one column
-- Column name: Raw
-- Column type: Variant
create or replace table JSON_RAW(
    raw Variant
);

-- 4. Copy the raw data in the JSON_RAW table using the file format object and stage object
copy into JSON_RAW
    from @MANAGE_DB.external_stages.unstructured_data
    file_format=MANAGE_DB.file_formats.json;

select * from JSON_RAW;

/*
2. Select the attributes

first_name
last_name
skills

and query these columns.
*/
SELECT
    raw:first_name::string as first_name,
    raw:last_name::string as last_name,
    raw:Skills as skills
FROM JSON_RAW;

/*
3. The skills column contains an array. Query the first two values in the skills attribute for every record in a separate column:

first_name
last_name
skills_1
skills_2
*/

SELECT
    raw:first_name::string as first_name,
    raw:last_name::string as last_name,
    raw:Skills[0]::string as skills_1,
    raw:Skills[0]::string as skills_2
FROM JSON_RAW;

-- 4. Create a table and insert the data for these 4 columns in that table.
create or replace table SKILLS as
    SELECT
        raw:first_name::string as first_name,
        raw:last_name::string as last_name,
        raw:Skills[0]::string as skills_1,
        raw:Skills[0]::string as skills_2
    FROM JSON_RAW;

select * from skills;

-- Q. What is the first skill of the person with first_name 'Florina'?
select skills_1 from skills where skills.first_name = 'Florina';
-- Hatha Yoga

drop database ASSIGNMENT8_DB;
