function check {
    if ! [ -d "$1" ] || [[ $1 == */ ]]; then
        echo "ошибка: каталога не существует или каталог задан неправильно"
        exit
    elif ! [[ $2 =~ ^[0-9]+$ ]]; then
        echo "ошибка: неправильное количество папок"
        exit
    elif ! [[ $3 =~ ^[a-zA-Z]+$ ]] || [ ${#3} -gt 7 ]; then
        echo "ошибка: неправильный диапазон букв для названия папок"
        exit
    elif [ $(letters $3) -ne ${#3} ]; then
        echo "ошибка: повторяющиеся буквы в диапазоне букв для названия папок"
        exit
    elif ! [[ $4 =~ ^[0-9]+$ ]]; then
        echo "ошибка: неправильное количество файлов"
        exit
    elif  ! [[ $letters1 =~ ^[a-zA-Z]+$ ]] || ! [[ $letters2 =~ ^[a-zA-Z]+$ ]] || ! [[ $5 =~ "." ]]\
      || [ $(echo $5 | grep -o "\." | wc -l) -gt 1 ] || [ ${#letters1} -gt 7 ] || [ ${#letters2} -gt 3 ]; then
        echo "ошибка: неправильный диапазон букв для названия файлов"
        exit
    elif [ $(letters $letters1) -ne ${#letters1} ] || [ $(letters $letters2) -ne ${#letters2} ]; then
        echo "ошибка: повторяющиеся буквы в диапазоне букв для названия файлов"
        exit
    elif ! [[ ($6 =~ ^[0-9]+(Kb)$) ]]; then
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
