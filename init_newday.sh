#!/bin/bash

LOG_FILENAME="work_log.txt"

WORK_ROOT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
DAY_WORK_LOG_FILE="$WORK_ROOT_DIR/$LOG_FILENAME"
PENDING_WORK_FILE="$WORK_ROOT_DIR/pending.data"
TODAY_PENDING_WORK_FILE="$WORK_ROOT_DIR/today_pending.data"

MONTH_DATE_SUFFIX=$(date "+%Y%m")
MONTH_LOG_FILENAME="${LOG_FILENAME%.*}_${MONTH_DATE_SUFFIX}.${LOG_FILENAME##*.}"

today_date=$(date "+%Y-%m-%d")
tomorrow_date=$(date -d tomorrow +%Y-%m-%d)

if [ -f "$DAY_WORK_LOG_FILE" ]; then
    echo "" >> $DAY_WORK_LOG_FILE
else
    touch $DAY_WORK_LOG_FILE
    echo "========================================= $date =========================================" > $DAY_WORK_LOG_FILE
    echo "" >> $DAY_WORK_LOG_FILE
fi

if [ -f "$WORK_ROOT_DIR/work_log/$MONTH_LOG_FILENAME" ]; then
    cat $DAY_WORK_LOG_FILE >> $WORK_ROOT_DIR/work_log/$MONTH_LOG_FILENAME
else
    touch $WORK_ROOT_DIR/work_log/$MONTH_LOG_FILENAME
    cat $DAY_WORK_LOG_FILE >> $WORK_ROOT_DIR/work_log/$MONTH_LOG_FILENAME
fi

echo "========================================= $tomorrow_date =========================================" > $DAY_WORK_LOG_FILE

if [ ! -f "$PENDING_WORK_FILE" ]; then
    touch $PENDING_WORK_FILE
    echo "其他" > $PENDING_WORK_FILE
fi

cp $PENDING_WORK_FILE $TODAY_PENDING_WORK_FILE

