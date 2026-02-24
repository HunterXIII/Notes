# Первая программа
Все программы начинают выполняться с функции `main`:
```go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, world!")
}
```
> `import ("fmt")` - Для импорта пакетов используется `import`  

- [[fmt]] пакет для форматирования и вывода данных

# Переменные
```go
a := 0 // Короткий тип записи (сразу кладём значение)

var b int = 10 // Длинный типа записи 
var e float64 = 0.1

// Присванивание значение по умолчанию
var c int // 0
var d string // ""


```
> Go ругается на неиспользуемые переменные!
  
Также в Go строгая статическая типизация

```go
// Можно:
score++
score--
```

# Условные ветвления
```go
if score > 20 {
    fmt.Println("Win x2")

} else if {
    fmt.Println("Win")
} else {
    fmt.Println("Lose")
}
```
Операторы **И**, **ИЛИ** и **НЕ** через `&&`, `||` и `!` 

# Циклы
## for
### Стандартный цикл
```go
for i := 1; i <= 5; i++ {
    ...
}
```

### Бесконечный цикл
Просто `for` без условий:
```go
for {
    ...
}
```
> Прерывание с помощью `break`

# Функции
```go
func foo(n int, t string) {
    ...
}
```

```go
func sum(a int, b int) int {
    return a + b
}
```

# defer
Функция, которая прописана при defer, выполнится, когда завершится функция из которой она завершится  
```go

package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello, world")
	defer func() {
		fmt.Println("Defer from main")
	}()
	fmt.Println("Continue..")
	foo()
}

func foo() {
	defer func() {
		fmt.Println("Defer from foo()")
	}()
	fmt.Println("foo func")
}

```

```output
Hello, world
Continue..
foo func
Defer from foo()
Defer from main
```
**Defer** - откладывает вызов анонимной функции в stack отложенных вызовов функции, в которой вызывается
> *Пример использования*: для закрытия подключения, например, к БД, мы просто в начале пишем defer с закрытием подключения и при любом завершении функции, **функция закрытия подключения будет вызвана**

# Указатели
```go
number := 10

pointer := &number
```
`&` - взять адрес переменной 
## Функция, которая принимает указатель
```go
func foo(n *int) { 
    fmt.Println(n) // Адрес переменной
    fmt.Println(*n) // Значение переменной
}
```
`*` - представленный тип данных это указатель
> При изменении `n`, которая является `*int` уже будет влиять на переменную, переданную в эту функцию
```go
func main() {
    a := 1
    foo(&a)
}

func foo(n *int) {
    *n = 10 // изменит переменную `a` на 10 
}
```
