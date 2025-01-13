. ./log.sh
. ./timedel.sh
. ./delname.sh

sudo cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime >/dev/null 2>&1
if [ $# -ne 1 ]; then
        echo "ошибка: неправильное количество параметров"
        exit
fi

if [ $1 -eq 1 ]; then
    log
elif [ $1 -eq 2 ]; then
    timedel
elif [ $1 -eq 3 ]; then
    delname
fi
