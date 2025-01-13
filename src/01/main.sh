. ./check.sh
. ./make.sh

if [ $# -ne 6 ]; then
        echo "ошибка: неправильное количество параметров"
        exit
fi
letters1=($(echo $5 | cut -f 1 -d '.'))
letters2=($(echo $5 | cut -f 2 -d '.'))
check $1 $2 $3 $4 $5 $6
sudo touch folders_files.log
sudo chmod 777 folders_files.log
make $1 $2 $3 $4 $6