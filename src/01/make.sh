function make {
    ll=('' '' '' '' '' '' '')
    l=(0 0 0 0 0 0 0)
    inputl $3
    for (( i=0; i<$2; i++ ))
    do
        llfile=('' '' '' '' '' '' '')
        lfile=(0 0 0 0 0 0 0)
        inputll
        sum=$(( l[0]+l[1]+l[2]+l[3]+l[4]+l[5]+l[6] ))
        oversize
        name=$(echo $(perl -e "print '${ll[0]}' x ${l[0]}")$(perl -e "print '${ll[1]}' x ${l[1]}")$(perl -e "print '${ll[2]}' x ${l[2]}")$(perl -e "print '${ll[3]}' x ${l[3]}")$(perl -e "print '${ll[4]}' x ${l[4]}")$(perl -e "print '${ll[5]}' x ${l[5]}")$(perl -e "print '${ll[6]}' x ${l[6]}")_$(date +"%d%m%y"))
        sudo mkdir $1/$name
        sudo chmod 777 $1/$name
        echo -e "Создана папка $name: $1/$name; $(date +"%d/%m/%y")" >> folders_files.log
        checkl $3
        make_files $1 $4 $5
        (( l[0]++ ))
done
}

function oversize {
    if [ $(df / | grep '/' | awk '{split($4,a); print a[1]}') -lt 1048576 ]; then
    echo 'Недостаточно свободного места'
    exit
    fi
}

function inputl {
    for (( i=0; i<${#1}; i++))
    do
        l[i]=1
        ll[i]=$(perl -e "print '${1:$i:1}'")
    done
}

function inputll {
    for (( n=0; n<${#letters1}; n++))
        do
            lfile[n]=1
            llfile[n]=$(perl -e "print '${letters1:$n:1}'")
        done
}

function checkl {
    for (( j=1; j<${#1}; j++ ))
        do
            if [ ${l[j-1]} -eq $(( 248-$sum+${l[j-1]} )) ]; then
                l[j-1]=0
                (( l[j]++ ))
                sum=$(( l[0]+l[1]+l[2]+l[3]+l[4]+l[5]+l[6] ))
            fi
        done
}

function make_files {
    for (( k=0; k<$2; k++ ))
        do
            sumfile=$(( lfile[0]+lfile[1]+lfile[2]+lfile[3]+lfile[4]+lfile[5]+lfile[6] ))
            oversize
            name_file=$(echo $(perl -e "print '${llfile[0]}' x ${lfile[0]}")$(perl -e "print '${llfile[1]}' x ${lfile[1]}")$(perl -e "print '${llfile[2]}' x ${lfile[2]}")$(perl -e "print '${llfile[3]}' x ${lfile[3]}")$(perl -e "print '${llfile[4]}' x ${lfile[4]}")$(perl -e "print '${llfile[5]}' x ${lfile[5]}")$(perl -e "print '${llfile[6]}' x ${lfile[6]}")_$(date +"%d%m%y").$letters2)
            sudo head -c $(echo $3 | sed 's/k/K/g' | sed 's/b/B/g') /dev/zero > $1/$name/$name_file
            echo -e "Создан файл $name_file: $1/$name/$name_file; $(date +"%d/%m/%y"); $3" >> folders_files.log
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