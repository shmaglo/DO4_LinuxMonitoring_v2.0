function log {
    for (( i=1; i<(($(grep -c 'Создана папка' ../02/folders_files.log)+1)); i++ ))
    do
    sudo rm -rf $(grep 'Создана папка' ../02/folders_files.log | awk '{split($4,a); print a[1]}' | head -$i | tail -1 | sed 's/;//g')
    done
}