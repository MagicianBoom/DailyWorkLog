#!/bin/bash

WORK_ROOT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
WORK_LOG_FILE="$WORK_ROOT_DIR/work_log.txt"
TODAY_PENDING_WORK_FILE="$WORK_ROOT_DIR/today_pending.data"

function add_work()
{
    local work_entry=$1
    local found_match=false

    while IFS= read -r line; do
        if [ "$line" = "$work_entry" ]; then
            found_match=true
        fi
    done < "$TODAY_PENDING_WORK_FILE"

    if [ "$found_match" = false ]; then
        echo "$work_entry" >> "$TODAY_PENDING_WORK_FILE"
    fi
}

function extern_description()
{
    description=$(zenity --title="补充说明" --text "补充说明" --entry --timeout 600 --width 600 --height 100)
    if [ x"$description" != x"" ]; then
        echo "[$timenow]:【补充说明】$description" >> "$WORK_LOG_FILE"
    fi
}

if [ ! -f "$WORK_LOG_FILE" ]; then
    touch $WORK_LOG_FILE
fi

if [ ! -f "$TODAY_PENDING_WORK_FILE" ]; then
    touch $TODAY_PENDING_WORK_FILE
    echo "其他" > $TODAY_PENDING_WORK_FILE
fi

taskchoice=$(cut -d'"' -f 2 $TODAY_PENDING_WORK_FILE | sed '{x;p;x;}' | \
    zenity --list --checklist --title="选择你正在做的工作" --column="是否正在做?" --column="工作项" \
    --timeout 600 --width 600 --height 400)

timenow=$(date "+%Y-%m-%d %H:%M:%S")

# 选择其他时
[[ $taskchoice = *"其他"* ]] && {
    taskother=$(zenity --title="其他工作" --text "其他工作" --entry --timeout 600 --width 600 --height 100)

    if [ x"$taskother" != x"" ]; then
        echo "[$timenow]: $taskother" >> "$WORK_LOG_FILE"
        add_work "$taskother"
        extern_description
    fi
}

# 什么也不选时
[ x"$taskchoice" = x"" ] && {
    taskother=$(zenity --title="补充说明" --text "请输入当前工作" --entry --timeout 600 --width 600 --height 100)

    if [ x"$taskother" != x"" ]; then
        echo "[$timenow]: $taskother" >> "$WORK_LOG_FILE"
        add_work "$taskother"
        extern_description
    fi
}

# 选择除了其他外的选项
[ x"$taskchoice" != x"其他" ] && {
    if [  x"$taskchoice" != x"" ]; then
        echo "[$timenow]: $taskchoice" >> "$WORK_LOG_FILE"
        extern_description
    fi
}

