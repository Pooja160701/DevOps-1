#!/bin/bash
# Automated Backup Script (Local Version with Logging)
# Usage: bash automated_backup.sh

SRC_DIR="$HOME/DevOps-Project-1/PS-2/source_data"
DEST_DIR="$HOME/DevOps-Project-1/PS-2/backup_data"
LOG_FILE="$HOME/DevOps-Project-1/PS-2/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

echo "=== Backup started at $TIMESTAMP ===" >> "$LOG_FILE"

# Create destination if missing
mkdir -p "$DEST_DIR"

# Run rsync to copy files
rsync -av --delete "$SRC_DIR/" "$DEST_DIR/" >> "$LOG_FILE" 2>&1

# Verify success
if [ $? -eq 0 ]; then
    echo "$TIMESTAMP - Backup completed successfully" | tee -a "$LOG_FILE"
else
    echo "$TIMESTAMP - Backup failed" | tee -a "$LOG_FILE"
fi

# Optional: verify archive integrity (list files)
echo "Files currently in backup:" >> "$LOG_FILE"
ls -lh "$DEST_DIR" >> "$LOG_FILE"
echo "=== Backup finished ===" >> "$LOG_FILE"
