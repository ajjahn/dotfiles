#!/usr/bin/env bash

WATCH_DIR="/etc/codex"
BACKUP_DIR="/etc/codex.bak"

while true; do
    if [ -d "$WATCH_DIR" ]; then
        echo "Directory found: $WATCH_DIR"

        # Remove old backup if it exists
        if [ -e "$BACKUP_DIR" ]; then
            rm -rf "$BACKUP_DIR"
        fi

        mv "$WATCH_DIR" "$BACKUP_DIR"
        echo "Moved $WATCH_DIR to $BACKUP_DIR"
    fi

    sleep 5
done
