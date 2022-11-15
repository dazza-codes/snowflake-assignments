create or replace database ASSIGNMENT7_DB;
use database ASSIGNMENT7_DB;

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

-- What is the last name of the person in the first row (id=1)?
-- Fasson

/*
-- {   "Skills": [     "PS3",     "Vlookup",     "Go"   ],   "age": 43,   "department": "Business Development",   "first_name": "Flossy",   "id": 1,   "last_name": "Fasson" }
*/

drop database ASSIGNMENT7_DB;
