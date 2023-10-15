# DailyWorkLog

## Files

### init_newday.sh
Updates works for the upcoming new day and saves the day's works to the work\_log folder.

### start_work_log.sh
Generate Works dialog box.

## Usage
(1) Your linux needs to support Zenity.

(2) Creating timed works via crontab.

## Example


```
0 9-22 * * * export DISPLAY=:0 && export XMODIFIERS="@im=fcitx" && export GTK_IM_MODULE=fcitx && export QT_IM_MODULE=fcitx && path/to/start_work_log.sh.

59 23 * * * path/to/init_newday.sh
```


The crontab implements that the start_work_log.sh script is executed once a day at each full hour from 9:00 am to 22:00 pm, and the init_newday.sh script is executed once a day at 23:59 pm.
