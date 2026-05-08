#!/bin/bash

DB_NAME="lesson9"
BACKUP_DIR="/opt/mysql_backup"
DATE=$(date +%Y-%m-%d_%H%M)
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${DATE}.sql.gz"

mysqldump --skip-comments --no-tablespaces --databases "$DB_NAME" | gzip > "$BACKUP_FILE"
