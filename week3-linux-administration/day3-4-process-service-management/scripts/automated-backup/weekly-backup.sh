#!/bin/bash
# weekly-backup.sh - Automated backup script

BACKUP_DIR="/backup"
SOURCE_DIR="/home"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/home_backup_$DATE.tar.gz"

# Create backup directory
mkdir -p $BACKUP_DIR

# Create backup
tar -czf $BACKUP_FILE $SOURCE_DIR 2>/dev/null

# Remove backups older than 7 days
find $BACKUP_DIR -name "home_backup_*.tar.gz" -mtime +7 -delete

# Log
echo "$(date): Backup completed - $BACKUP_FILE" >> /var/log/backup.log