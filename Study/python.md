```
# - комментарии

"""
	Многострочные
	комментарии
"""
```

- змеиный_регистр
- ВерблюжийРегистр

__Динамическая типизация__ - тип переменной не задаётся явно, а определяется интерпретатором
_Типы данных:_
- bool
- set 
- dict
- Sequence: string, tuple, list
- Numbers: int, float, complex
_Классификация типов данных:_
- Изменяемые
- Индексируемые
- Содержащие только уникальные элементы

_Побитовые операции:_
- & - Побитовое И 
- | - Побитовое ИЛИ
- ~ - Побитовое НЕ
- ^ - Побитовое исключающее ИЛИ
- << - Побитовый сдвиг влево
- >> - Побитовый сдвиг вправо

_Операторы вхождения и тожественности:_
- `in` - True, если значение входит в последовательность
- `not in` - True, если значение НЕ входит в последовательность
- `is` - True, если операторы идентичны (указывают на один объект)
- `not is` - True, , если операторы не идентичны

_Индексы и срезы:_
- Получение символа:
  `имя_перменной[индекс]`
- Срез:
  `имя_перенной[начало:конец(не включительно):шаг]`

`\` - экранирование символов
- `\n` - новая строка(перевод строки)
- `\r` - возврат каретки
- `\t` - Горизонтальная табуляция

_07.09_
# Практика 1
Все переменные являются ссылками
Объект состоит из:
- id
- тип
- значение
- счётчик ссылок

## Интерполяция и форматирование
Это ресурсозатратно:
```python
name = "John"
age = 25
job = "developer"

name + ", " + str(age) + ", " + job
```
Лучше с помощью `.format()` или `f-строк`
```python
# 1
"{name}, age, {}, {}".format(age, job, name=name)
# 2
f"{name}, age {age}, {job}"
```
Форматирование f-строк:
```python
f"{name: <20}|{age:^10}|{job:*>30}"
```
Результат:
```output
John                |    25    |*********************developer
```

_09.09_
# Лекция 2. Структуры данных. Списки

Структуры данных:
- Списки (list)
- Кортежи (tuple)
- Словари (dict)
- Множества (set)\

Списки служат, чтобы хранить объекты в определённом порядке; можно изменять в любой момент. Пример:
```python
empty_list = []
new_empty_list = list()
list = [1, 2, 3]
zero = [0] * 5
# zero = [0, 0, 0, 0, 0]
a = [1, 2, 3] * 2
# a = [1, 2, 3, 1, 2, 3]
```

__`split()`__ - разделяет строку по символу (по умолчанию - пробел) и возвращает списки
```python
today = '09/09/2024'
list_date = today.split('/')
# list_date = ['09', '09', '2024']
```

У списков есть индексы
```python
numbers = [1, '0', 23.]
print(numbers[1])
# '0'
print(numbers[-1])
# 23.0
print(numbers[0:1])
# [1, '0]
```

### Вложенные списки
```python
small_birds = ['golub', 'vorobey']
big_birds = ['eagle', 'straus']

