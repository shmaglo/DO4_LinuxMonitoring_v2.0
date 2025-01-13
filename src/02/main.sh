. ./check.sh
. ./make.sh

sudo cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime >/dev/null 2>&1

t=$(date +"%T")
time=$(date +%s)
if [ $# -ne 3 ]; then
        echo "ошибка: неправильное количество параметров"
        exit
fi

letters1=($(echo $2 | cut -f 1 -d '.'))
letters2=($(echo $2 | cut -f 2 -d '.'))
check $1 $2 $3
sudo touch folders_files.log
sudo chmod 777 folders_files.log
make $1 $3
