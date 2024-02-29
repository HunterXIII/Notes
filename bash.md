# Bash
- Командная оболочка, написанная на C; скриптовый, интерпретируемый язык
__Sha-Bang строка__\
#!/bin/bash путь к используемому интерпретатору.
`chmod +x name_file.sh` Дать файлу скрипта права на запуск
chmod +(добавить права) -(забрать права)
* r - read - права на чтение
* w - write - права на запись
* x - execute - права на запуск
`./name_file.sh` | `bash name_file.sh` - запуск bash-скрипта
#комментарий
- #TODO - сделать что-то
- #NOTE - заметка
    Отступы для красоты

### Переменные 
- переименованный адрес к памяти
`a=10`- объявление
`$a`  - обращение к переменной
По умолчанию всё символы и текст

### Математические операции 
- в круглых скобках
- результат с помощью $ 
`a=$(($a+1))`

### Вывод
echo текст
echo "текст с переменной $var"
echo TEXT > file - перенаправленный поток вывода

### Ввод
read user_inp

#### Выполнение команд
`result=$(cat file.txt)` - выполние команды и запись результата в переменную
result=`cat file.txt` - второй вариант, косые ковычки!

## Ветвление
```
if [[ условие ]]
then
    # код, если True
else
    # код, если False
fi
```

## Логические операции
Вместо <,>,== используются:
- -gt (greater than - больше, чем)
- -ge (greater equal - больше или равно)
- -lt (lower than - меньше, чем)
- -le (lower equal - меньше или равно)
- -eq (equal - равно)
- -ne (not equal - не равно)
- -a (and)
- -o (or)

```
for student in Ivan Petr Vasya
do
    echo "$student"
done
```
```
for student in "Ivan Ivanov" "Petr Vasya"
do
    echo "$student"
done
```
```
for student in $(cat students) #В файле обязательно пустую строчку в конце
do
    echo "$student"
done
```
```
for ((i=0; i<5; i++))
do
    echo $i
done
```
```
for ((i=0; i<5; i++))
{
    echo $i
}
```
```
i=0
while [$i -lt 5]
do
    echo $i
    i=$(($i+1))
done
```
```
while read student
do
   echo $student
done < students
```