all_birds = [small_birds, big_birds]
print(all_birds)
# [['golub', 'vorobey'], ['eagle', 'straus']]
```

### Добавление элементов:
- `numbers.append(7)` - добавление значения в конец
- `numbers += 5` - добавление значения в конец
- `numbers.extend([23, 34])` - добавить к конец другой список
- `numbers.insert(2, 5)` - вставляет элемент в указанный индекс

### Удаление элементов:
- `del numbers[3]` - удаляет по индексу
- `numbers.remove(8)` - удаляет по значения
- `numbers.clear()` - очищает индекс
- `numbers.pop(3)` - удаляет по индексу(по умолчанию последний) и возвращает удалённый элемент

### Поиск элементов:
- `numbers.index(7)` - возвращает индекс элемента\
- `numbers.count(7)` - возвращает количество данного элемента\

### Сортировка:
- `numbers.sort([key, reverse])` - сортирует список (метод)\
- `sorted(list, [key, reverse])` - возвращает отсортированный список (функция)\
key задаёт функцию сортировки\
reverse - если True, то в обратном порядке\

### Функции списков:
- `len()`
- `min()`
- `max()`
- `sum()`\

### Списочное включения
`новый_список = [*операция* for *элемент списка* in *список*]`\
Пример:
```python
old_prices = [120, 550, 410, 990] 
discount = 0.15 
new_prices = [int(product * (1 - discount)) for product in old_prices]
```

`новый список = [*операция* for *элемент списка* in *список* if *условие*]`\
Пример:
```python
numbers = [121, 544, 111, 99, 77] 
number11 = [num for num in numbers if num % 11 = 0] 
# [121, 99, 77]
```

Проверка на тип

```python
isinstance(val, int):
```

Объединение списков попарно 
```python
list1 = ['a', 'b', 'c']
list2 = [1, 2, 3]
print(list(zip(list1, list2)))
```
```output
[('a', 1), ('b', 2), ('c', 3)]
```
---




> [!Note!]  У for и while есть else
> Выполняется, если `for` или `while` закончился без `break`



> [!NOTE] Моржовый оператор
> `:=` - сравнивает условие и присваивает

# Практика 2
```python
# Бесконечность
float('inf')
# минус бесконечность
float('-inf')
```

# Лекция 3
#### Кортежи - неизменяемые списки
```python 
a = (1, 2, 3, 4, 5)
b = 6, 7, 8
c = (2,) # - кортеж из одного элемента
print(type(a), type(b))
```
```output
<class 'tuple'> <class 'tuple'>
```

#### Словарь - структура, в которой уникальные ключи связаны со значениями
Ключи должны быть неизменяемыми типами данных\

```python
student_1 = {'group': 'K0709-23/1', 'age': 17}
print(student_1['group'])
```
```output
'K0709-23/1'
```


> Метод `get()`

```python
student_1 = {'group': 'K0709-23/1', 'age': 17}
student_1.get('age')
# 17
student_1.get('course', 'no course')
# 'no course'
```
Методы 
- `keys()` - список ключей
- `values()` - список значений
- `items()` - список пар `ключ, значение`

#### Множество
Создаётся с помощью функции `set()`, работает как обычное математическое множество
- Неиндексируемый тип данных
- Содержит только уникальные значения
Операции со множествами:
- `set.union(other)` - объединение множества `set` b `other`
-  `set.intersection(other)`
- ...\
`frozenset()` - неизменяемое множество

### match/case (что-то типо switch case, но с более сложной структурой)
```python
match value:
	case 'load':
		print("Load...")
		load()
	case 'save':
		print("Save...")
		save()
	case _:
		default()
```



```python
arr = [1, 2, 4, 5, 144, 344]
for i, val in enumerate(arr):
	print(i, val)
```
```python
for i in (2**i for i in range(10)):
	print(i)
```
```output
1 
2 
4 
8 
16
32 
64 
128 
256 
512
```

# Лекция 4. Функции, пространство имён, обработок ошибок, модули
Функция:
```python
def func_name(param):
	pass
```
Функция - объект, такой же как и прочие объекты в Python
```python
def add(a, b):
	return a + b
def subtract(a, b):
	return a - b
(subtract if a > b else add)(1, 2)
```
У функции также есть атрибуты, их можно посмотреть с помощью \_\_dict\_\_
```python
def fun():
	return 0

fun.__dict__
# {}
fun.a
# 10
fun.__dict__
# {a: 10}
```
Словарь атрибутов может быть использован для кеширования промежуточных значений..\
\
Вложенные функции: 
> Внутренние функции не определены до тех пор пока не будет вызвана родительская функция

___lambda_  функция__  - Анонимная функция
__Пространство имён__ - это раздел, внутри которого имя уникально и не связано с такими же именами в других пространствах имён
_Области видимости:_
- Область встроенных имён (при import)
- Глобальная область (глобальные переменные, доступные ТОЛЬКО для ЧТЕНИЯ в функциях)
- Локальная область (локальные переменные функции, НЕ доступные для ЧТЕНИЯ в глобальной области, доступна ТОЛЬКО для ЧТЕНИЯ во внутренних функциях)


`global` - переменная будет относиться к глобальной области\ 
`nonlocal` - переменная будет относиться к области выше\
__Замыкание__ - функция, которая запоминает значение из своей внешней области видимости, даже если эта область уже недоступна
```python
def outer(x):
	def inner(y):
		return x + y
