
create or replace database ASSIGNMENT6_DB;

use database ASSIGNMENT6_DB;

-- 1. Create a table called employees with the following columns and data types:
create or replace table employees(
  customer_id int,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  age int,
  department varchar(50)
);

-- 2. Create a stage object pointing to 's3://snowflake-assignments-mc/copyoptions/example2'
create or replace stage MANAGE_DB.external_stages.copy_options2
    url='s3://snowflake-assignments-mc/copyoptions/example2';
list @MANAGE_DB.external_stages.copy_options2;

-- 3. Create a file format object with the specification
create or replace file format MANAGE_DB.file_formats.csv_delimited
    type=CSV
    field_delimiter=','
    skip_header=1;

-- 4. Use the copy option to only validate if there are errors and if yes what errors.
-- row 9 has error on CUSTOMER_ID
copy into employees
    from @MANAGE_DB.external_stages.copy_options2
    file_format=MANAGE_DB.file_formats.csv_delimited
    VALIDATION_MODE=RETURN_ERRORS;

-- line 29 of copyoptions/example2/employees_error.csv
-- User character length limit (50) exceeded by string 'Edee Antoin Lothar Marcus Frank Alexander Gustav Aurelio'

-- 5. One value in the first_name column has more than 50 characters. We assume the table column properties could not be changed.
-- What option could you use to load that record anyways and just truncate the value after 50 characters?
-- Load the data in the table using that option.
copy into employees
    from @MANAGE_DB.external_stages.copy_options2
    file_format=MANAGE_DB.file_formats.csv_delimited
    TRUNCATECOLUMNS=true;

-- Questions for this assignment
-- How many rows have been loaded?
-- 62 rows parsed and loaded with 0 errors

select * from employees;

drop database ASSIGNMENT6_DB;
