function make {
    folders=(/etc /home /usr /usr/lib /var)
    for (( k=0; k<5; k++ ))
    do
        for (( i=1; i<=100; i++ ))
        do  
            llfile=('' '' '' '' '' '' '')
            lfile=(0 0 0 0 0 0 0)
            inputll
            oversize
            name=$(perl -e "print '${1:0:1}' x $i")${1:1}_$(date +"%d%m%y")
            sudo mkdir ${folders[k]}/$name
            sudo chmod 777 ${folders[k]}/$name
            echo -e "Создана папка $name: ${folders[k]}/$name; $(date +"%d/%m/%y")" >> folders_files.log
            make_files $2 $k
            echo >> folders_files.log
        done
    done
}

function oversize {
    if [ $(df / | grep '/' | awk '{split($4,a); print a[1]}') -lt 1048576 ]; then
    echo 'Недостаточно свободного места'
    t2=$(date +"%T")
    time2=$(date +%s)
    time_work=$(( $time2 - $time ))
    echo -e "Время начала работы: $t\nВремя конца работы: $t2\nВремя работы: $time_work секунд"
    echo -e "Время начала работы: $t\nВремя конца работы: $t2\nВремя работы: $time_work" >> folders_files.log
    exit
    fi
}

function inputll {
    for (( n=0; n<${#letters1}; n++))
        do
            lfile[n]=1
            llfile[n]=$(perl -e "print '${letters1:$n:1}'")
        done
}

function make_files {
    for (( n=1; n<$(( $RANDOM+1 )); n++ ))
        do
            sumfile=$(( lfile[0]+lfile[1]+lfile[2]+lfile[3]+lfile[4]+lfile[5]+lfile[6] ))
            oversize
            name_file=$(echo $(perl -e "print '${llfile[0]}' x ${lfile[0]}")$(perl -e "print '${llfile[1]}' x ${lfile[1]}")$(perl -e "print '${llfile[2]}' x ${lfile[2]}")$(perl -e "print '${llfile[3]}' x ${lfile[3]}")$(perl -e "print '${llfile[4]}' x ${lfile[4]}")$(perl -e "print '${llfile[5]}' x ${lfile[5]}")$(perl -e "print '${llfile[6]}' x ${lfile[6]}")_$(date +"%d%m%y").$letters2)
            sudo head -c $(echo $1 | sed 's/m/M/g' | sed 's/b/B/g') /dev/zero > ${folders[$2]}/$name/$name_file
            echo -e "Создан файл $name_file: ${folders[$2]}/$name/$name_file; $(date +"%d/%m/%y"); $1" >> folders_files.log
            for (( j=1; j<${#letters1}; j++ ))
            do
                if [ ${lfile[j-1]} -eq $(( 244-$sumfile+${lfile[j-1]} )) ]; then
                    lfile[j-1]=0
                    (( lfile[j]++ ))
                    sumfile=$(( lfile[0]+lfile[1]+lfile[2]+lfile[3]+lfile[4]+lfile[5]+lfile[6] ))
                fi
            done
            (( lfile[0]++ ))
        done
}