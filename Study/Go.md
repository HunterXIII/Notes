# Лекция 1 
_19.11.25_
## Введение

# Практика 1
_20.11.25_  
## Переменные
```go
var a int = 42
var b = 42 // будет int
c := 42 // короткое объявление, будет int
```

Объявления через `var` - создаёт **глобальную** переменную, через `:=` - **локальную** в рамках функции

```go
var numFloat float32 = 3.14
var numComlex complex64 = 1 + 2i

var str1 string = "Hello" 
fmt.Printf("str1: %T = %s\n", str1, str1)

var rune1 rune = 1071 // Юникод символ 'Я'
```
# Лекция 2
_20.11.25_
## Основная информация
**Go** - компилируемый язык

## Инициализация модуля
`go mod init example.com/mymodule` - 

## Форматирование 
`go fmt` - форматирование к стандарту

## Функции
```go
func div(a, b) (int, error) {
    if b == 0 {
        return 0, fmt.Error("divide by zero")
    }
    
    return a / b, nil
}
```
Обработка ошибка в коде:
```go
q, err = div(4, 2)
if err != nil {
    os.Exit(1)
}
```

# Лекция 3
## Строки
Строка - неизменяемая последовательность байтов
- ***Индекс и len*** - в байтах, а не по символам
- ***rune*** - символ Юникод
- range по строке выдаёт индекс в байтах

### Пакет strings
- Contains/HasPrefix/HasSufix/Index/LastIndex
- Split/Join/Repeat/Replace
- ToLower/ToUpper
### Пакет strconv
- Atoi/ParseInt/ParseFloat

## Итерация по рунам
```go
s := "Привет, Go"
for i, r := range s {
    fmt.Printf("byte=%d rune=%q code=%U\n", i, r, r)
}
```

```go
s := "набор"
fmt.Println("bytes:", len(s))
fmt.Println("runes:", len([]rune(s)))
```
## Срезы
Срез - окно на массив; содержит len, cap
- len - видимая длина, cap - ёмкость
- append - может переместить данные (реаллоцировать(выделить память типа))
  
### Создание массивов
- Литерал: `[]int{1,2,3}`
- `make([]T, len)` / `make([]T, len, cap)`
- `copy(drs, scr)` - копирование

### Итерация 
- range по индексам и значением


## map
- `map[K]V` - хэш-таблица; чтение O(1)
- Чтение/запись: `v := m[k]; m[k] = v`
- Проверка наличия: `v, ok := m[k]`  
  
## map как множество (set)
- `map[T]struct{}` - экономический set

## Срез и append/cap
```go
s := []int{1,2,3}
fmt.Println(len(s), cap(s)) // 3,3
s = append(s, 4)
fmt.Println(len(s), cap(s)) // 3,4
```

## Пример map
```go
freq := map[string]int{}
for _, w := range words {
    freq[w]++
}
```

## Советы
- не полагайтесь на порядок range по map
- заранее выделять cap

## Структуры - агрегирование данных
- Структура - набор полей с именами и типами
- Нулевые значения полей полезны для простых конструкторов
- Экспорт полей - с заглавной буквы

![[Pasted image 20251127170601.png]]
![[Pasted image 20251127170636.png]]
- `*` - ссылка на объект, можем изменять объект  
- `&` - распаковка
![[Pasted image 20251127170751.png]]
### Встраивание
```go
type Logger {
    /* ... */
}

type Service struct {
    Logger // встраивание
    Repo Repository
}
```
## Интерфейсы
- Структурная типизация
- Интерфейс принадлежит потребителю
- Малые интерфейсы лучше больших 
## Дженерики
- Уменьшить дублирование кода при одинаковой логике 
- Сохранить статическую типизацию без пустого interface
- Повысить выразительность утилитных структур/функций
```go
func Map[T any](in []T, f func(T) T) []T
```
- Тип-параметры в `[]` после имени функции/типа
### Обобщённый `Set[T]`
`type Set[T comparable] map[T]struct{}`

# Лекция 4
## Тестирование 
### Простой тест
```go
package mathx
import "testing"

func Sum(a, b int) int {return a + b}

func TestSum(t *testing.T) {
    got := Sum(2,3)
    want := 5
    if got  != want {
        t.Fatalf("Sum(2,3)=%d want %d", got, want)
    }
}
```
### Табличные тесты
```go
func Inc(x int) int {return x+1}

func TestInc(t *testing.T) {
    cases := []struct {
        name string
        in, want int
    }{
        {"zero", 0, 1},
        {"neg", -3, -2},
        {"big", 41, 42},
    }
    
    for _, tc := range cases {
        t.Run(tc.name, func(t *testing.T) {
            if got := Inc(tc.in); got != want {
                t.Fatalf("Inc(%d)=%d want %d", tc.in, got, want)
            }   
        })
    }
}
```
## Бенчмарки
- Оценить влияние изменений на производительность
- Сравнивать варианты реализации
- Найти лишние аллокации и узкие места  