closure = outer(10)
print(closure(5))
# 15
```
## Обработка ошибок
__Исключение__ - код, который выполняется, когда происходит связанная с ним ошибка
```python
short_list = [0, 1, 2]
pos = 3
try:
	short_list[pos]
except:
	print("pos > len(list)")
```
\
```python
try:
	# code
except ValueError:
	print("...")
except IndexError as idxErr:
	print(idxErr)
except Exception as other:
	print(other)
else:
	# Код, который выполнится, если не было ошибок
finally:
	# Код, который выполнится всегда
```
## Модули 
__Модуль__ - файл. содержащий код Python
Ссылка на внешний модуль осуществляется с помощью `import`, имя файла указывается без расширения `.py`
```python
import math
print(math.pi)
``` 
\
```python
from math import pi
print(pi)
```
Псевдонимы:
```python
from random import randint as r 
```
Список модулей системы: `pip list` \
Свой модуль: просто файл в той же директории с расширением `.py`\
Модуль может определить, выполняется ли он в основной области видимости, проверив свое собственное ＿name＿ , что позволяет использовать общую идиому для условного выполнения кода в модуле, когда он выполняется как сценарий или скрипт с параметром python -m foo.py, но не при импорте import :
```python
if ＿name＿ = "＿main＿"
	main()
```
\_\_main\_\_ - это имя среды, в которой выполняется код верхнего уровня. "Код верхнего уровня" - это первый указанный пользователем модуль Python, который начинает работать. Это "верхний уровень", т.к. он импортирует все остальные модули, необходимые программе. Иногда "код верхнего уровня" называют точкой входа в приложение.

# args и kwargs
```python
*args # Можно и другое слово
**kwargs

def foo(*args):
    print(f"{args = }")
    
foo(1, 2, 3, True, "fdd")
```
```output
args = (1, 2, 3, True, 'fdd')
```
```python
def foo(**kwargs):
    print(f"{kwargs = }")

foo(a=1, b=3, c=True, d="JNdfkk")
```
```output
kwargs = {'a': 1, 'b': 3, 'c': True, 'd': 'JNdfkk'}
```
```python
def foo(pos1, *args, kw=1, **kwargs):
    print(f"{pos1 =}, {args =}, {kw = }, {kwargs = }")

foo("Pos", 1,2,3,4, kw2=2, kw3=3)
```
```output
pos1 ='Pos', args =(1, 2, 3, 4), kw = 1, kwargs = {'kw2': 2, 'kw3': 3}
```
`def foo(pos1, /, *, kw=0)` 
- `/` - конец позиционных документов
- `*` - дальше идут только ключевые 
## Подсказки 
## Входные элементы
```python
def foo(a: int): ...
def foo(a: int = 1): ...
def foo(a: int | float): ...
def foo(a: int | float = 1): ...
```
## Выходные элементы
```python
def foo(a: int) -> int | float | str: ...
```
\
```python
from typing import Union

a: list[Union[int, float]] = [1]
a
```

# Лекция 5. Генераторы и декораторы
Функция считается генератором, если: 
- Содержит одно или несколько выражений yield . 
- При вызове возвращает объект типа generator, но не начнет выполнение. 
- Методы \_\_iter()__ и \_\_next()__ реализуются автоматически. 
- После каждого вызова функция приостанавливается, а управление передается вызывающей стороне. 
- Локальные переменные и их состояния запоминаются между последовательными вызовами. 
- Когда вычисления заканчиваются по какому то условию, автоматически вызывается StopIteration
## Пример
```Python
def range_1(first=0, last=2, step=1): 
    number = first 
    while number < last: 
        yield number 
        number += step 
        
ranger = range_1() 
print(next(ranger)) 
print(next(ranger)) 
print(next(ranger))

