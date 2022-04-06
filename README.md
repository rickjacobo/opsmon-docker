# opsmon
Opsmon was built with PowerShell and uses a MySQL backend, container platform (docker, kubernetes, etc), and Pager Duty for alerting and incident management.

## Requirements
- Container Platform
- MySql Database
- PagerDuty

### PagerDuty
Get Started with PagerDuty: https://support.pagerduty.com/docs/quick-start-guide
- Log in to your PagerDuty Account
  - Select the PagerDuty App/Service you would like to integrate with opsmon > add the "Events API V2" integration to the service. 
  - Obtain the "Integration Key" from the "Events API V2" integration

## Setup
### Docker Example
* Run Docker Command
````
docker run -d -e ENV_SQL_HOSTNAME="<hostname>" -e ENV_SQL_USERNAME="<username>" -e ENV_SQL_PASSWORD="<password>" -e ENV_SQL_DATABASE="<database>" -e ENV_SQL_TABLE="<table>" -e ENV_PAGERDUTY_ENDPOINT="https://events.pagerduty.com/v2/enqueue" -e ENV_PAGERDUTY_ROUTING_KEY="<pagerduty_routing_key>" --name opsmon rickjacobo/opsmon
````

### Create SQL Database and Table
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

### Add Services via CLI (Docker Example)
````
docker exec -it opsmon pwsh add.ps1 -Hostname news.google.com -Type tcp -Port 443
````

### Delete Monitored Service via CLI (Docker Example)
#### Obtain Id
docker exec -it opsmon pwsh opsquery.ps1

#### Delete Id
docker exec -it opsmon pwsh delete.ps1 -Id <id>
  
## Services
There are two example services in the database. When adding new services to monitor you only need to enter the hostname, type, and port. The id, status, alert, pagerduty_dedup, and lastupdate_utc fields are used by the app and don't need to be manually populated.
### Hostname
Enter the IP address or FQDN of the service to monitor
### Type
Enter "TCP" if you are monitoring a TCP Port or enter "ping" if you would like to perform a ping test.
  
### Port
Enter a TCP Port (ie, "443") if you are monitoring a TCP port or enter "ping" if you would like to perform a ping test.

### Example
Do not populate fields with an *

| id          | hostname         | type | port | status | alert | pagerduty_dedup | lastupdate_utc |
| ----------- | -----------      | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| *           | news.google.com  | tcp  | 443  |*            |*            |*            |*            |*            |
| *           | news.google.com  | ping | ping |*            |*            |*            |*            |*            |
