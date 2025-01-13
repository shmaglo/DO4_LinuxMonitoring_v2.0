function delname {
    folders=(/etc /home /usr /usr/lib /var)
    name=$(grep 'Создана папка' ../02/folders_files.log | head -1 | tail -1 | awk '{split($3,a); print a[1]}' | sed 's/://g')
    echo "Введите маску имени"
    read name2
    for (( i=0; i<5; i++ ))
    do
        sudo rm -rf ${folders[i]}/$name2
        count=$(ls -l ${folders[i]} | grep -c $(echo $name | cut -d '_' -f 2))
        n=9
        for (( j=1; j<=$count; j++ ))
        do
            name_file=$(echo $(ls -l ${folders[i]} | grep $(echo $name | cut -d '_' -f 2)) | cut -d ' ' -f $n)
            sudo rm -rf ${folders[i]}/$name_file/$name2*
            n=$(( n+9 ))
        done 
    done
}