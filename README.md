# opsmon

## Prerequisites
* Access to MySQL
* Container Platform

## Start OpsMon
* Run Docker Command
    ````
    docker run -d -e ENV_SQL_HOSTNAME="<hostname>" -e ENV_SQL_USERNAME="<username>" -e ENV_SQL_PASSWORD="<password>" -e ENV_SQL_DATABASE="<database>" -e ENV_SQL_TABLE="<table>" -e ENV_PAGERDUTY_ENDPOINT="https://events.pagerduty.com/v2/enqueue" -e ENV_PAGERDUTY_ROUTING_KEY="<pagerduty_routing_key>" --name opsmon rickjacobo/opsmon
    ````

## Create SQL Database and Table
* Obtain SQL Statement
    ````
    docker exec -it opsmon cat import.sql > import.sql
    ````

* Import SQL Statement into MySQL
    ````
    mysql -u <username> -p
    CREATE DATABASE <database>
    mysql -u <username> -p <database> < import.sql
    ````
