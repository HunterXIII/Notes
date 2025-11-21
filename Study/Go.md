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