```
## Генераторные выражения
```python
nums_squared_lc = [num**2 for num in range(5)] print(type(nums_squared_lc)) 
# <class list>
nums_squared_gc = (num**2 for num in range(5)) print(type(nums_squared_gc))
# <class generator>
```
\
> Генераторы хоть и дают существенное преимуществе в объёме памяти, могут работать значительно медленнее, чем списки

## Методы .send(), .throw(), .close()
- `.send()` - отправляет значение генератору
- `.throw()` - создаёт исключение (= raise)
- `.close()` - завершение выполнение генератора (= break)
## Декораторы
> Декораторы обвёртывают функцию, изменяя её поведение

`@wraps(func)` - нужно, чтобы выводилась информация про вызываемую функцию, а не информацию про декоратор

> [!NOTE]
>  ## zip()
>  ```python
>  for i in zip((1,2,3,4), ('a', 'b,', 'c', 'd')):
>    print(i)
>  ```
>  
>  \# (1, 'a') (2, 'b,') (3, 'c') (4, 'd')

# Лекция 6. Работа с файлами, контекстные менеджеры, структурированные текстовые файлы
- Используется относительные и абсолютные пути \
Для Windows:
- `path = r'C:\Users\...' `
- `path = 'C:\\Users\\...' ` \
Для Linux всё стандратно

`fp = open('filename')` - открытие файла \
`fp = open('filename', mode='r')` - только для чтений, варианты mode:
- r - чтение 
- w - запись
- x - эксклюзивное созданеи
- a - для добавления в конец
- + - чтение + запись
- t - текстовый режим
- b \

### Чтение
- `fp.read()` - Считать целиком, есть аргумент `size`
- `fp.readline()` -  одну строку
- `fp.readlines()` - Возвращает список строк
### Запись
- `fp.write()` - Всё записывается в одну строку, если мы сами не указываем `\n`
- `fp.writelines()` - Записывает в файл последовательность, также не добавляет `\n`

## Контекстный менеджер
```python
with open('filename') as fp:
```
```python
with EXPRASSION as TARGET:
    SUITE
```
## Структурированные текстовые файлы
### CSV - Comma-Separated Values
> Значения, разделённые запятыми (или другими символами)
```CSV
ID,Name,Date
1,Jake,20.10.24
2,John,19.10.24
```
Библиотека `csv` для python \
### XML - eXtensible Markup Language 
> "Расширяемый язык разметки"

Библиотека `xml`
### JSON - JavaScript Object Notation
> Текстовый формат обмена данными, основанный на JS
```JSON
{
    "breakfast": {
        hours: "08.00-10.00",
        "items": {
            "Eggs": "5.95",
            "Pancakes": "6.00"
        }
    },
    "launch": {
        ...
    }
}
```
Библиотека `json` \
Словарь в python с помощью функции `dumps()` переконвертировать в JSON, `loads` - обратно.

# Лекция 7
## Пакетный менеджер
`pip` - менеджер пакетов в python \
![[IMG_20241025_150805.jpg]]
## Виртуальное окружение
`pip` устанавливает пакеты глобально, что не очень хорошо. 
> Основная цель ___виртуального окружения Python___ - создание изолированной среды для python-проектов \

`venv` - строенный модуль для создания виртуальных окружений \
Создание виртуального окружения:
```terminal
python -m venv /path/to/venv
```
Традиционно директория виртуально окружения называется `.venv` или `venv` \
Активация виртуального окружения:
```terminal
source .venv/bin/activate
```
Деактивация с помощью `deactivate` \
## PEP8
# Лекция 8. Отладка кода. Логирование
## Отладка кода
**Отладка кода** - обнаружение, локализация и устранение ошибок \
- **Отладка с помощью `print()`** 
- **Отладка с помощью точек остановок**
- **Модули pdb или ipdb**
По умолчанию в VS Code есть три точки остановки:
- Expression (выражение)
- Hit count (количество срабатываний)
- Log message (лог-сообщение)
## Логирование
__Модуль logging__ - позволяет вести логи как в консоле, так и в файле. Имеете уровни деббагинга: CRITICAL, ERROR, WARNING, INFO, DEBUG, NOTSET \
# Лекция 9. Тестирование
Unittest или pytest
- Модульный 
- Интеграционный
- Системный
- Функциональный
- Subcutaneous 
```python
def test_<name test>():
    assert function() == value
