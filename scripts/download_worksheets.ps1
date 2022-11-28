
# Assume Snowsight-Extensions are unzipped to ~/src/SnowflakePS/SnowflakePS.psd1
# https://github.com/Snowflake-Labs/sfsnowsightextensions
# https://github.com/Snowflake-Labs/sfsnowsightextensions/releases/download/2022.7.31.0/SnowflakePS.osx.2022.7.31.0.zip

Import-Module ~/src/snowflake/SnowflakePS/SnowflakePS.psd1

# Example account variables:
# Account 'WQSGQER-BN01869' in region 'us-east-1.aws' is accessible at
# 'https://pk74481.us-east-1.aws.snowflakecomputing.com' and served by application
# server 'https://apps-api.c1.us-east-1.aws.app.snowflake.com' in
# main application 'https://app.snowflake.com'

$sfAccount = "pk74481.us-east-1.aws"

$sfUserName = "YourUserName"
$sfPassword = ConvertTo-SecureString -String "YourPassword" -AsPlainText

$appContext = Connect-SFApp -Account ${sfAccount} -UserName ${sfUserName} -Password ${sfPassword}
$appContext | ConvertTo-JSON | Out-File ~/bin/SnowflakePS.AppUserContext.$sfAccount.json

$worksheets = Get-SFWorksheets -AuthContext $appContext
$worksheets | foreach {$_.SaveToFolder("/tmp")}
