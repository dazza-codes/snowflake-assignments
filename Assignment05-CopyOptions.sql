create or replace database ASSIGNMENT5_DB;

use database ASSIGNMENT5_DB;

-- 1. Create a table called employees with the following columns and data types:
create or replace table employees(
  customer_id int,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  age int,
  department varchar(50)
);

-- 2. Create a stage object pointing to 's3://snowflake-assignments-mc/copyoptions/example1'
create or replace stage MANAGE_DB.external_stages.copy_options1
    url='s3://snowflake-assignments-mc/copyoptions/example1';
list @MANAGE_DB.external_stages.copy_options1;

-- 3. Create a file format object with the specification
create or replace file format MANAGE_DB.file_formats.csv_delimited
    type=CSV
    field_delimiter=','
    skip_header=1;

-- 4. Use the copy option to only validate if there are errors and if yes what errors.
-- row 9 has error on CUSTOMER_ID
copy into employees
    from @MANAGE_DB.external_stages.copy_options1
    file_format=MANAGE_DB.file_formats.csv_delimited
    VALIDATION_MODE=RETURN_ERRORS;

-- 5. Load the data anyways regardless of the error using the ON_ERROR option. How many rows have been loaded?
-- 122 rows parsed, 121 rows loaded (row 9 has error on CUSTOMER_ID)
copy into employees
    from @MANAGE_DB.external_stages.copy_options1
    file_format=MANAGE_DB.file_formats.csv_delimited
    ON_ERROR=CONTINUE;

select * from employees;

drop database ASSIGNMENT5_DB;
