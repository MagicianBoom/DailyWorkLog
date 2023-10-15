#!/bin/bash

DATE_SUFFIX=$(date "+%Y%m")
LOG_FILENAME="work_log.txt"
NEW_LOG_FILENAME="${LOG_FILENAME%.*}_${DATE_SUFFIX}.${LOG_FILENAME##*.}"

WORK_ROOT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
WORK_LOG_FILE="$WORK_ROOT_DIR/$LOG_FILENAME"
PENDING_WORK_FILE="$WORK_ROOT_DIR/pending.data"

date=$(date "+%Y-%m-%d")

if [ -f "$WORK_LOG_FILE" ]; then
    echo "" >> $WORK_LOG_FILE
    echo "========================================= $date =========================================" >> $WORK_LOG_FILE
else
    touch $WORK_LOG_FILE
    echo "========================================= $date =========================================" >> $WORK_LOG_FILE
fi

if [ -f "$PENDING_WORK_FILE" ]; then
    echo "其他" > $PENDING_WORK_FILE
else
    touch $PENDING_WORK_FILE
    echo "其他" > $PENDING_WORK_FILE
fi

cp $WORK_LOG_FILE $WORK_ROOT_DIR/work_log/$NEW_LOG_FILENAME
