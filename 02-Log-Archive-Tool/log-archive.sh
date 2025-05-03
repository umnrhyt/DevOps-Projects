#!/bin/bash

if [ -z "$1" ]; then
    echo "USAGE: log-archive <log-directory>"
    exit 1
fi

LOGS_DIR="$1"

if ! [ -d "$LOGS_DIR" ]; then
    echo "$LOGS_DIR doesn't exist"
    exit 1
fi

if ! [ -r "$LOGS_DIR" ]; then
    echo "Current user $USER has no permission to read the files in directory $LOGS_DIR"
    exit
fi

BASENAME_DIR=$(basename "$LOGS_DIR")
CURRENT_DATE=$(date +'%Y%m%d')
CURRENT_TIME=$(date +'%H%M%S')
LOGS_ARCHIVE_NAME="$BASENAME_DIR"_archive_"$CURRENT_DATE"_"$CURRENT_TIME".tar.gz

tar -czvf "$LOGS_ARCHIVE_NAME" "$LOGS_DIR"

echo "The logs archive $LOGS_ARCHIVE_NAME was created"

