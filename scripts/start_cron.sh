#!/bin/sh

set -eu

echo "$CRON_BACKUP_EXPRESSION supervisorctl start snapraid_runner" | crontab -

/usr/sbin/crond -f -L /dev/stdout