```
```sh
pytest -v # подробная разница в значениях
pytest --collect-only # покажет какие тесты будут запущены
pytest -k "keyword1 or keyword2" --collect-only # Покажет тесты только содержащие keyword1 или keyword2
```

```python
import pytest
...

@pytest.mark.run_these_please # Поставили отметку "run_these_please"
def test_somebody():
    ...
```
```sh
pytest -m run_these_please # Запустит тесты только с отметками run_these_please
```
```sh
pytest /tests/test_one.py # Запуск тестов из test_one.py
pytest /tests/test_two.py::test_for_example # Заупск опредлённого теста(функции)
```

Вывод print() в какой-либо поток (по умолчанию не печатается)
```sh
pytest -s ...
# OR
pytest --capture=<method> 
```

## Ожидание Exceptions
Проверка на вызов ошибки ZeroDivisionError
```python
import pytest

def test_raises():
    with pytest.raises(ZeroDivisionError):
        1 / 0
        
```
Проверка сообщения об ошибке
```python
import pytest

def test_raises():
    with pytest.raises(ZeroDivisionError) as e:
        1 / 0
    assert str(e) == "One division Zero"
```
## Fixture
pytest.fixture - функция, выполняемая до или после тестовых функций
```python
import pytest

@pytest.fixture
def some_data():
    return 52
    
def test_some_data(some_data):
    assert some_data == 42
```
У `fixture` есть `scope`:
- `scope='function'` - выполнение перед каждой тестовой функции
- `scope='class'` - выполнение перед каждым тестовым классом
- `scope='module'` - выполнение перед каждым модулем
- `scope='session'` - выполнение один раз за сессию
## Monkeypatch
`monkeypatch` - встроенная fixture в pytest, позволяет изменять и заменять существующие объекты во время тестирования
```python
def calculate(a, b):
    delay()
    return a+b

def delay():
    print("Sleep 5 second")
    time.sleep(5)
    

def test_example(monkeypatch):
    def mock_return(): # Имитация для функции delay()
        return "Заменяющая функция"
    monkeypatch.setattr("<path_to_module>.calculate.delay", mock_return)
```

# Лекция 10. Стандартная библиотека Python
## os
> Для работы с операционной системой

Наличие файла в системе:
```python
import os
os.path.exists("hello.txt")
```
- Функции isfile и isdir - проверка что это файл или директория соответственно
- Функция getcwd - возвращает текущую директорию
**Модуль shutil**
- shutil.copy()
- shutil.move()

- os.chmod()
    - os.chmod('file.txt', 0o400)
    - os.chmod('file.txt', stat.S_IRUSR)
- os.chown() - меняет владельца или группу 
- os.path.abspath('file.txt')
- os.path.realoath('symlink.txt') # файл, который ссылается на другой, выдаёт путь настоящего файла
- os.remove('file.txt')
- os.mkdir()
- os.rmdir()
- os.listdir()
- os.chdir()
- os.walk(path) - объект генератор, выполняющий обход каталога в пути path. Возвращает кортежи формата: ("путь", директория, файлы)
- os.name - имя ОС
- os.getpid() - текущий id процесса
- os.uname()
- os.system() - выполняет системную команду
## dotenv
> Считывает пары ключ-значение из файла `.env`

```python
import os
import dotenv

dotenv.load_dotenv()
host = os.environ["HOST"]
port = os.environ.get("PORT")
address = os.environ.get("ADDRESS", default=f"{host}:8000")
```
```env
HOST=127.0.0.1
PORT=8080
ADDRESS=${HOST}:${PORT}
```

## sys
> Доступ к переменным, используемым или поддерживаемым интерпретатором 

- sys.argv - возвращает список параметров командной строки, передаваемых скрипту
    - argv[0] - название скрипта

## argparse
> Для работы с sys.argv
---
- sys.stdin()
- sys.stdout()
- sys.stderr()

