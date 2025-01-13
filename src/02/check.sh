function check {
    if ! [[ $1 =~ ^[a-zA-Z]+$ ]] || [ ${#1} -gt 7 ]; then
        echo "ошибка: неправильный диапазон букв для названия папок"
        exit
    elif [ $(letters $1) -ne ${#1} ]; then
        echo "ошибка: повторяющиеся буквы в диапазоне букв для названия папок"
        exit
    elif  ! [[ $letters1 =~ ^[a-zA-Z]+$ ]] || ! [[ $letters2 =~ ^[a-zA-Z]+$ ]] || ! [[ $2 =~ "." ]]\
      || [ $(echo $2 | grep -o "\." | wc -l) -gt 1 ] || [ ${#letters1} -gt 7 ] || [ ${#letters2} -gt 3 ]; then
        echo "ошибка: неправильный диапазон букв для названия файлов"
        exit
    elif [ $(letters $letters1) -ne ${#letters1} ] || [ $(letters $letters2) -ne ${#letters2} ]; then
        echo "ошибка: повторяющиеся буквы в диапазоне букв для названия файлов"
        exit
    elif ! [[ $3 =~ ^-?([0-9]*[.])?[0-9]+mb$|MB$|Mb$ ]] || [ $(echo "$(echo $3 | sed 's/mb//' | sed 's/MB//' | sed 's/Mb//') > 100" | bc ) -eq 1 ]; then
        echo "ошибка: неправильно задан размер файлов"
        exit
    fi
}

function letters {
    count=0
    str=$1
    while [ ${#str} -ne 0 ]
    do  
        str=$(echo $str | sed "s/${str:0:1}//g")
        (( count++ ))
    done
    echo $count
}
