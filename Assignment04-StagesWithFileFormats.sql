// Database to manage stage objects, fileformats etc.
CREATE OR REPLACE DATABASE MANAGE_DB;

use MANAGE_DB;

CREATE OR REPLACE SCHEMA external_stages;
CREATE OR REPLACE SCHEMA file_formats;

// Creating external stage
-- CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
--     url='s3://bucketsnowflakes3'
--     credentials=(aws_key_id='ABCD_DUMMY_ID' aws_secret_key='1234abcd_key');

// Alter external stage   
-- ALTER STAGE aws_stage
-- SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');

// Publicly accessible staging areas

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.load_stage
    url='s3://snowflake-assignments-mc/loadingdata/';

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.file_format_stage
    url='s3://snowflake-assignments-mc/fileformat/';

create or replace file format MANAGE_DB.file_formats.pipe_delimited
    type=CSV
    field_delimiter='|'
    skip_header=1;

-- Description of external stages
-- DESC STAGE MANAGE_DB.external_stages.aws_stage;
-- DESC STAGE MANAGE_DB.external_stages.load_stage;
-- DESC STAGE MANAGE_DB.external_stages.file_format_stage;

-- List files in stages
-- LIST @aws_stage;
-- LIST @load_stage;
-- list @MANAGE_DB.external_stages.file_format_stage;

-- Load data using copy command
-- COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
--     FROM @aws_stage
--     file_format=(type=csv field_delimiter=',' skip_header=1)
--     pattern='.*Order.*';
