function timedel {
    echo "Введите дату и время начала и конца в формате: yyyy-mm-dd hh:mm:ss"
    read x
    read y
    error1=$(date --date="$(echo $x | cut -d ' ' -f 1)" +%Y-%m-%d) 2>&1
    error11=$(date --date="$(echo $x | cut -d ' ' -f 2)" +%H/%M/%S) 2>&1
    error2=$(date --date="$(echo $y | cut -d ' ' -f 1)" +%Y-%m-%d) 2>&1
    error22=$(date --date="$(echo $y | cut -d ' ' -f 2)" +%H/%M/%S) 2>&1
    if [ -z $error1 ] || [ -z $error2 ] || [ -z $error11 ] || [ -z $error22 ]; then
        exit
    fi
    date_start=$(date -d "$x" +%s)
    date_finish=$(date -d "$y" +%s)
    folders=(/etc /home /usr /usr/lib /var)
    name=$(grep 'Создана папка' ../02/folders_files.log | head -1 | tail -1 | awk '{split($3,a); print a[1]}' | sed 's/://g')
    for (( i=0; i<5; i++ ))
    do
        del_folders
        del_files
    done 
}

function month {
    if [ "$1" = Jan ]; then
        echo 01
    elif [ "$1" = Feb ]; then
        echo 02
    elif [ "$1" = Mar ]; then
        echo 03
    elif [ "$1" = Apr ]; then
        echo 04
    elif [ "$1" = May ]; then
        echo 05
    elif [ "$1" = Jun ]; then
        echo 06
    elif [ "$1" = Jul ]; then
        echo 07
    elif [ "$1" = Aug ]; then
        echo 08
    elif [ "$1" = Sep ]; then
        echo 09
    elif [ "$1" = Oct ]; then
        echo 10
    elif [ "$1" = Nov ]; then
        echo 11
    elif [ "$1" = Dec ]; then
        echo 12
    fi 
}

function del_folders {
        count=$(ls -l ${folders[i]} | grep -c $(echo $name | cut -d '_' -f 2))
        for (( j=0; j<$count; j++ ))
        do
            name2=$(ls -l ${folders[i]} | grep $(echo $name | cut -d '_' -f 2) | head -1 | tail -1 | awk '{split($9,a); print a[1]}')
            inode=$(ls -i ${folders[i]} | grep $(echo $name2 | cut -d '_' -f 2) | awk '{split($1,a); print a[1]}' | head -1 | tail -1)
            file_system=$(df ${folders[i]}/$name2 | head -2 | tail -1 | cut -d ' ' -f 1)
            date=$(sudo debugfs -R "stat <$inode>" $file_system 2>&1 | grep 'crtime' | cut -d '-' -f 3)
            date_format=$(echo $date | cut -d ' ' -f 5)-$(month $(echo $date | cut -d ' ' -f 2))-$(echo -e "$(echo $date | cut -d ' ' -f 3) $(echo $date | cut -d ' ' -f 4)")
            date_file=$(date -d "$date_format" +%s)
            if [ $date_file -ge $date_start ] && [ $date_file -le $date_finish ]; then
                sudo rm -rf ${folders[i]}/$name2
            fi
        done
}

function del_files {
    count=$(ls -l ${folders[i]} | grep -c $(echo $name | cut -d '_' -f 2))
    for (( j=0; j<$count; j++ ))
    do
        name2=$(ls -l ${folders[i]} | grep $(echo $name | cut -d '_' -f 2) | head -1 | tail -1 | awk '{split($9,a); print a[1]}')
        count2=$(ls -l ${folders[i]}/$name2 | grep -c $(echo $name | cut -d '_' -f 2))
        for (( k=0; k<$count2; k++ ))
        do
            name3=$(ls -l ${folders[i]}/$name2 | grep $(echo $name | cut -d '_' -f 2) | head -1 | tail -1 | awk '{split($9,a); print a[1]}')
            inode=$(ls -i ${folders[i]}/$name2 | grep $(echo $name3 | cut -d '_' -f 2) | awk '{split($1,a); print a[1]}' | head -1 | tail -1)
            file_system=$(df ${folders[i]}/$name2/$name3 | head -2 | tail -1 | cut -d ' ' -f 1)
            date=$(sudo debugfs -R "stat <$inode>" $file_system 2>&1 | grep 'crtime' | cut -d '-' -f 3)
            date_format=$(echo $date | cut -d ' ' -f 5)-$(month $(echo $date | cut -d ' ' -f 2))-$(echo -e "$(echo $date | cut -d ' ' -f 3) $(echo $date | cut -d ' ' -f 4)")
            date_file=$(date -d "$date_format" +%s)
            if [ $date_file -ge $date_start ] && [ $date_file -le $date_finish ]; then
                sudo rm -rf ${folders[i]}/$name2/$name3
            fi
        done
    done
}