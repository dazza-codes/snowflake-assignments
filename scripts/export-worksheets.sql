
/*
-- https://stackoverflow.com/questions/63574808/is-there-any-option-in-snowflake-to-save-or-load-worksheets

list @~/worksheet_data;

-- Get the names of worksheets with

select name FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())) 

-- iterate through name column in your choice of scripting language and download the worksheets

get @~/worksheet_data/<name> file:///<your local location> ;
 
*/

-- this does not work in new SnowSight UI
-- https://docs.snowflake.com/en/user-guide/ui-worksheet.html#backing-up-your-own-worksheets

-- no results for this?
list @~/worksheet_data/;

select name FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

