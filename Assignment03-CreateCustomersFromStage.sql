create database if not exists EXERCISE_DB;

use database EXERCISE_DB;

create table if not exists Customers(
    ID INT,
    first_name varchar,
    last_name varchar,
    email varchar,
    age int,
    city varchar
);

list @MANAGE_DB.external_stages.file_format_stage;

copy into Customers
    from @MANAGE_DB.external_stages.file_format_stage
    file_format=(FORMAT_NAME=MANAGE_DB.file_formats.pipe_delimited);

select * from Customers;

drop database EXERCISE_DB;
