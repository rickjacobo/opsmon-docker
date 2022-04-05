FROM mcr.microsoft.com/powershell:alpine-3.10
RUN apk add --no-cache mysql-client
RUN mkdir /powershell
ENV ENV_SQL_HOSTNAME="127.0.0.1"
ENV ENV_SQL_USERNAME="username"
ENV ENV_SQL_PASSWORD="password"
ENV ENV_SQL_DATABASE="opsmon"
ENV ENV_SQL_TABLE="opsmon"
ENV ENV_PAGERDUTY_ENDPOINT="https://events.pagerduty.com/v2/enqueue"
ENV ENV_PAGERDUTY_ROUTING_KEY="1234567890"
ENV ENV_POLL_FREQUENCY_SECONDS="60"
RUN touch /powershell/.config
WORKDIR /powershell
COPY config.ps1 /powershell
COPY opsmon.ps1 /powershell
COPY opsquery.ps1 /powershell
COPY add.ps1 /powershell
COPY delete.ps1 /powershell
CMD pwsh config.ps1 && pwsh opsmon.ps1
