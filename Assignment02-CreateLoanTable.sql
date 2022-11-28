create database if not exists OUR_FIRST_DB;

use database OUR_FIRST_DB;

CREATE TABLE LOAN_PAYMENT (
  "Loan_ID" STRING,
  "loan_status" STRING,
  "Principal" STRING,
  "terms" STRING,
  "effective_date" STRING,
  "due_date" STRING,
  "paid_off_time" STRING,
  "past_due_days" STRING,
  "age" STRING,
  "education" STRING,
  "Gender" STRING);

//Check that table is empty
SELECT * FROM LOAN_PAYMENT;
  
COPY INTO LOAN_PAYMENT
    FROM s3://bucketsnowflakes3/Loan_payments_data.csv
    file_format = (type = csv 
                   field_delimiter = ',' 
                   skip_header = 1);

//Validate
SELECT * FROM LOAN_PAYMENT;
 
drop database OUR_FIRST_DB;
