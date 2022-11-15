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

copy into Customers
    from s3://snowflake-assignments-mc/gettingstarted/customers.csv
    file_format = (type = csv 
                   field_delimiter = ',' 
                   skip_header=1);

select * from Customers;

drop database EXERCISE_DB;


